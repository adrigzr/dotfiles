# explore-stamp-reminder hook — wiring

Non-blocking `PostToolUse` reminder to stamp Explorations lifecycle status after opening a PR.

## Enable

Merge this object into the `PostToolUse` array in `~/.claude/settings.json`
(managed via this dotfiles repo). Add it as a **new array element** (do not
merge into the existing `Write|Edit` matcher block):

```json
{
  "matcher": "Bash|mcp__gitea__pull_request_write",
  "hooks": [
    {
      "type": "command",
      "command": "~/.claude/hooks/explore-stamp-reminder.sh",
      "timeout": 10
    }
  ]
}
```

## Verify

```bash
echo '{"tool_name":"Bash","tool_input":{"command":"gh pr create"}}' \
  | ~/.claude/hooks/explore-stamp-reminder.sh
# → prints a JSON object containing "exploration-lifecycle"
```

Run the test suite: `claude/.claude/hooks/tests/test-explore-stamp-reminder.sh`.
