#!/bin/bash
set -u

LAB_DIR="$(cd "$(dirname "$0")" && pwd)"
WORK="$LAB_DIR/work"

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

echo "Core Lab 6 — checking capstone outcomes"
echo

if [[ ! -d "$WORK" ]]; then
    echo "Capstone workspace not found. Run: bash setup.sh 6"
    exit 1
fi

# Deployment state
if [[ -L "$WORK/releases/current" ]] &&
   [[ "$(readlink "$WORK/releases/current")" == "2026.09.24" ]] &&
   [[ "$(cat "$WORK/releases/current/VERSION" 2>/dev/null)" == "2026.09.24" ]] &&
   [[ -d "$WORK/releases/2026.09.17" ]]; then
    pass "active release symlink is correct and prior release remains"
else
    fail "releases/current should be a relative link to 2026.09.24 while 2026.09.17 remains"
fi

if [[ -f "$WORK/backups/config.tar.gz" ]] && tar -tzf "$WORK/backups/config.tar.gz" >/dev/null 2>&1; then
    pass "configuration backup archive remains intact"
else
    fail "backups/config.tar.gz is missing or no longer a valid gzip-compressed tar archive"
fi

if [[ -f "$WORK/config/portal.conf" ]] &&
   [[ "$(wc -l < "$WORK/config/portal.conf")" -eq 3 ]] &&
   grep -Fxq 'environment=production' "$WORK/config/portal.conf" &&
   grep -Fxq 'api_host=api-prod.internal' "$WORK/config/portal.conf" &&
   grep -Fxq 'log_level=info' "$WORK/config/portal.conf"; then
    pass "production configuration restored"
else
    fail "config/portal.conf does not match the archived production configuration"
fi

# Permissions
if [[ -x "$WORK/files/healthcheck.sh" ]]; then
    pass "healthcheck is directly executable"
else
    fail "files/healthcheck.sh needs execute permission"
fi

if [[ "$(stat -c '%a' "$WORK/files/deploy.key" 2>/dev/null)" == "600" ]]; then
    pass "deployment key is owner read/write only"
else
    fail "files/deploy.key should have mode 600"
fi

if [[ "$(stat -c '%a' "$WORK/files/shared-drop" 2>/dev/null)" == "1777" ]]; then
    pass "shared drop retains world write and has sticky bit"
else
    fail "files/shared-drop should have mode 1777"
fi

# Incident packet
EXPECTED_ERRORS="$WORK/results/.expected-errors.txt"
cat > "$EXPECTED_ERRORS" <<'EOF'
logs/app.log:2:2026-09-27T18:01:14 ERROR database timeout after 30s
logs/app.log:5:2026-09-27T18:02:47 error payment service unavailable
logs/archive/app-1.log:2:2026-09-26T23:44:19 ERROR timeout contacting database
logs/archive/app-1.log:4:2026-09-26T23:45:09 error worker crashed
logs/archive/older/auth-1.log:2:2026-09-25T07:11:18 ERROR permission denied user=legacy
logs/auth.log:2:2026-09-27T18:00:51 Error invalid token user=bob
EOF

if [[ -f "$WORK/results/errors.txt" ]] && cmp -s "$EXPECTED_ERRORS" "$WORK/results/errors.txt"; then
    pass "recursive non-DEBUG error inventory"
else
    fail "results/errors.txt does not match the required sorted error inventory"
fi

if [[ -f "$WORK/results/timeouts.txt" ]] &&
   [[ "$(tr -d '[:space:]' < "$WORK/results/timeouts.txt")" == "4" ]]; then
    pass "recursive timeout total"
else
    fail "results/timeouts.txt should contain only the total timeout count"
fi

EXPECTED_SUPPORT="$WORK/results/.expected-support.txt"
cat > "$EXPECTED_SUPPORT" <<'EOF'
alice
dana
frank
EOF

if [[ -f "$WORK/results/support.txt" ]] && cmp -s "$EXPECTED_SUPPORT" "$WORK/results/support.txt"; then
    pass "active support usernames"
else
    fail "results/support.txt does not match the required sorted usernames"
fi

EXPECTED_SLOW="$WORK/results/.expected-slow.txt"
cat > "$EXPECTED_SLOW" <<'EOF'
1100
850
640
EOF

if [[ -f "$WORK/results/slowest.txt" ]] && cmp -s "$EXPECTED_SLOW" "$WORK/results/slowest.txt"; then
    pass "three slowest response times"
else
    fail "results/slowest.txt should contain the three largest numeric values in descending order"
fi

# System/session recall artifacts
EXPECTED_MAP="$WORK/results/.expected-map.txt"
cat > "$EXPECTED_MAP" <<'EOF'
process-snapshot=ps
process-live=top
memory=free
addresses=ip addr show
routes=ip route show
dns=host
sockets=ss
current-users=who
user-activity=w
login-history=last
EOF

if [[ -f "$WORK/results/tool-map.txt" ]] && cmp -s "$EXPECTED_MAP" "$WORK/results/tool-map.txt"; then
    pass "system/network/session command map"
