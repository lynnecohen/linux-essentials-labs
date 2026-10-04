#!/bin/bash
set -u

LAB_DIR="$(cd "$(dirname "$0")" && pwd)"
WORK="$LAB_DIR/work"
REPORT="$WORK/results/discovery-report.txt"
TOOL="$WORK/tools/northstar-status"

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

echo "B1 — checking command discovery and self-service troubleshooting"
echo

if [[ ! -d "$WORK" ]]; then
    echo "B1 workspace not found. Run: bash setup.sh b1"
    exit 1
fi

if [[ -x "$TOOL" ]]; then
    pass "northstar-status fixture is executable"
else
    fail "tools/northstar-status should be executable"
fi

if [[ -f "$REPORT" ]]; then
    pass "discovery report exists"
else
    fail "results/discovery-report.txt does not exist"
    echo
    echo "Result: $pass_count passed, $fail_count failed"
    exit 1
fi

required_keys=(
    ls_human_option
    grep_c_counts
    passwd_command_section
    passwd_file_section
    cd_type
    bash_path
    northstar_status_path
)

for key in "${required_keys[@]}"; do
    count="$(grep -c "^$key=" "$REPORT" 2>/dev/null || true)"
    if [[ "$count" == "1" ]]; then
        pass "$key appears exactly once"
    else
        fail "$key should appear exactly once"
    fi
done

if grep -Fxq 'ls_human_option=-h' "$REPORT"; then
    pass "ls human-readable option"
else
    fail "ls_human_option should be -h"
fi

if grep -Fxq 'grep_c_counts=matching lines' "$REPORT"; then
    pass "grep -c behavior"
else
    fail "grep_c_counts should be 'matching lines'"
fi

if grep -Fxq 'passwd_command_section=1' "$REPORT"; then
    pass "passwd command manual section"
else
    fail "passwd_command_section should be 1"
fi

if grep -Fxq 'passwd_file_section=5' "$REPORT"; then
    pass "passwd file-format manual section"
else
    fail "passwd_file_section should be 5"
fi

if grep -Fxq 'cd_type=shell builtin' "$REPORT"; then
    pass "cd identified as shell builtin"
else
    fail "cd_type should be 'shell builtin'"
fi

expected_bash="$(command -v bash 2>/dev/null || true)"
reported_bash="$(grep '^bash_path=' "$REPORT" | head -n 1 | cut -d= -f2-)"

if [[ -n "$expected_bash" && "$reported_bash" == "$expected_bash" ]]; then
    pass "bash path matches current shell environment"
else
    fail "bash_path should match: $expected_bash"
fi

expected_tool="$(cd "$WORK" && pwd)/tools/northstar-status"
reported_tool="$(grep '^northstar_status_path=' "$REPORT" | head -n 1 | cut -d= -f2-)"

if [[ "$reported_tool" == "$expected_tool" ]]; then
    pass "northstar-status path matches lab workspace"
else
    fail "northstar_status_path should match: $expected_tool"
fi

echo
echo "Result: $pass_count passed, $fail_count failed"

if [[ $fail_count -eq 0 ]]; then
    echo "All scored B1 outcomes are correct."
    echo "Finish the exact-recall checkpoint in level-b/01-discovery/INSTRUCTIONS.md, then check level-b/01-discovery/ANSWERS.md."
    exit 0
else
    echo "One or more B1 outcomes need another look."
    exit 1
fi
