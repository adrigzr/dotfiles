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

# --- reset countdown ---

now=$(date +%s)

# hm mode: hours and minutes, unpadded
out=$(render "$(fixture "$(printf '{"five_hour":{"used_percentage":42,"resets_at":%d}}' $((now + 8070)))")")
assert_contains "5h countdown h+m" "$out" "5h: 42% ↻2h14m"

# hm mode: unpadded single-digit minutes
out=$(render "$(fixture "$(printf '{"five_hour":{"used_percentage":42,"resets_at":%d}}' $((now + 7470)))")")
assert_contains "5h countdown unpadded minutes" "$out" "↻2h4m"

# hm mode: under an hour drops the zero hour
out=$(render "$(fixture "$(printf '{"five_hour":{"used_percentage":42,"resets_at":%d}}' $((now + 750)))")")
assert_contains "5h countdown sub-hour drops 0h" "$out" "↻12m"
assert_not_contains "5h countdown has no 0h prefix" "$out" "0h12m"

# hm mode: under a minute
out=$(render "$(fixture "$(printf '{"five_hour":{"used_percentage":42,"resets_at":%d}}' $((now + 45)))")")
assert_contains "5h countdown sub-minute" "$out" "↻0m"

# dh mode: days and hours
out=$(render "$(fixture "$(printf '{"seven_day":{"used_percentage":17,"resets_at":%d}}' $((now + 279000)))")")
assert_contains "7d countdown d+h" "$out" "7d: 17% ↻3d5h"

# dh mode: under a day drops the zero day
out=$(render "$(fixture "$(printf '{"seven_day":{"used_percentage":17,"resets_at":%d}}' $((now + 19800)))")")
assert_contains "7d countdown sub-day drops 0d" "$out" "↻5h"
assert_not_contains "7d countdown has no 0d prefix" "$out" "0d5h"

# expired window: percent survives, countdown hidden
out=$(render "$(fixture "$(printf '{"five_hour":{"used_percentage":42,"resets_at":%d}}' $((now - 60)))")")
assert_contains "expired window keeps percent" "$out" "5h: 42%"
assert_not_contains "expired window hides countdown" "$out" "↻"

# malformed resets_at degrades to bare percent
out=$(render "$(fixture '{"five_hour":{"used_percentage":42,"resets_at":"not-a-number"}}')")
assert_contains "garbage resets_at keeps percent" "$out" "5h: 42%"
assert_not_contains "garbage resets_at hides countdown" "$out" "↻"

# arithmetic-hostile resets_at (would cause bash syntax error without guard)
out=$(render "$(fixture '{"five_hour":{"used_percentage":42,"resets_at":"3;"}}')")
assert_contains "arithmetic-hostile resets_at keeps percent" "$out" "5h: 42%"
assert_not_contains "arithmetic-hostile resets_at hides countdown" "$out" "↻"

# resets_at key absent entirely: percent survives, countdown hidden
out=$(render "$(fixture '{"five_hour":{"used_percentage":42}}')")
assert_contains "missing resets_at keeps percent" "$out" "5h: 42%"
assert_not_contains "missing resets_at hides countdown" "$out" "↻"

# --- percentage rounding ---

out=$(render "$(fixture '{"seven_day":{"used_percentage":28.999999999999996,"resets_at":0}}')")
assert_contains "float noise rounds up" "$out" "7d: 29%"
assert_not_contains "float noise does not truncate down" "$out" "7d: 28%"

out=$(render "$(fixture '{"five_hour":{"used_percentage":74.4,"resets_at":0}}')")
assert_contains "rounds down below .5" "$out" "5h: 74%"

out=$(render "$(fixture '{"five_hour":{"used_percentage":74.6,"resets_at":0}}')")
assert_contains "rounds up at .5 and above" "$out" "5h: 75%"

# context segment rounds by the same rule (fixture used_percentage is 22.6)
out=$(render "$(fixture null)")
assert_contains "context percent rounds up" "$out" "(23%)"

# --- summary ---

printf '\n%d passed, %d failed\n' "$pass" "$fail"
[ "$fail" -eq 0 ]

# vim: ft=sh
