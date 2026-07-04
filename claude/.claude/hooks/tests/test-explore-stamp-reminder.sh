#!/usr/bin/env bash
set -uo pipefail
here="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
script="$here/../explore-stamp-reminder.sh"
fixtures="$here/fixtures"
pass=0; fail=0

check() { # name  fixture  expect_reminder(0|1)
  local name="$1" fx="$2" want="$3" out
  out="$("$script" < "$fixtures/$fx")"
  local got=0
  if printf '%s' "$out" | grep -q "exploration-lifecycle"; then got=1; fi
  if [[ "$got" == "$want" ]]; then echo "PASS $name"; pass=$((pass+1));
  else echo "FAIL $name (want=$want got=$got out=$out)"; fail=$((fail+1)); fi
}

check "gh-pr-create-reminds"  pr-create-bash.json 1
check "plain-bash-silent"     non-pr-bash.json    0
check "gitea-mcp-reminds"     gitea-pr-mcp.json   1

echo "== $pass passed, $fail failed =="
[[ "$fail" -eq 0 ]]
