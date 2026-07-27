# spec-review-reminder hook — wiring

Non-blocking `PostToolUse` reminder to interrogate a spec via `/homelab:review-spec` before writing any
implementation plan.

## Enable

Merge this object into the `PostToolUse` array in `~/.claude/settings.json`
(managed via this dotfiles repo). Add it as a **new array element** (do not
merge into the existing `Write|Edit` matcher block):

```json
{
  "matcher": "Write",
  "hooks": [
    {
      "type": "command",
      "command": "~/.claude/hooks/spec-review-reminder.sh",
      "timeout": 10
    }
  ]
}
```

The matcher is `Write` only, not `Write|Edit`. The `review-spec` skill patches the spec as it resolves answers,
matching `Edit` would make this hook nag on every one of those edits.

## Verify

```bash
echo '{"tool_name":"Write","tool_input":{"file_path":"Explorations/X/Y/spec.md"}}' \
  | ~/.claude/hooks/spec-review-reminder.sh
# → prints a JSON object containing "review-spec"
```

Run the test suite: `claude/.claude/hooks/tests/test-spec-review-reminder.sh`.
