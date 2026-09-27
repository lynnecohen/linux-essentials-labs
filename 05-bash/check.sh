#!/bin/bash
set -u

LAB_DIR="$(cd "$(dirname "$0")" && pwd)"
WORK="$LAB_DIR/work"
SCRIPT="$WORK/scripts/northstar-report.sh"

if [[ ! -d "$WORK" ]]; then
    echo "Lab 5 workspace not found. Run: bash setup.sh 5"
    exit 1
fi

pass_count=0
fail_count=0
warn_count=0

pass() {
    echo "PASS: $1"
    pass_count=$((pass_count + 1))
}

fail() {
    echo "FAIL: $1"
    fail_count=$((fail_count + 1))
}

warn() {
    echo "WARN: $1"
    warn_count=$((warn_count + 1))
}

echo "Lab 5 — checking Bash automation"
echo

if [[ -f "$SCRIPT" ]]; then
    pass "script exists"
else
    fail "scripts/northstar-report.sh does not exist"
    echo
    echo "Result: $pass_count passed, $fail_count failed, $warn_count warnings"
    exit 1
fi

first_line="$(head -n 1 "$SCRIPT")"
if [[ "$first_line" == '#!/bin/bash' ]]; then
    pass "Bash shebang"
else
    fail "first line should be the Bash shebang used by this lab"
fi

if tail -n +2 "$SCRIPT" | grep -Eq '^[[:space:]]*#[^!]' ; then
    pass "script comment"
else
    fail "add at least one ordinary comment after the shebang"
fi

if grep -Eq '\$1([^0-9]|$)' "$SCRIPT" && grep -Eq '\$2([^0-9]|$)' "$SCRIPT"; then
    pass "first and second positional arguments used"
else
    fail "script should use both $1 and $2"
fi

if grep -Eq '^[[:space:]]*for[[:space:]]+[A-Za-z_][A-Za-z0-9_]*[[:space:]]+in[[:space:]]+' "$SCRIPT" &&    grep -Eq '^[[:space:]]*do([[:space:]]|$)' "$SCRIPT" &&    grep -Eq '^[[:space:]]*done([[:space:]]|$)' "$SCRIPT"; then
    pass "basic for/do/done loop"
else
    fail "script should contain a basic for/do/done loop"
fi

if grep -Fq '$?' "$SCRIPT"; then
    pass "exit-status expansion"
else
    fail "script should record the previous command's exit status with $?"
fi

if grep -Eq '^[[:space:]]*echo([[:space:]]|$)' "$SCRIPT"; then
    pass "echo used for report output"
else
    fail "script should use echo"
fi

if [[ -x "$SCRIPT" ]]; then
    pass "script is executable"
else
    fail "script does not have execute permission"
fi

advanced=0
if grep -Eq '^[[:space:]]*(if|while|function)[[:space:]]' "$SCRIPT"; then
    advanced=1
fi
if grep -Fq '$((' "$SCRIPT" || grep -Fq '$(' "$SCRIPT"; then
    advanced=1
fi

if [[ $advanced -eq 0 ]]; then
    pass "script stays within the intended v1.6-sized syntax"
else
    warn "advanced Bash syntax detected; it is not needed for this lab's Linux Essentials v1.6 target"
fi

CHECK_OUTPUT="$WORK/results/.checker-report.txt"
rm -f "$CHECK_OUTPUT"

(
    cd "$WORK" || exit 1
    ./scripts/northstar-report.sh "results/.checker-report.txt" "checker run"
)
run_status=$?

if [[ $run_status -eq 0 && -s "$CHECK_OUTPUT" ]]; then
    pass "script runs directly with supplied arguments"
else
    fail "script did not successfully create the checker report through direct execution"
fi

if [[ -f "$CHECK_OUTPUT" ]] &&    head -n 1 "$CHECK_OUTPUT" | grep -Fxq 'Northstar report: checker run'; then
    pass "second positional argument controls report label"
else
    fail "report heading should use the supplied second argument"
fi

if [[ -f "$CHECK_OUTPUT" ]] && grep -Fxq 'Source logs:' "$CHECK_OUTPUT"; then
    pass "report source-log heading"
else
    fail "report should contain the required Source logs: line"
fi

for log in application.log auth.log worker.log; do
    if [[ -f "$CHECK_OUTPUT" ]] && grep -Fq "logs/$log" "$CHECK_OUTPUT"; then
        pass "report names $log"
    else
        fail "report does not name logs/$log"
    fi
done

if [[ -f "$CHECK_OUTPUT" ]] && grep -q 'grep-status=0' "$CHECK_OUTPUT" && grep -q 'grep-status=1' "$CHECK_OUTPUT"; then
    pass "report preserves successful and no-match grep exit statuses"
else
    fail "report should contain both grep-status=0 and grep-status=1"
fi

if [[ -f "$CHECK_OUTPUT" ]] &&    grep -Eiq 'error' "$CHECK_OUTPUT"; then
    pass "case-insensitive error matches included"
else
    fail "report does not appear to contain the expected error matches"
fi

rm -f "$CHECK_OUTPUT"

echo
echo "Result: $pass_count passed, $fail_count failed, $warn_count warnings"

if [[ $fail_count -eq 0 ]]; then
    echo "All scored Lab 5 outcomes are correct."
    echo "Finish the exact-recall checkpoint in 05-bash/INSTRUCTIONS.md."
    exit 0
else
    echo "One or more Lab 5 outcomes need another look."
    exit 1
fi
