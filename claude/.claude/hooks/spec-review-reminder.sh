#!/usr/bin/env bash
# Claude Code PostToolUse hook: after a spec file is written, remind the agent to
# interrogate it via the review-spec skill before writing any implementation plan.
# Non-blocking: only ever emits additionalContext, always exits 0.
set -uo pipefail

input="$(cat)"
tool="$(printf '%s' "$input" | jq -r '.tool_name // empty' 2>/dev/null)"
path="$(printf '%s' "$input" | jq -r '.tool_input.file_path // empty' 2>/dev/null)"

# Only a fresh Write counts. Edit is excluded on purpose: the review-spec skill
# patches the spec as it resolves answers, and matching Edit would make this hook
# nag on every one of those edits.
[[ "$tool" == "Write" ]] || exit 0
[[ -n "$path" ]] || exit 0

base="${path##*/}"
is_spec=0
case "$base" in
  spec.md)          is_spec=1 ;;
  spec-v[0-9]*.md)  is_spec=1 ;;
esac
case "$path" in
  */docs/superpowers/specs/*.md) is_spec=1 ;;
esac

[[ "$is_spec" -eq 1 ]] || exit 0

read -r -d '' msg <<'EOF'
A spec was just written. Before writing any implementation plan, run /homelab:review-spec against it:
  - bring the default branch current on every repo the spec touches, and report how stale each one was
  - report drift between what the spec claims and what the code now does
  - ask the spec's open questions one at a time, then state "clear to plan" or name what still blocks it
Skipping the freshness pull is the silent failure: a spec grilled against a stale checkout yields confident, wrong conclusions.
EOF

jq -cn --arg m "$msg" \
  '{hookSpecificOutput:{hookEventName:"PostToolUse",additionalContext:$m}}'
exit 0