else
    fail "results/tool-map.txt does not match the Core command associations"
fi

if [[ -s "$WORK/results/id.txt" ]] &&
   grep -q 'uid=' "$WORK/results/id.txt" &&
   grep -q 'gid=' "$WORK/results/id.txt"; then
    pass "current identity information captured"
else
    fail "results/id.txt should contain UID/GID/group output"
fi

# Bash script structure and behavior
SCRIPT="$WORK/scripts/handoff.sh"

if [[ -f "$SCRIPT" ]]; then
    pass "handoff script exists"
else
    fail "scripts/handoff.sh does not exist"
fi

if [[ -f "$SCRIPT" ]]; then
    if [[ "$(head -n 1 "$SCRIPT")" == '#!/bin/bash' ]]; then
        pass "handoff script uses Bash shebang"
    else
        fail "handoff script should begin with #!/bin/bash"
    fi

    if grep -Eq '^[[:space:]]*#[^!]' "$SCRIPT"; then
        pass "handoff script contains a useful comment"
    else
        fail "handoff script needs at least one ordinary comment"
    fi

    if grep -Eq '^[[:space:]]*[A-Za-z_][A-Za-z0-9_]*=.*\$1' "$SCRIPT" &&
       grep -Eq '^[[:space:]]*[A-Za-z_][A-Za-z0-9_]*=.*\$2' "$SCRIPT"; then
        pass "positional arguments assigned to named variables"
    else
        fail "handoff script should assign both $1 and $2 to named variables"
    fi

    if grep -Eq 'for[[:space:]]+[A-Za-z_][A-Za-z0-9_]*[[:space:]]+in[[:space:]]+logs/\*\.log' "$SCRIPT"; then
        pass "handoff script loops over top-level logs"
    else
        fail "handoff script should use a basic for loop over logs/*.log"
    fi

    if grep -Eq 'grep[[:space:]]+-[^[:space:]]*i[^[:space:]]*[[:space:]]' "$SCRIPT" &&
       grep -Fq '$?' "$SCRIPT"; then
        pass "case-insensitive grep and exit-status reporting are present"
    else
        fail "handoff script should use case-insensitive grep and record $?"
    fi

    if [[ -x "$SCRIPT" ]]; then
        pass "handoff script is directly executable"
    else
        fail "scripts/handoff.sh needs execute permission"
    fi

    if [[ -x "$SCRIPT" ]]; then
        TMP_REPORT="$WORK/results/.checker-script.txt"
        rm -f "$TMP_REPORT"
        (
            cd "$WORK" || exit 99
            ./scripts/handoff.sh "results/.checker-script.txt" "checker run"
        ) >/dev/null 2>&1
        script_status=$?

        if [[ $script_status -eq 0 ]] &&
           [[ -f "$TMP_REPORT" ]] &&
           grep -Fxq 'Northstar handoff: checker run' "$TMP_REPORT" &&
           grep -Fxq 'Log checks:' "$TMP_REPORT" &&
           grep -Fxq 'logs/app.log' "$TMP_REPORT" &&
           grep -Fxq 'logs/auth.log' "$TMP_REPORT" &&
           grep -Fxq 'logs/worker.log' "$TMP_REPORT" &&
           [[ "$(grep -c '^grep-status=0$' "$TMP_REPORT")" -eq 2 ]] &&
           [[ "$(grep -c '^grep-status=1$' "$TMP_REPORT")" -eq 1 ]]; then
            pass "handoff script behaves correctly when executed directly"
        else
            fail "handoff script output/exit-status behavior does not match the required interface"
        fi
    fi
fi

if [[ -f "$WORK/results/script-report.txt" ]] &&
   grep -Fxq 'Northstar handoff: deployment handoff' "$WORK/results/script-report.txt"; then
    pass "learner-generated direct-execution report"
else
    fail "results/script-report.txt is missing or has the wrong label"
fi

EXPECTED_HANDOFF="$WORK/results/.expected-handoff.txt"
cat > "$EXPECTED_HANDOFF" <<'EOF'
release=2026.09.24
config-environment=production
timeout-count=4
active-support-count=3
slowest-latency=1100
EOF

if [[ -f "$WORK/results/handoff.txt" ]] && cmp -s "$EXPECTED_HANDOFF" "$WORK/results/handoff.txt"; then
    pass "final handoff summary"
else
    fail "results/handoff.txt does not match the recovered state"
fi

rm -f     "$EXPECTED_ERRORS"     "$EXPECTED_SUPPORT"     "$EXPECTED_SLOW"     "$EXPECTED_MAP"     "$EXPECTED_HANDOFF"     "$WORK/results/.checker-script.txt"

echo
echo "Result: $pass_count passed, $fail_count failed"

if [[ $fail_count -eq 0 ]]; then
    echo "All scored Core Lab 6 capstone outcomes are correct."
    echo "Finish the exact-recall checkpoint in 06-capstone/INSTRUCTIONS.md."
    exit 0
else
    echo "One or more capstone outcomes need another look."
    exit 1
fi
