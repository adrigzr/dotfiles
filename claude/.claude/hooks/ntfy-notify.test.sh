#!/usr/bin/env bash
# Tests the subagent-suppression guard in ntfy-notify.sh.
#
# The hook must stay quiet while this session's own subagents are still working,
# and must notify once they have all reported back. Each case builds a fixture
# transcript, feeds the hook a Notification payload pointing at it, and asserts
# whether the stubbed curl was reached.

set -uo pipefail

HOOK="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/ntfy-notify.sh"
TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT

cat >"$TMP/curl-stub" <<'STUB'
#!/usr/bin/env bash
touch "$SENT_MARKER"
STUB
chmod +x "$TMP/curl-stub"

passed=0
failed=0

# run <fixture> -> 0 if the hook sent a notification, 1 if it suppressed
run() {
  rm -f "$TMP/sent"
  printf '{"message":"Claude is waiting for your input","transcript_path":"%s"}' "$1" |
    env -u TMUX -u TMUX_PANE \
      SENT_MARKER="$TMP/sent" \
      CURL_BIN="$TMP/curl-stub" \
      NTFY_TOKEN=test-token \
      NTFY_URL=https://ntfy.example/test \
      bash "$HOOK" >/dev/null 2>&1
  [[ -f "$TMP/sent" ]]
}

expect() {
  local name="$1" want="$2" fixture="$3" got
  if run "$fixture"; then got=send; else got=suppress; fi
  if [[ "$got" == "$want" ]]; then
    printf 'ok   %-34s %s\n' "$name" "$got"
    passed=$((passed + 1))
  else
    printf 'FAIL %-34s want=%s got=%s\n' "$name" "$want" "$got"
    failed=$((failed + 1))
  fi
}

# --- fixture builders -------------------------------------------------------

AGENT_A=a1111111111111111
AGENT_B=b2222222222222222

launch() { # $1=ts $2=agentId
  printf '{"type":"user","timestamp":"%s","toolUseResult":{"isAsync":true,"status":"async_launched","agentId":"%s","description":"stub agent"}}\n' "$1" "$2"
}

notify() { # $1=ts $2=agentId
  printf '{"type":"queue-operation","operation":"enqueue","timestamp":"%s","content":"<task-notification>\\n<task-id>%s</task-id>\\n<status>completed</status>\\n</task-notification>"}\n' "$1" "$2"
}

resume() { # $1=ts $2=agentId
  printf '{"type":"user","timestamp":"%s","toolUseResult":{"success":true,"resumedAgentId":"%s"}}\n' "$1" "$2"
}

prompt() { # $1=text
  printf '{"type":"last-prompt","lastPrompt":"%s"}\n' "$1"
}

# --- cases ------------------------------------------------------------------

# A background agent was launched and has not reported back yet.
{
  prompt "do the thing"
  launch 2026-08-11T10:00:00.000Z "$AGENT_A"
} >"$TMP/bg-pending.jsonl"
expect "background agent still running" suppress "$TMP/bg-pending.jsonl"

# Same agent, now finished: its task-notification landed after the launch.
{
  prompt "do the thing"
  launch 2026-08-11T10:00:00.000Z "$AGENT_A"
  notify 2026-08-11T10:05:00.000Z "$AGENT_A"
} >"$TMP/bg-notified.jsonl"
expect "background agent finished" send "$TMP/bg-notified.jsonl"

# One of two background agents is still out.
{
  prompt "do the thing"
  launch 2026-08-11T10:00:00.000Z "$AGENT_A"
  launch 2026-08-11T10:00:01.000Z "$AGENT_B"
  notify 2026-08-11T10:05:00.000Z "$AGENT_A"
} >"$TMP/bg-partial.jsonl"
expect "one of two agents still running" suppress "$TMP/bg-partial.jsonl"

# A foreground Agent call with no tool_result: the original guard's case.
{
  prompt "do the thing"
  printf '{"type":"assistant","timestamp":"2026-08-11T10:00:00.000Z","message":{"content":[{"type":"tool_use","id":"toolu_fg1","name":"Agent","input":{"run_in_background":false}}]}}\n'
} >"$TMP/fg-pending.jsonl"
expect "foreground agent still running" suppress "$TMP/fg-pending.jsonl"

# Foreground agent reported back.
{
  prompt "do the thing"
  printf '{"type":"assistant","timestamp":"2026-08-11T10:00:00.000Z","message":{"content":[{"type":"tool_use","id":"toolu_fg1","name":"Agent","input":{"run_in_background":false}}]}}\n'
  printf '{"type":"user","timestamp":"2026-08-11T10:04:00.000Z","message":{"content":[{"type":"tool_result","tool_use_id":"toolu_fg1","content":"report"}]}}\n'
} >"$TMP/fg-done.jsonl"
expect "foreground agent finished" send "$TMP/fg-done.jsonl"

# Woken again via SendMessage after it had already notified once.
{
  prompt "do the thing"
  launch 2026-08-11T10:00:00.000Z "$AGENT_A"
  notify 2026-08-11T10:05:00.000Z "$AGENT_A"
  resume 2026-08-11T10:06:00.000Z "$AGENT_A"
} >"$TMP/bg-resumed.jsonl"
expect "agent resumed after notifying" suppress "$TMP/bg-resumed.jsonl"

# Resumed, then notified again.
{
  prompt "do the thing"
  launch 2026-08-11T10:00:00.000Z "$AGENT_A"
  notify 2026-08-11T10:05:00.000Z "$AGENT_A"
  resume 2026-08-11T10:06:00.000Z "$AGENT_A"
  notify 2026-08-11T10:09:00.000Z "$AGENT_A"
} >"$TMP/bg-renotified.jsonl"
expect "resumed agent finished again" send "$TMP/bg-renotified.jsonl"

# No subagents at all: the ordinary permission-prompt notification.
{
  prompt "do the thing"
  printf '{"type":"assistant","timestamp":"2026-08-11T10:00:00.000Z","message":{"content":[{"type":"text","text":"working on it"}]}}\n'
} >"$TMP/no-agents.jsonl"
expect "no subagents in transcript" send "$TMP/no-agents.jsonl"

# Tool output that merely quotes the launch banner and a task-notification must
# not be mistaken for either. This is why the guard reads structured fields
# rather than grepping the transcript.
{
  prompt "why does the hook misfire"
  printf '{"type":"user","timestamp":"2026-08-11T10:00:00.000Z","message":{"content":[{"type":"tool_result","tool_use_id":"toolu_bash1","content":[{"type":"text","text":"Async agent launched successfully. agentId: %s\\n<task-notification>\\n<task-id>%s</task-id>"}]}]}}\n' "$AGENT_A" "$AGENT_B"
} >"$TMP/quoted-marker.jsonl"
expect "quoted markers in tool output" send "$TMP/quoted-marker.jsonl"

# A transcript path that does not exist must not suppress.
expect "missing transcript" send "$TMP/does-not-exist.jsonl"

printf '\n%d passed, %d failed\n' "$passed" "$failed"
[[ "$failed" -eq 0 ]]
