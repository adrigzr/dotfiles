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
