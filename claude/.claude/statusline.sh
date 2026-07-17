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
ctx_pct=${ctx_pct%.*} # truncate decimals
ctx_size=$(printf '%s' "$input" | jq -r '.context_window.context_window_size // 0' 2>/dev/null)
input_tokens=$(printf '%s' "$input" | jq -r '(.context_window.current_usage.input_tokens // 0) + (.context_window.current_usage.cache_creation_input_tokens // 0) + (.context_window.current_usage.cache_read_input_tokens // 0)' 2>/dev/null)

ctx_color=$(color_pct "$ctx_pct")
ctx_used_fmt=$(fmt_k "$input_tokens")
ctx_size_fmt=$(fmt_k "$ctx_size")
ctx_str="${ctx_color}↑${ctx_used_fmt}/${ctx_size_fmt} (${ctx_pct}%)${RESET}"

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

five_h_str=""
seven_d_str=""
if [ -n "$five_h" ]; then
  five_h_int=${five_h%.*}
  five_h_color=$(color_pct "$five_h_int")
  five_h_str="${DIM}5h:${RESET} ${five_h_color}${five_h_int}%${RESET}"
fi
if [ -n "$seven_d" ]; then
  seven_d_int=${seven_d%.*}
  seven_d_color=$(color_pct "$seven_d_int")
  seven_d_str="${DIM}7d:${RESET} ${seven_d_color}${seven_d_int}%${RESET}"
fi

# Assemble output

out=" ${BLUE}${model_display}${RESET}"
out+="  ${CYAN}${branch}${RESET}"
out+="  ${ctx_str}"
[ -n "$cost_str" ] && out+="  ${PURPLE}${cost_str}${RESET}"
[ -n "$five_h_str" ] && out+="  ${five_h_str}"
[ -n "$seven_d_str" ] && out+="  ${seven_d_str}"

printf '%b\n' "$out"

# vim: ft=sh
