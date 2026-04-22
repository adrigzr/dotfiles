#!/usr/bin/env bash
# Plain-Bash test runner for ntfy-notify.sh.
# Discovers test_* functions defined in this file and runs each in a subshell
# with a fresh mock-curl log and tmp dir. Prints PASS/FAIL per test + summary.
set -uo pipefail

here="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck disable=SC2034  # referenced by tests added in later tasks
script="$here/../ntfy-notify.sh"
mock_curl="$here/mock-curl"
# shellcheck disable=SC2034  # referenced by tests added in later tasks
fixtures="$here/fixtures"

pass=0
fail=0
failed=()

run_test() {
  local name="$1"
  local tmp
  tmp="$(mktemp -d)"
  trap 'rm -rf "$tmp"' RETURN

  export MOCK_CURL_LOG="$tmp/curl.log"
  export MOCK_CURL_EXIT="${MOCK_CURL_EXIT:-0}"
  export CURL_BIN="$mock_curl"
  : > "$MOCK_CURL_LOG"

  if ( set -u; "$name" ); then
    echo "PASS  $name"
    pass=$((pass + 1))
  else
    echo "FAIL  $name"
    fail=$((fail + 1))
    failed+=("$name")
  fi

  unset MOCK_CURL_LOG MOCK_CURL_EXIT CURL_BIN
}

assert_no_curl() {
  if [[ -s "$MOCK_CURL_LOG" ]]; then
    echo "  expected no curl call, got:" >&2
    cat "$MOCK_CURL_LOG" >&2
    return 1
  fi
}

assert_curl_called() {
  if [[ ! -s "$MOCK_CURL_LOG" ]]; then
    echo "  expected curl call, got none" >&2
    return 1
  fi
}

assert_log_contains() {
  local pattern="$1"
  if ! grep -qF -- "$pattern" "$MOCK_CURL_LOG"; then
    echo "  expected log to contain: $pattern" >&2
    echo "  actual log:" >&2
    cat "$MOCK_CURL_LOG" >&2
    return 1
  fi
}

# --- tests go here (added in later tasks) ---

test_exits_silently_when_token_missing() {
  unset NTFY_TOKEN
  echo '{"message":"x","transcript_path":"","session_id":"s","cwd":"/","hook_event_name":"Notification"}' \
    | "$script" || return 1
  assert_no_curl
}

test_posts_to_ntfy_when_token_set_no_transcript() {
  export NTFY_TOKEN="test-token-123"
  echo '{"message":"Claude needs your permission","transcript_path":"/nonexistent","session_id":"s1","cwd":"/","hook_event_name":"Notification"}' \
    | "$script" || return 1
  assert_curl_called
  assert_log_contains 'https://ntfy.adrigzr.dev/apps'
  assert_log_contains 'Authorization: Bearer test-token-123'
  assert_log_contains 'Title: Claude Code'
  assert_log_contains 'Tags: robot'
  assert_log_contains 'Priority: 3'
  assert_log_contains 'Claude needs your permission'
}

test_recap_from_transcript() {
  export NTFY_TOKEN="test-token-123"
  local t="$fixtures/transcript-normal.jsonl"
  jq -n --arg t "$t" '{
    message: "Claude needs permission",
    transcript_path: $t,
    session_id: "s1",
    cwd: "/",
    hook_event_name: "Notification"
  }' | "$script" || return 1
  assert_curl_called
  # Title should contain the first prompt and turn count.
  assert_log_contains 'Title: Claude — Fix the Lidarr migration (turn 3)'
  # Body should contain the latest prompt on its own line.
  assert_log_contains '↳ "commit and open PR"'
}

test_strips_slash_command_prefix() {
  export NTFY_TOKEN="test-token-123"
  local t="$fixtures/transcript-slash-command.jsonl"
  jq -n --arg t "$t" '{
    message: "m",
    transcript_path: $t,
    session_id: "s4",
    cwd: "/",
    hook_event_name: "Notification"
  }' | "$script" || return 1
  # First prompt "/superpowers:brainstorming how to build a thing" → "how to build a thing".
  assert_log_contains 'Title: Claude — how to build a thing (turn 2)'
  # Latest "/fix-branch" → "" (nothing after the slash-command token).
  assert_log_contains '↳ ""'
}

