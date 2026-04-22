#!/usr/bin/env bash
# Claude Code Notification hook: sends an ntfy notification with a session recap.
# See Explorations/Claude Code ntfy notification hook/spec.md in homelab-vault.

set -uo pipefail

CURL_BIN="${CURL_BIN:-curl}"

log() { echo "[ntfy-notify] $*" >&2; }

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
