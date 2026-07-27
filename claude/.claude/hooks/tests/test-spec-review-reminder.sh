#!/usr/bin/env bash
set -uo pipefail
here="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
script="$here/../spec-review-reminder.sh"
fixtures="$here/fixtures"
pass=0; fail=0

check() { # name  fixture  expect_reminder(0|1)
  local name="$1" fx="$2" want="$3" out
  out="$("$script" < "$fixtures/$fx")"
  local got=0
  if printf '%s' "$out" | grep -q "review-spec"; then got=1; fi
  if [[ "$got" == "$want" ]]; then echo "PASS $name"; pass=$((pass+1));
  else echo "FAIL $name (want=$want got=$got out=$out)"; fail=$((fail+1)); fi
}

check "write-spec-reminds"            write-spec.json             1
check "write-spec-v2-reminds"         write-spec-v2.json          1
check "write-superpowers-reminds"     write-superpowers-spec.json 1
check "write-plan-silent"             write-plan.json             0
check "write-readme-silent"           write-readme.json           0
check "edit-spec-silent"              edit-spec.json              0

echo "== $pass passed, $fail failed =="
[[ "$fail" -eq 0 ]]
