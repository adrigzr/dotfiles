#!/usr/bin/env bash
# Tests for statusline.sh — plain bash, no framework.
# Run: ./claude/.claude/statusline.test.sh

script_dir=$(cd "$(dirname "$0")" && pwd)
statusline="$script_dir/statusline.sh"

pass=0
fail=0

# strip_ansi(): remove SGR escape sequences so assertions match plain text
strip_ansi() {
  sed 's/\x1b\[[0-9;]*m//g'
}

# render(): pipe session JSON to the statusline, return plain-text output
render() {
  printf '%s' "${1:-}" | "$statusline" | strip_ansi
}

# fixture(): build session JSON, embedding the given rate_limits object.
# Pass '{}' for an empty rate_limits, or 'null' to omit the key entirely.
fixture() {
  local rate_limits="${1:-null}"
  printf '{
    "model": { "display_name": "Opus 4.8" },
    "cwd": "/tmp",
    "context_window": {
      "used_percentage": 22.6,
      "context_window_size": 200000,
      "current_usage": { "input_tokens": 45000 }
    },
    "rate_limits": %s
  }' "$rate_limits"
}

# assert_contains(): name, haystack, needle
assert_contains() {
  local name="${1:-}" haystack="${2:-}" needle="${3:-}"
  if printf '%s' "$haystack" | grep -qF -- "$needle"; then
    printf 'ok   %s\n' "$name"
    pass=$((pass + 1))
  else
    printf 'FAIL %s\n       want substring: [%s]\n       got:            [%s]\n' \
      "$name" "$needle" "$haystack"
    fail=$((fail + 1))
  fi
}

# assert_not_contains(): name, haystack, needle
assert_not_contains() {
  local name="${1:-}" haystack="${2:-}" needle="${3:-}"
  if printf '%s' "$haystack" | grep -qF -- "$needle"; then
    printf 'FAIL %s\n       unwanted substring: [%s]\n       got:                [%s]\n' \
      "$name" "$needle" "$haystack"
    fail=$((fail + 1))
  else
    printf 'ok   %s\n' "$name"
    pass=$((pass + 1))
  fi
}

# --- characterization: segments that already read from stdin ---

out=$(render "$(fixture null)")
assert_contains "model name renders" "$out" "Opus 4.8"
assert_contains "context tokens render" "$out" "45k/200k"

# --- rate limits sourced from stdin ---

out=$(render "$(fixture '{"five_hour":{"used_percentage":42,"resets_at":0},"seven_day":{"used_percentage":17,"resets_at":0}}')")
assert_contains "5h percent from stdin" "$out" "5h: 42%"
assert_contains "7d percent from stdin" "$out" "7d: 17%"

out=$(render "$(fixture null)")
assert_not_contains "no rate_limits -> no 5h segment" "$out" "5h:"
assert_not_contains "no rate_limits -> no 7d segment" "$out" "7d:"
assert_contains "no rate_limits -> rest of line intact" "$out" "Opus 4.8"

out=$(render "$(fixture '{"five_hour":{"used_percentage":42,"resets_at":0}}')")
assert_contains "5h alone renders" "$out" "5h: 42%"
assert_not_contains "7d absent when window missing" "$out" "7d:"

# --- summary ---

printf '\n%d passed, %d failed\n' "$pass" "$fail"
[ "$fail" -eq 0 ]

# vim: ft=sh
