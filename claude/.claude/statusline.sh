#!/usr/bin/env bash
# Claude Code status line script
# Receives session JSON via stdin on every render

# Guard: graceful no-op if jq missing
if ! command -v jq &>/dev/null; then
  printf ' Claude\n'
  exit 0
fi

# Platform detection
PLATFORM=$(uname -s)

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

# Subscription usage (cached, 5-minute TTL)
CACHE_FILE="/tmp/claude-usage-cache.json"

_load_cached_usage() {
  if [ ! -f "$CACHE_FILE" ]; then return 1; fi
  local now mtime age
  now=$(date +%s)
  case "$PLATFORM" in
  Darwin) mtime=$(stat -f "%m" "$CACHE_FILE" 2>/dev/null) || return 1 ;;
  *) mtime=$(stat -c "%Y" "$CACHE_FILE" 2>/dev/null) || return 1 ;;
  esac
  age=$((now - mtime))
  [ "$age" -lt 300 ] || return 1
  cat "$CACHE_FILE"
}

_fetch_usage() {
  local token
  case "$PLATFORM" in
  Darwin)
    token=$(security find-generic-password -s "Claude Code-credentials" -w 2>/dev/null |
      jq -r '.claudeAiOauth.accessToken // empty' 2>/dev/null)
    ;;
  *)
    local creds_file="${CLAUDE_CONFIG_DIR:-$HOME/.claude}/.credentials.json"
    token=$(jq -r '.claudeAiOauth.accessToken // empty' "$creds_file" 2>/dev/null)
    ;;
  esac
  [ -z "$token" ] && return 1

  local response
  response=$(curl -sf \
    -H "Authorization: Bearer $token" \
    -H "anthropic-beta: oauth-2025-04-20" \
    "https://api.anthropic.com/api/oauth/usage" 2>/dev/null)
  [ -z "$response" ] && return 1

  # Validate response has expected fields
  printf '%s' "$response" | jq -e '.five_hour' &>/dev/null || return 1

  printf '%s' "$response" >"$CACHE_FILE"
  printf '%s' "$response"
}

usage_json=$(_load_cached_usage 2>/dev/null || _fetch_usage 2>/dev/null)

five_h_str=""
seven_d_str=""
if [ -n "$usage_json" ]; then
  five_h=$(printf '%s' "$usage_json" | jq -r '.five_hour.utilization // empty' 2>/dev/null)
  seven_d=$(printf '%s' "$usage_json" | jq -r '.seven_day.utilization // empty' 2>/dev/null)

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
fi

# Assemble output
sep="${DIM}·${RESET}"

out=" ${BLUE}${model_display}${RESET}"
out+="  ${CYAN}${branch}${RESET}"
out+="  ${ctx_str}"
[ -n "$cost_str" ] && out+="  ${PURPLE}${cost_str}${RESET}"
[ -n "$five_h_str" ] && out+="  ${five_h_str}"
[ -n "$seven_d_str" ] && out+="  ${seven_d_str}"

printf '%b\n' "$out"

# vim: ft=sh
