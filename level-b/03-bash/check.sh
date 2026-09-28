#!/bin/bash
set -u

LAB_DIR="$(cd "$(dirname "$0")" && pwd)"
WORK="$LAB_DIR/work"
AUDIT="$WORK/scripts/system-audit.sh"
CONFIRM="$WORK/scripts/confirm-maintenance.sh"

pass_count=0
fail_count=0

pass() {
    echo "PASS: $1"
    pass_count=$((pass_count + 1))
}

fail() {
    echo "FAIL: $1"
    fail_count=$((fail_count + 1))
}

echo "B3 — checking practical Bash administration"
echo

if [[ ! -d "$WORK" ]]; then
    echo "B3 workspace not found. Run: bash setup.sh b3"
    exit 1
fi

if [[ -f "$AUDIT" ]]; then
    pass "system-audit.sh exists"
else
    fail "scripts/system-audit.sh does not exist"
fi

if [[ -f "$CONFIRM" ]]; then
    pass "confirm-maintenance.sh exists"
else
    fail "scripts/confirm-maintenance.sh does not exist"
fi

if [[ ! -f "$AUDIT" || ! -f "$CONFIRM" ]]; then
    echo
    echo "Result: $pass_count passed, $fail_count failed"
    exit 1
fi

if [[ "$(head -n 1 "$AUDIT")" == '#!/bin/bash' ]]; then
    pass "audit script uses Bash shebang"
else
    fail "audit script should begin with #!/bin/bash"
fi

if [[ "$(head -n 1 "$CONFIRM")" == '#!/bin/bash' ]]; then
    pass "confirmation script uses Bash shebang"
else
    fail "confirmation script should begin with #!/bin/bash"
fi

if [[ -x "$AUDIT" && -x "$CONFIRM" ]]; then
    pass "both scripts are executable"
else
    fail "both scripts should have execute permission"
fi

if grep -Eq '(^|[^[:alnum:]_])if([[:space:]]|$)' "$AUDIT" &&    grep -Eq '(^|[^[:alnum:]_])elif([[:space:]]|$)' "$AUDIT" &&    grep -Eq '(^|[^[:alnum:]_])else([[:space:]]|$)' "$AUDIT"; then
    pass "if/elif/else present"
else
    fail "audit script should use if/elif/else"
fi

if grep -Eq 'while[[:space:]].*read[[:space:]].*-r' "$AUDIT"; then
    pass "while/read loop present"
else
    fail "audit script should parse status files with while + read -r"
fi

if grep -Eq '^[[:space:]]*case[[:space:]]' "$AUDIT"; then
    pass "case statement present"
else
    fail "audit script should use case when parsing keys"
fi

if grep -Eq 'audit_file[[:space:]]*\(\)[[:space:]]*\{' "$AUDIT"; then
    pass "audit_file function present"
else
    fail "audit script should define audit_file()"
fi

if grep -Fq '$(' "$AUDIT"; then
    pass "command substitution present"
else
    fail "audit script should use modern command substitution"
fi

if grep -Fq '$((' "$AUDIT"; then
    pass "arithmetic expansion present"
else
    fail "audit script should use arithmetic expansion for counters"
fi

if grep -Fq '$#' "$AUDIT" && grep -Fq '"$@"' "$AUDIT" && grep -Eq '^[[:space:]]*shift([[:space:]]|$)' "$AUDIT"; then
    pass "advanced positional-argument handling present"
else
    fail "audit script should use $#, shift, and quoted \"$@\""
fi

if grep -Eq '\[\[.*-f.*\]\]' "$AUDIT"; then
    pass "file test present"
else
    fail "audit script should test status-file existence with a file condition"
fi

if grep -Eq '\-(ge|gt|le|lt|eq|ne)[[:space:]]' "$AUDIT"; then
    pass "numeric comparison present"
else
    fail "audit script should use numeric comparisons"
fi

