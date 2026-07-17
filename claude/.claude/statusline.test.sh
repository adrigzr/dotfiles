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

# render(): pipe session JSON to the statusline, return plain-text output.
# COLUMNS is neutralized so the adaptive ladder yields the full (fallback) line;
# width-specific behavior is exercised via render_w below.
render() {
  printf '%s' "${1:-}" | env -u COLUMNS "$statusline" | strip_ansi
}

# render_w(): render at a specific terminal width.
render_w() {
  printf '%s' "${2:-}" | env COLUMNS="${1:-0}" "$statusline" | strip_ansi
}

# awidth(): stdin -> display columns (codepoints = bytes - UTF-8 continuation bytes).
awidth() {
  local s t c
  s=$(cat)
  t=$(printf '%s' "$s" | LC_ALL=C wc -c)
  c=$(printf '%s' "$s" | LC_ALL=C tr -dc '\200-\277' | LC_ALL=C wc -c)
  printf '%s' "$((t - c))"
}

# assert_width(): name, cols, json, expected-width
assert_width() {
  local name="${1:-}" cols="${2:-}" json="${3:-}" want="${4:-}" got
  got=$(render_w "$cols" "$json" | awidth)
  if [ "$got" = "$want" ]; then
    printf 'ok   %s\n' "$name"; pass=$((pass + 1))
  else
    printf 'FAIL %s\n       want width: [%s]\n       got width:  [%s]\n' "$name" "$want" "$got"
    fail=$((fail + 1))
  fi
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

# assert_eq(): name, got, want
assert_eq() {
  local name="${1:-}" got="${2:-}" want="${3:-}"
  if [ "$got" = "$want" ]; then
    printf 'ok   %s\n' "$name"; pass=$((pass + 1))
  else
    printf 'FAIL %s\n       want: [%s]\n       got:  [%s]\n' "$name" "$want" "$got"; fail=$((fail + 1))
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

# --- adaptive width (measure-and-reduce ladder) ---

now=$(date +%s)
WC_FIX=$(printf '{
  "model": { "display_name": "Opus 4.8" },
  "cwd": "/tmp",
  "worktree": { "original_branch": "feat/investments-twr-valuation-fix" },
  "context_window": { "used_percentage": 72, "context_window_size": 200000, "current_usage": { "input_tokens": 144000 } },
  "cost": { "total_cost_usd": 12.47 },
  "rate_limits": {
    "five_hour": { "used_percentage": 88, "resets_at": %d },
    "seven_day": { "used_percentage": 64, "resets_at": %d }
  }
}' $((now + 17460)) $((now + 450000)))   # 5h≈4h51m (5 cols), 7d≈5d5h (4 cols)

# tier widths per spec (v2, phase-2 fill): 120->102, 100->97, 80->66, 45->41, 30->25, 20->16
assert_width "tier full at 120"       120 "$WC_FIX" 102
assert_width "tier fill-labels at 100" 100 "$WC_FIX" 97
assert_width "tier drop-branch at 80"  80 "$WC_FIX" 66
assert_width "tier fill at 45"         45 "$WC_FIX" 41
assert_width "tier at 30"              30 "$WC_FIX" 25
assert_width "tier floor at 20"        20 "$WC_FIX" 16

# every width fits within its terminal (<= COLUMNS-1)
for c in 120 103 100 90 80 70 55 46 40 33 25 20; do
  w=$(render_w "$c" "$WC_FIX" | awidth)
  if [ "$w" -le $((c - 1)) ]; then
    printf 'ok   fits at COLUMNS=%s (w=%s)\n' "$c" "$w"; pass=$((pass + 1))
  else
    printf 'FAIL width %s > %s at COLUMNS=%s\n' "$w" "$((c - 1))" "$c"; fail=$((fail + 1))
  fi
done

# fallback: unset / 0 / garbage COLUMNS -> full line (width 102)
out=$(printf '%s' "$WC_FIX" | env -u COLUMNS "$statusline" | strip_ansi)
assert_contains "unset COLUMNS -> full line" "$out" "feat/investments-twr-valuation-fix"
w=$(printf '%s' "$out" | awidth)
if [ "$w" = 102 ]; then
  printf 'ok   unset COLUMNS width 102\n'; pass=$((pass + 1))
else
  printf 'FAIL unset width %s != 102\n' "$w"; fail=$((fail + 1))
fi
assert_width "COLUMNS=0 -> full line"        0     "$WC_FIX" 102
assert_width "COLUMNS=garbage -> full line"  "8x"  "$WC_FIX" 102

# ladder content assertions
o120=$(render_w 120 "$WC_FIX")
assert_contains "120 keeps branch"    "$o120" "feat/investments-twr-valuation-fix"
assert_contains "120 keeps full ctx"  "$o120" "144k/200k (72%)"

o100=$(render_w 100 "$WC_FIX")
assert_contains     "100 keeps branch"     "$o100" "feat/investments-twr-valuation-fix"
assert_contains     "100 spaced 5h label"  "$o100" "5h: 88%"
assert_contains "100 ctx mid"         "$o100" "↑144k (72%)"
assert_not_contains "100 drops denominator" "$o100" "/200k"

o80=$(render_w 80 "$WC_FIX")
assert_not_contains "80 drops branch"      "$o80" "feat/investments"
assert_contains     "80 restores full ctx" "$o80" "144k/200k (72%)"
assert_contains     "80 restores 5h cd"    "$o80" "5h: 88%"
assert_contains     "80 keeps 7d cd"       "$o80" "7d: 64%"
assert_contains "80 keeps cost"       "$o80" "\$12.47"
assert_contains "80 keeps 5h countdown" "$o80" "↻"

# monotonic-≥ with the one documented exception (80→90 swaps branch for ctx detail):
w80=$(render_w 80 "$WC_FIX" | awidth); w90=$(render_w 90 "$WC_FIX" | awidth)
assert_eq "80→90 width non-decreasing (branch/ctx swap)" "$([ "$w90" -ge "$w80" ] && echo ok)" "ok"
assert_width "90 keeps branch sparse-ctx"  90 "$WC_FIX" 89
o90=$(render_w 90 "$WC_FIX")
assert_contains     "90 keeps branch"      "$o90" "feat/investments-twr-valuation-fix"
assert_not_contains "90 drops ctx denom"   "$o90" "144k/200k"

o45=$(render_w 45 "$WC_FIX")
assert_not_contains "45 drops cost"   "$o45" "\$12.47"
assert_contains "45 keeps 5h countdown" "$o45" "↻4h"
assert_not_contains "45 drops 7d countdown" "$o45" "↻5d"
o30=$(render_w 30 "$WC_FIX")
assert_contains "30 spaced 5h pct"    "$o30" "5h: 88%"
assert_not_contains "30 drops 7d"     "$o30" "7d:"
assert_not_contains "30 no countdown" "$o30" "↻"
o20=$(render_w 20 "$WC_FIX")
assert_contains "20 floor keeps ctx"  "$o20" "↑144k"
assert_not_contains "20 floor no limits" "$o20" "5h:"

# locale independence: fit decision identical under C locale
wC=$(LC_ALL=C bash -c 'printf "%s" "$1" | env COLUMNS=80 "$2" | sed "s/\x1b\[[0-9;]*m//g"' _ "$WC_FIX" "$statusline" | awidth)
if [ "$wC" = 66 ]; then
  printf 'ok   C-locale tier at 80 (w=66)\n'; pass=$((pass + 1))
else
  printf 'FAIL C-locale width %s != 66\n' "$wC"; fail=$((fail + 1))
fi

# --- disp_width parity: same tier width under C and UTF-8 locales ---
wC=$(LC_ALL=C       bash -c 'printf "%s" "$1" | env COLUMNS=80 "$2" | sed -E "s/\x1b\[[0-9;]*m//g"' _ "$WC_FIX" "$statusline" | awidth)
wU=$(LC_ALL=en_US.UTF-8 bash -c 'printf "%s" "$1" | env COLUMNS=80 "$2" | sed -E "s/\x1b\[[0-9;]*m//g"' _ "$WC_FIX" "$statusline" | awidth)
assert_eq "disp_width locale parity @80" "$wC" "$wU"

# --- summary ---

printf '\n%d passed, %d failed\n' "$pass" "$fail"
[ "$fail" -eq 0 ]

# vim: ft=sh
