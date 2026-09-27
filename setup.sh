#!/bin/bash
set -u

ROOT_DIR="$(cd "$(dirname "$0")" && pwd)"
LAB="${1:-1}"

case "$LAB" in
    1|01|incident)
        LAB_NUMBER=1
        LAB_DIR="01-incident"
        required_commands=(grep cut sort wc head tail cat less sha256sum)
        ;;
    2|02|backup|deployment)
        LAB_NUMBER=2
        LAB_DIR="02-backup-deployment"
        required_commands=(tar gzip bzip2 xz ln readlink diff cat)
        ;;
    3|03|users|permissions)
        LAB_NUMBER=3
        LAB_DIR="03-users-permissions"
        required_commands=(chmod ls id who w last cat less grep head stat)
        ;;
    4|04|system|network)
        LAB_NUMBER=4
        LAB_DIR="04-system-network"
        required_commands=(ps top free dmesg ip ss ping cat ls head grep)
        ;;
    5|05|script|scripting|bash)
        LAB_NUMBER=5
        LAB_DIR="05-scripting"
        required_commands=(bash chmod grep cat less)
        ;;
    7|07|advanced|advanced-scripting)
        LAB_NUMBER=7
        LAB_DIR="07-advanced-scripting"
        required_commands=(bash chmod grep cat less hostname)
        ;;
    *)
        echo "Built labs: 1, 2, 3, 4, 5, and optional 7."
        echo "Usage: bash setup.sh 1|2|3|4|5|7"
        exit 1
        ;;
esac

missing=()
for cmd in "${required_commands[@]}"; do
    if ! command -v "$cmd" >/dev/null 2>&1; then
        missing+=("$cmd")
    fi
done

if ((${#missing[@]} > 0)); then
    echo "Missing command(s): ${missing[*]}"
    echo "Install them before running Lab $LAB_NUMBER. No packages were changed automatically."
    exit 1
fi

bash "$ROOT_DIR/reset.sh" "$LAB_NUMBER"

echo
echo "Setup complete for Lab $LAB_NUMBER."
echo "Start with:   cd \"$ROOT_DIR/$LAB_DIR/work\""
echo "Read first:   $ROOT_DIR/$LAB_DIR/PRE_READING.md"
echo "Then follow:  $ROOT_DIR/$LAB_DIR/INSTRUCTIONS.md"

if [[ "$LAB_NUMBER" == "4" ]] && ! command -v host >/dev/null 2>&1; then
    echo
    echo "Note: 'host' is not installed on this system."
    echo "Lab 4 treats the DNS lookup exercise as environment-dependent; do not install extra software solely for the lab."
fi