test_truncates_long_prompts() {
  export NTFY_TOKEN="test-token-123"
  local t="$fixtures/transcript-long-prompts.jsonl"
  jq -n --arg t "$t" '{
    message: "m",
    transcript_path: $t,
    session_id: "s3",
    cwd: "/",
    hook_event_name: "Notification"
  }' | "$script" || return 1
  # First prompt capped at 60 chars + ellipsis.
  assert_log_contains 'This is a first prompt that is definitely longer than sixty…'
  # Latest capped at 80 chars + ellipsis.
  assert_log_contains 'This is the latest prompt and it is definitely longer than eighty characters so…'
}

test_normalises_whitespace_in_prompts() {
  export NTFY_TOKEN="test-token-123"
  local tmp
  tmp="$(mktemp)"
  cat > "$tmp" <<'EOF'
{"type":"last-prompt","lastPrompt":"hello\tworld\nnewline","sessionId":"sN"}
EOF
  jq -n --arg t "$tmp" '{
    message: "m",
    transcript_path: $t,
    session_id: "sN",
    cwd: "/",
    hook_event_name: "Notification"
  }' | "$script"
  local rc=$?
  rm -f "$tmp"
  [[ $rc -eq 0 ]] || return 1
  assert_log_contains 'Title: Claude — hello world newline (turn 1)'
}

test_malformed_json_stdin_exits_0_without_curl() {
  export NTFY_TOKEN="test-token-123"
  # 'not json' is not valid JSON; jq will fail parsing.
  echo 'not json' | "$script"
  local rc=$?
  [[ $rc -eq 0 ]] || { echo "  expected exit 0, got $rc" >&2; return 1; }
  assert_no_curl
}

test_transcript_missing_sends_message_only() {
  export NTFY_TOKEN="test-token-123"
  echo '{"message":"m","transcript_path":"/nope/does-not-exist.jsonl","session_id":"s","cwd":"/","hook_event_name":"Notification"}' \
    | "$script" || return 1
  assert_curl_called
  assert_log_contains 'Title: Claude Code'
  # Body should NOT contain the recap arrow.
  if grep -qF '↳' "$MOCK_CURL_LOG"; then
    echo "  expected no recap arrow in body" >&2
    cat "$MOCK_CURL_LOG" >&2
    return 1
  fi
}

test_transcript_with_zero_last_prompts_sends_message_only() {
  export NTFY_TOKEN="test-token-123"
  local t="$fixtures/transcript-empty.jsonl"
  jq -n --arg t "$t" '{
    message: "m",
    transcript_path: $t,
    session_id: "s2",
    cwd: "/",
    hook_event_name: "Notification"
  }' | "$script" || return 1
  assert_curl_called
  assert_log_contains 'Title: Claude Code'
  if grep -qF '↳' "$MOCK_CURL_LOG"; then
    echo "  expected no recap arrow in body" >&2
    return 1
  fi
}

test_curl_failure_still_exits_0() {
  export NTFY_TOKEN="test-token-123"
  export MOCK_CURL_EXIT=22  # simulate HTTP error from curl
  echo '{"message":"m","transcript_path":"/nope","session_id":"s","cwd":"/","hook_event_name":"Notification"}' \
    | "$script"
  local rc=$?
  unset MOCK_CURL_EXIT
  [[ $rc -eq 0 ]] || { echo "  expected exit 0 despite curl failure, got $rc" >&2; return 1; }
}

# --- runner ---
tests=$(declare -F | awk '{print $3}' | grep '^test_' || true)
if [[ -z "$tests" ]]; then
  echo "no tests defined" >&2
  exit 1
fi

for t in $tests; do run_test "$t"; done

echo
echo "----"
echo "$pass passed, $fail failed"
[[ $fail -eq 0 ]]