if grep -Eq 'read[[:space:]]+-r[[:space:]]+-p|read[[:space:]]+-p[[:space:]]+-r' "$CONFIRM"; then
    pass "interactive read -r -p present"
else
    fail "confirmation script should use read -r -p"
fi

if grep -Eq '(^|[^[:alnum:]_])if([[:space:]]|$)' "$CONFIRM"; then
    pass "confirmation conditional present"
else
    fail "confirmation script should make a decision with if"
fi

TMP1="$WORK/results/.checker-audit.txt"
TMP2="$WORK/results/.checker-missing.txt"
rm -f "$TMP1" "$TMP2"

(
    cd "$WORK" || exit 99
    ./scripts/system-audit.sh         "results/.checker-audit.txt"         "systems/web01.status"         "systems/web02.status"         "systems/db01.status"
)
normal_status=$?

if [[ $normal_status -eq 0 ]]; then
    pass "normal audit exits 0"
else
    fail "normal audit should exit 0"
fi

if [[ -s "$TMP1" ]] &&    grep -Fxq 'web01 service=running disk=72 errors=0 status=OK' "$TMP1" &&    grep -Fxq 'web02 service=running disk=86 errors=2 status=WARNING' "$TMP1" &&    grep -Fxq 'db01 service=stopped disk=94 errors=7 status=CRITICAL' "$TMP1" &&    grep -Fxq 'processed=3' "$TMP1" &&    grep -Fxq 'issues=2' "$TMP1" &&    grep -Fxq 'missing=0' "$TMP1"; then
    pass "normal audit report classifications and counters"
else
    fail "normal audit report does not match required classifications/counters"
fi

(
    cd "$WORK" || exit 99
    ./scripts/system-audit.sh         "results/.checker-missing.txt"         "systems/web01.status"         "systems/missing.status"
)
missing_status=$?

if [[ $missing_status -eq 1 ]]; then
    pass "missing-file audit exits 1"
else
    fail "audit with a missing input should exit 1"
fi

if [[ -s "$TMP2" ]] &&    grep -Fxq 'MISSING systems/missing.status' "$TMP2" &&    grep -Fxq 'processed=1' "$TMP2" &&    grep -Fxq 'issues=0' "$TMP2" &&    grep -Fxq 'missing=1' "$TMP2"; then
    pass "missing-file report and counters"
else
    fail "missing-file audit report does not match required behavior"
fi

(
    cd "$WORK" || exit 99
    ./scripts/system-audit.sh "results/.checker-usage.txt"
) >/dev/null 2>&1
usage_status=$?

if [[ $usage_status -eq 2 ]]; then
    pass "usage error exits 2"
else
    fail "too-few arguments should exit 2"
fi

approved="$(cd "$WORK" && printf 'y\n' | ./scripts/confirm-maintenance.sh 2>/dev/null)"
approved_status=$?

if [[ $approved_status -eq 0 && "$approved" == *"maintenance-approved"* ]]; then
    pass "confirmation yes branch"
else
    fail "confirmation yes branch should print maintenance-approved and exit 0"
fi

cancelled="$(cd "$WORK" && printf 'n\n' | ./scripts/confirm-maintenance.sh 2>/dev/null)"
cancelled_status=$?

if [[ $cancelled_status -eq 1 && "$cancelled" == *"maintenance-cancelled"* ]]; then
    pass "confirmation no branch"
else
    fail "confirmation no branch should print maintenance-cancelled and exit 1"
fi

rm -f "$TMP1" "$TMP2" "$WORK/results/.checker-usage.txt"

echo
echo "Result: $pass_count passed, $fail_count failed"

if [[ $fail_count -eq 0 ]]; then
    echo "All scored B3 outcomes are correct."
    echo "Finish the exact-recall checkpoint in level-b/03-bash/INSTRUCTIONS.md, then check level-b/03-bash/ANSWERS.md."
    exit 0
else
    echo "One or more B3 outcomes need another look."
    exit 1
fi
