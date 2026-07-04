#!/usr/bin/env bash
# Claude Code PostToolUse hook: after a PR is opened, remind the agent to stamp
# the matching Explorations spec/plan via the exploration-lifecycle skill.
# Non-blocking: only ever emits additionalContext, always exits 0.
set -uo pipefail

input="$(cat)"
tool="$(printf '%s' "$input" | jq -r '.tool_name // empty' 2>/dev/null)"
cmd="$(printf '%s' "$input"  | jq -r '.tool_input.command // empty' 2>/dev/null)"

is_pr=0
case "$tool" in
  mcp__gitea__pull_request_write) is_pr=1 ;;
  Bash)
    if printf '%s' "$cmd" | grep -Eq '(gh pr create|glab mr create|tea pr(s)? create)'; then
      is_pr=1
    fi ;;
esac

[[ "$is_pr" -eq 1 ]] || exit 0

read -r -d '' msg <<'EOF'
A pull request was just opened. If this work has an Explorations spec/plan, stamp its lifecycle status now — do NOT hand-edit status:
  python .claude/skills/exploration-lifecycle/lifecycle.py mark-done <plan-or-spec.md> --pr <pr-url>
The spec rolls up to `implemented` automatically once all its plans are done. See the exploration-lifecycle skill.
EOF

jq -cn --arg m "$msg" \
  '{hookSpecificOutput:{hookEventName:"PostToolUse",additionalContext:$m}}'
exit 0
