#!/usr/bin/env bash
# Claude Code Notification hook: sends an ntfy notification with a session recap.
# See Explorations/Claude Code ntfy notification hook/spec.md in homelab-vault.

set -uo pipefail

CURL_BIN="${CURL_BIN:-curl}"

log() { echo "[ntfy-notify] $*" >&2; }

# Skip if user is actively viewing our tmux pane (active pane in active window of an attached session).
if [[ -n "${TMUX:-}" && -n "${TMUX_PANE:-}" ]] && command -v tmux >/dev/null 2>&1; then
  read -r pane_active window_active session_attached < <(
    tmux display-message -p -t "$TMUX_PANE" -F '#{pane_active} #{window_active} #{session_attached}' 2>/dev/null
  )
  if [[ "$pane_active" == "1" && "$window_active" == "1" \
        && "$session_attached" =~ ^[0-9]+$ && "$session_attached" -gt 0 ]]; then
    exit 0
  fi
fi

: "${NTFY_TOKEN:=}"
if [[ -z "$NTFY_TOKEN" ]]; then
  exit 0
fi

: "${NTFY_URL:=}"
if [[ -z "$NTFY_URL" ]]; then
  exit 0
fi

if ! command -v jq >/dev/null 2>&1; then
  log "jq not found; skipping"
  exit 0
fi
if ! command -v "$CURL_BIN" >/dev/null 2>&1; then
  log "$CURL_BIN not found; skipping"
  exit 0
fi

payload="$(cat)"
if ! message="$(jq -r '.message // empty' <<<"$payload" 2>/dev/null)"; then
  log "malformed stdin json; skipping"
  exit 0
fi
transcript="$(jq -r '.transcript_path // empty' <<<"$payload" 2>/dev/null || true)"

# Suppress while this session's own subagents are still working: notify only once
# the main agent is truly idle. Two kinds of subagent have to be counted, because
# they signal completion differently:
#
#   Foreground — the Agent (or legacy Task) tool_use has no matching tool_result
#     until the subagent reports back, so an unmatched id means it is still out.
#
#   Background — the tool_use is answered within seconds by a launch receipt, so
#     the pairing above always reads as finished. Track these by agent id instead:
#     a launch (toolUseResult.status == "async_launched") or a wake-up
#     (toolUseResult.resumedAgentId) starts a run, and the task-notification queued
#     when the agent stops ends it. An agent is out whenever its newest start is
#     newer than its newest stop.
#
# All four signals are read from structured fields rather than by grepping the
# transcript: tool output that quotes a launch receipt or a task-notification —
# which happens whenever a session inspects its own transcript — would otherwise
# be counted as a live subagent and silence the session for good.
if [[ -n "$transcript" && -r "$transcript" ]]; then
  running="$(jq -n '
    reduce inputs as $l ({ started: {}, stopped: {}, used: {}, done: {} };
      ($l.timestamp // "") as $ts
      | (if ($l.toolUseResult | type) == "object" then $l.toolUseResult else {} end) as $r
      | (if $r.status == "async_launched" and ($r.agentId | type) == "string" then $r.agentId
         elif ($r.resumedAgentId | type) == "string" then $r.resumedAgentId
         else null end) as $start
      | (if $l.type == "queue-operation" and $l.operation == "enqueue"
            and (($l.content // "") | test("<task-notification>"))
         then ([$l.content | capture("<task-id>(?<id>[^<]+)</task-id>")] | first | .id? // null)
         else null end) as $stop
      | (if $start then .started[$start] = ([.started[$start] // "", $ts] | max) else . end)
      | (if $stop then .stopped[$stop] = ([.stopped[$stop] // "", $ts] | max) else . end)
      | (if ($l.message | type) == "object" and ($l.message.content | type) == "array"
         then reduce $l.message.content[] as $b (.;
                if $b.type == "tool_use" and ($b.name == "Agent" or $b.name == "Task")
                then .used[$b.id] = true
                elif $b.type == "tool_result" and ($b.tool_use_id | type) == "string"
                then .done[$b.tool_use_id] = true
                else . end)
         else . end))
    | . as $s
    | ([$s.started | to_entries[] | select(.value > ($s.stopped[.key] // ""))] | length)
      + ([$s.used | keys_unsorted[] | select($s.done[.] | not)] | length)
  ' "$transcript" 2>/dev/null || echo 0)"
  if [[ "$running" =~ ^[0-9]+$ && "$running" -gt 0 ]]; then
    log "suppressing: $running subagent(s) still running"
    exit 0
  fi
fi

title="Claude Code"
body="$message"

normalise() {
  # $1 = raw string, $2 = max length
  local s="$1" n="$2"
  s="$(printf '%s' "$s" | sed -E 's#^/[^ ]+ *##')"
  s="$(printf '%s' "$s" | tr '\n\t' '  ')"
  if (( ${#s} > n )); then
    s="${s:0:n}"
    # strip trailing spaces before appending ellipsis
    while [[ "$s" == *' ' ]]; do s="${s% }"; done
    s="${s}…"
  fi
  printf '%s' "$s"
}

if [[ -n "$transcript" && -r "$transcript" ]]; then
  turns="$(jq -s 'map(select(.type=="last-prompt")) | length' "$transcript" 2>/dev/null || echo 0)"
  if [[ "$turns" =~ ^[0-9]+$ && "$turns" -gt 0 ]]; then
    first_raw="$(jq -rs 'map(select(.type=="last-prompt"))[0].lastPrompt // ""' "$transcript" 2>/dev/null)"
    latest_raw="$(jq -rs 'map(select(.type=="last-prompt"))[-1].lastPrompt // ""' "$transcript" 2>/dev/null)"
    first="$(normalise "$first_raw" 60)"
    latest="$(normalise "$latest_raw" 80)"
    title="Claude — ${first} (turn ${turns})"
    body="${message}"$'\n'"↳ \"${latest}\""
  fi
fi

"$CURL_BIN" -sS --max-time 10 --connect-timeout 5 \
  -H "Authorization: Bearer $NTFY_TOKEN" \
  -H "Title: $title" \
  -H "Tags: robot" \
  -H "Priority: 3" \
  -d "$body" \
  "$NTFY_URL" \
  || { log "curl failed with exit $?"; exit 0; }

exit 0
