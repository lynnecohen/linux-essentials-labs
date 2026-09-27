#!/bin/bash
set -u

LAB_DIR="$(cd "$(dirname "$0")" && pwd)"
WORK="$LAB_DIR/work"

if [[ ! -d "$WORK" ]]; then
    echo "Lab 4 workspace not found. Run: bash setup.sh 4"
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

echo "Lab 4 — checking system and network inspection packet"
echo

if [[ -s "$WORK/results/processes.txt" ]] &&    grep -Eq '(^|[[:space:]])PID([[:space:]]|$)' "$WORK/results/processes.txt"; then
    pass "process snapshot"
else
    fail "process snapshot — results/processes.txt is missing or does not look like ps output"
fi

if [[ -s "$WORK/results/memory.txt" ]] &&    grep -q 'Mem:' "$WORK/results/memory.txt"; then
    pass "memory report"
else
    fail "memory report — results/memory.txt is missing or does not look like free output"
fi

if [[ -s "$WORK/results/ip-addresses.txt" ]] &&    grep -Eq '^[0-9]+: ' "$WORK/results/ip-addresses.txt" &&    grep -q 'inet' "$WORK/results/ip-addresses.txt"; then
    pass "interface address report"
else
    fail "interface address report — results/ip-addresses.txt is missing or does not look like ip addr output"
fi

if [[ -s "$WORK/results/routes.txt" ]]; then
    pass "routing table report"
else
    fail "routing table report — results/routes.txt is missing or empty"
fi

if [[ -s "$WORK/results/sockets.txt" ]] &&    grep -Eq 'Netid|State|Recv-Q|ESTAB|LISTEN' "$WORK/results/sockets.txt"; then
    pass "socket report"
else
    fail "socket report — results/sockets.txt is missing or does not look like ss output"
fi

if [[ -s "$WORK/results/hosts.txt" ]] &&    grep -Eq '127\.0\.0\.1|::1|localhost' "$WORK/results/hosts.txt"; then
    pass "hosts-file snapshot"
else
    fail "hosts-file snapshot — results/hosts.txt is missing or does not resemble /etc/hosts"
fi

if [[ -s "$WORK/results/resolv.conf.txt" ]]; then
    pass "resolver configuration snapshot"
else
    fail "resolver configuration snapshot — results/resolv.conf.txt is missing or empty"
fi

expected_path_map=$'config=/etc\nlogs=/var/log\nboot=/boot\nprocess-kernel=/proc\ndevices=/dev\nkernel-devices=/sys'
if [[ -f "$WORK/results/path-map.txt" ]] &&    [[ "$(cat "$WORK/results/path-map.txt")" == "$expected_path_map" ]]; then
    pass "system path recognition map"
else
    fail "system path recognition map — check results/path-map.txt"
fi

expected_tool_map=$'process-snapshot=ps\nprocess-live=top\nmemory=free\nkernel-messages=dmesg\naddress=ip addr show\nrouting=ip route show\ndns=host\nsockets=ss\nhosts-file=/etc/hosts\nresolver-file=/etc/resolv.conf\nlegacy-ifconfig=ip addr show\nlegacy-route=ip route show\nlegacy-netstat=ss'
if [[ -f "$WORK/results/tool-map.txt" ]] &&    [[ "$(cat "$WORK/results/tool-map.txt")" == "$expected_tool_map" ]]; then
    pass "system/network command recognition map"
else
    fail "system/network command recognition map — check results/tool-map.txt"
fi

echo
echo "Result: $pass_count passed, $fail_count failed"

if [[ $fail_count -eq 0 ]]; then
    echo "All scored Lab 4 outcomes are correct."
    echo "Finish the exact-recall checkpoint in 04-inspection/INSTRUCTIONS.md."
    exit 0
else
    echo "One or more Lab 4 outcomes need another look."
    echo "The checker validates output shape and recognition without revealing the commands."
    exit 1
fi
