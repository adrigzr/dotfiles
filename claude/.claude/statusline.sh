#!/usr/bin/env bash
# Claude Code status line script
# Receives session JSON via stdin on every render

# Guard: graceful no-op if jq missing
if ! command -v jq &>/dev/null; then
  printf ' Claude\n'
  exit 0
fi

# ANSI colors (One Dark palette)
RESET='\033[0m'
DIM='\033[2m'
BLUE='\033[38;5;75m'
GREEN='\033[38;5;114m'
YELLOW='\033[38;5;180m'
RED='\033[38;5;204m'
CYAN='\033[38;5;81m'
PURPLE='\033[38;5;176m'

# Read stdin JSON
input=$(cat)

# round_pct(): float percentage -> nearest integer
# stdin delivers floats with representation noise (28.999999999999996 is 29);
# truncating would floor these one point low.
round_pct() {
  awk -v x="${1:-0}" 'BEGIN { printf "%d", x + 0.5 }'
}

# color_pct(): returns color escape based on percentage value
color_pct() {
  local pct="${1:-0}"
  if [ "$pct" -ge 85 ] 2>/dev/null; then
    printf '%s' "$RED"
  elif [ "$pct" -ge 60 ] 2>/dev/null; then
    printf '%s' "$YELLOW"
  else
    printf '%s' "$GREEN"
  fi
}

# fmt_k(): format token count as Xk or X
fmt_k() {
  local n="${1:-0}"
  if [ "$n" -ge 1000 ] 2>/dev/null; then
    printf '%dk' "$((n / 1000))"
  else
    printf '%d' "$n"
  fi
}

# fmt_delta(): seconds until reset -> compact duration
#   mode "hm": 4h51m / 2h4m / 12m / 0m
#   mode "dh": 3d5h / 5h / 12m / 0m
# Leading zero units are dropped; nothing is zero-padded.
fmt_delta() {
  local secs="${1:-0}" mode="${2:-hm}" days hours mins
  hours=$((secs / 3600))
  mins=$(((secs % 3600) / 60))
  if [ "$mode" = "dh" ]; then
    days=$((secs / 86400))
    if [ "$days" -gt 0 ]; then
      printf '%dd%dh' "$days" "$(((secs % 86400) / 3600))"
      return
    fi
    if [ "$hours" -gt 0 ]; then
      printf '%dh' "$hours"
      return
    fi
    printf '%dm' "$mins"
    return
  fi
  if [ "$hours" -gt 0 ]; then
    printf '%dh%dm' "$hours" "$mins"
  else
    printf '%dm' "$mins"
  fi
}

# rate_limit_segment(): label, percent, resets_at, fmt_delta mode, [tight], [show_cd]
# Empty percent -> empty segment. tight=1 removes the space after "label:".
# show_cd=0 suppresses the countdown. Missing/elapsed/malformed reset yields percent alone.
rate_limit_segment() {
  local label="${1:-}" pct="${2:-}" reset="${3:-}" mode="${4:-hm}" tight="${5:-0}" show_cd="${6:-1}"
  [ -n "$pct" ] || return 0

  local pct_int color out sep now delta
  pct_int=$(round_pct "$pct")
  color=$(color_pct "$pct_int")
  if [ "$tight" = "1" ]; then sep=""; else sep=" "; fi
  out="${DIM}${label}:${RESET}${sep}${color}${pct_int}%${RESET}"

  reset=${reset%.*}
  case "$reset" in
  '' | *[!0-9]*) reset='' ;;
  esac

  if [ "$show_cd" = "1" ] && [ -n "$reset" ]; then
    now=$(date +%s)
    delta=$((reset - now))
    if [ "$delta" -gt 0 ]; then
      out="${out} ${DIM}↻$(fmt_delta "$delta" "$mode")${RESET}"
    fi
  fi

  printf '%s' "$out"
}

