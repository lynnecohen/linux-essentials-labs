#!/bin/bash
set -u

LAB_DIR="$(cd "$(dirname "$0")" && pwd)"
WORK="$LAB_DIR/work"

if [[ ! -d "$WORK" ]]; then
    echo "Lab 3 workspace not found. Run: bash setup.sh 3"
    exit 1
fi

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

check_mode() {
    local label="$1"
    local path="$2"
    local expected="$3"

    if [[ ! -e "$path" ]]; then
        fail "$label — path is missing"
        return
    fi

    local actual
    actual="$(stat -c '%a' "$path" 2>/dev/null || true)"
    if [[ "$actual" == "$expected" ]]; then
        pass "$label"
    else
        fail "$label — permission state is not correct"
    fi
}

echo "Lab 3 — checking permission and account-recognition outcomes"
echo

check_mode "deploy.sh owner execute permission" "$WORK/files/deploy.sh" "744"
check_mode "healthcheck.sh numeric mode" "$WORK/files/healthcheck.sh" "755"
check_mode "portal.conf group-write removal" "$WORK/files/portal.conf" "644"
check_mode "secret.key restricted mode" "$WORK/files/secret.key" "600"
check_mode "shared-drop sticky directory" "$WORK/files/shared-drop" "1777"

if [[ -s "$WORK/results/current-id.txt" ]] &&    grep -q 'uid=' "$WORK/results/current-id.txt" &&    grep -q 'gid=' "$WORK/results/current-id.txt"; then
    pass "saved id output"
else
    fail "saved id output — results/current-id.txt is missing or does not look like id output"
fi

expected_account_map=$'user-identity=/etc/passwd\npassword-data=/etc/shadow\ngroup-data=/etc/group'
if [[ -f "$WORK/results/account-files.txt" ]] &&    [[ "$(cat "$WORK/results/account-files.txt")" == "$expected_account_map" ]]; then
    pass "account-file recognition map"
else
    fail "account-file recognition map — check results/account-files.txt"
fi

if [[ -f "$WORK/files/shared-drop/README.txt" ]]; then
    pass "shared-drop contents preserved"
else
    fail "shared-drop contents preserved — README.txt is missing"
fi

echo
echo "Result: $pass_count passed, $fail_count failed"

if [[ $fail_count -eq 0 ]]; then
    echo "All scored Lab 3 outcomes are correct."
    echo "Finish the exact-recall checkpoint in 03-files/INSTRUCTIONS.md."
    exit 0
else
    echo "One or more Lab 3 outcomes need another look."
    echo "The checker validates state without revealing the required commands."
    exit 1
fi