# disp_width(): display columns of a string that may contain LITERAL \033[..m
# escapes (measurement happens before the final `printf %b`). Subprocess-free:
# strips SGR escapes with parameter expansion, then counts codepoints. Under a
# UTF-8 locale ${#s} already counts characters; under C it counts bytes, so we
# subtract 2 per 3-byte glyph (↑, ↻ — the only multibyte glyphs used). Result
# is identical regardless of the ambient locale.
disp_width() {
  local s="$1" pre rest nou nor m gb up ref
  up='↑'; ref='↻'; gb=${#up}
  while [[ "$s" == *'\033['* ]]; do
    pre="${s%%'\033['*}"; rest="${s#*'\033['}"; s="$pre${rest#*m}"
  done
  nou="${s//$up/}"; nor="${s//$ref/}"
  m=$(( (${#s} - ${#nou}) / gb + (${#s} - ${#nor}) / gb ))
  if [ "$gb" -eq 3 ]; then
    printf '%s' "$(( ${#s} - 2 * m ))"
  else
    printf '%s' "${#s}"
  fi
}

# Extract model name
model_display=$(printf '%s' "$input" | jq -r '.model.display_name // empty' 2>/dev/null)
if [ -z "$model_display" ]; then
  model_id=$(printf '%s' "$input" | jq -r '.model.id // empty' 2>/dev/null)
  if [ -n "$model_id" ]; then
    # Parse last meaningful segments: claude-sonnet-4-6 → Sonnet 4.6
    # Remove "claude-" prefix, capitalize first word, replace - with space
    model_display=$(printf '%s' "$model_id" |
      sed 's/^claude-//' |
      awk -F'-' '{
          for (i=1; i<=NF; i++) {
            w = $i
            if (w ~ /^[0-9]/) { printf ".%s", w }
            else { printf "%s%s", toupper(substr(w,1,1)), substr(w,2) }
          }
          print ""
        }' |
      sed 's/^\.//')
  else
    model_display="Claude"
  fi
fi

# Git branch
cwd=$(printf '%s' "$input" | jq -r '.cwd // empty' 2>/dev/null)
branch=$(printf '%s' "$input" | jq -r '.worktree.original_branch // empty' 2>/dev/null)
if [ -z "$branch" ] && [ -n "$cwd" ]; then
  branch=$(git -C "$cwd" branch --show-current 2>/dev/null)
fi
[ -z "$branch" ] && branch="?"

# Context window
ctx_pct=$(printf '%s' "$input" | jq -r '.context_window.used_percentage // 0' 2>/dev/null)
ctx_pct=$(round_pct "$ctx_pct")
ctx_size=$(printf '%s' "$input" | jq -r '.context_window.context_window_size // 0' 2>/dev/null)
input_tokens=$(printf '%s' "$input" | jq -r '(.context_window.current_usage.input_tokens // 0) + (.context_window.current_usage.cache_creation_input_tokens // 0) + (.context_window.current_usage.cache_read_input_tokens // 0)' 2>/dev/null)

ctx_color=$(color_pct "$ctx_pct")
ctx_used_fmt=$(fmt_k "$input_tokens")
ctx_size_fmt=$(fmt_k "$ctx_size")
ctx_full="${ctx_color}↑${ctx_used_fmt}/${ctx_size_fmt} (${ctx_pct}%)${RESET}"
ctx_mid="${ctx_color}↑${ctx_used_fmt} (${ctx_pct}%)${RESET}"
ctx_min="${ctx_color}↑${ctx_used_fmt}${RESET}"

# Cost
cost_raw=$(printf '%s' "$input" | jq -r '.cost.total_cost_usd // empty' 2>/dev/null)
if [ -n "$cost_raw" ] && [ "$cost_raw" != "0" ] && [ "$cost_raw" != "null" ]; then
  cost_str=$(awk -v c="$cost_raw" 'BEGIN { printf "$%.2f", c }')
else
  cost_str=""
fi

# Subscription usage (from stdin — Claude Code supplies rate_limits directly)
five_h=$(printf '%s' "$input" | jq -r '.rate_limits.five_hour.used_percentage // empty' 2>/dev/null)
seven_d=$(printf '%s' "$input" | jq -r '.rate_limits.seven_day.used_percentage // empty' 2>/dev/null)

five_h_reset=$(printf '%s' "$input" | jq -r '.rate_limits.five_hour.resets_at // empty' 2>/dev/null)
seven_d_reset=$(printf '%s' "$input" | jq -r '.rate_limits.seven_day.resets_at // empty' 2>/dev/null)

# ---- adaptive assembly: build richest line, reduce until it fits COLUMNS-1 ----
# Ladder state (richest first).
label_tight=0; ctx_level=0; show_branch=1; show_cost=1
cd_7d=1; cd_5h=1; show_7d=1; show_5h=1

assemble() {
  local out ctx seg
  out=" ${BLUE}${model_display}${RESET}"
  [ "$show_branch" = 1 ] && out+="  ${CYAN}${branch}${RESET}"
  case "$ctx_level" in
  0) ctx="$ctx_full" ;;
  1) ctx="$ctx_mid" ;;
  *) ctx="$ctx_min" ;;
  esac
  out+="  ${ctx}"
  [ "$show_cost" = 1 ] && [ -n "$cost_str" ] && out+="  ${PURPLE}${cost_str}${RESET}"
  if [ "$show_5h" = 1 ]; then
    seg=$(rate_limit_segment "5h" "$five_h" "$five_h_reset" hm "$label_tight" "$cd_5h")
    [ -n "$seg" ] && out+="  ${seg}"
  fi
  if [ "$show_7d" = 1 ]; then
    seg=$(rate_limit_segment "7d" "$seven_d" "$seven_d_reset" dh "$label_tight" "$cd_7d")
    [ -n "$seg" ] && out+="  ${seg}"
  fi
  printf '%s' "$out"
}

# apply_step(): mutate ladder state for the given 0-based step index.
apply_step() {
  case "$1" in
  0) label_tight=1 ;;
  1) ctx_level=1 ;;
  2) ctx_level=2 ;;
  3) show_branch=0 ;;
  4) show_cost=0 ;;
  5) cd_7d=0 ;;
  6) cd_5h=0 ;;
  7) show_7d=0 ;;
  8) show_5h=0 ;;
  esac
}

# Usable width. Empty/0/non-numeric COLUMNS -> full line (no reduction).
cols="${COLUMNS:-}"
case "$cols" in '' | *[!0-9]*) cols=0 ;; esac

line=$(assemble)
if [ "$cols" -gt 0 ]; then
  target=$((cols - 1))
  if [ "$(disp_width "$line")" -gt "$target" ]; then
    for step in 0 1 2 3 4 5 6 7 8; do
      apply_step "$step"
      line=$(assemble)
      [ "$(disp_width "$line")" -le "$target" ] && break
    done
  fi
fi

printf '%b\n' "$line"

# vim: ft=sh
