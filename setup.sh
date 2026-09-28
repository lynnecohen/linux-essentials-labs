#!/bin/bash
set -u

ROOT_DIR="$(cd "$(dirname "$0")" && pwd)"
LAB="${1:-1}"

case "$LAB" in
    1|01|incident)
        LAB_ID="1"
        LAB_LABEL="Core Lab 1"
        LAB_DIR="01-incident"
        required_commands=(grep cut sort wc head tail cat less sha256sum)
        ;;
    2|02|backup|deployment)
        LAB_ID="2"
        LAB_LABEL="Core Lab 2"
        LAB_DIR="02-backup"
        required_commands=(tar gzip bzip2 xz ln readlink diff cat)
        ;;
    3|03|users|permissions)
        LAB_ID="3"
        LAB_LABEL="Core Lab 3"
        LAB_DIR="03-permissions"
        required_commands=(chmod ls id who w last cat less grep head stat)
        ;;
    4|04|system|network)
        LAB_ID="4"
        LAB_LABEL="Core Lab 4"
        LAB_DIR="04-inspection"
        required_commands=(ps top free dmesg ip ss ping cat ls head grep)
        ;;
    5|05|script|scripting|bash)
        LAB_ID="5"
        LAB_LABEL="Core Lab 5"
        LAB_DIR="05-bash"
        required_commands=(bash chmod grep cat less)
        ;;
    6|06|capstone)
        LAB_ID="6"
        LAB_LABEL="Core Lab 6"
        LAB_DIR="06-capstone"
        required_commands=(bash grep cut sort wc head tail tar ln readlink chmod stat cat less id ps top free dmesg ip ss who w last cmp tr)
        ;;
    l2-3|level2-3|level-2-3|advanced|advanced-scripting|7|07)
        LAB_ID="l2-3"
        LAB_LABEL="Level 2 Lab 3"
        LAB_DIR="level-2/03-bash"
        required_commands=(bash chmod grep cat less hostname)
        ;;
    *)
        echo "Built Core labs: 1, 2, 3, 4, 5, 6."
        echo "Built Level 2 labs: l2-3."
        echo "Usage: bash setup.sh 1|2|3|4|5|6|l2-3"
        exit 1
        ;;
esac

missing=()
for cmd in "${required_commands[@]}"; do
    if ! command -v "$cmd" >/dev/null 2>&1; then
        missing+=("$cmd")
    fi
done

if (("${#missing[@]}" > 0)); then
    echo "Missing command(s): ${missing[*]}"
    echo "Install them before running $LAB_LABEL. No packages were changed automatically."
    exit 1
fi

bash "$ROOT_DIR/reset.sh" "$LAB_ID"

echo
echo "Setup complete for $LAB_LABEL."
echo "Start with:   cd \"$ROOT_DIR/$LAB_DIR/work\""
echo "Read first:   $ROOT_DIR/$LAB_DIR/PRE_READING.md"
echo "Then follow:  $ROOT_DIR/$LAB_DIR/INSTRUCTIONS.md"

if [[ "$LAB_ID" == "4" ]] && ! command -v host >/dev/null 2>&1; then
    echo
    echo "Note: 'host' is not installed on this system."
    echo "Core Lab 4 treats the DNS lookup exercise as environment-dependent; do not install extra software solely for the lab."
fi

if [[ "$LAB_ID" == "6" ]] && ! command -v host >/dev/null 2>&1; then
    echo
    echo "Note: 'host' is not installed on this system."
    echo "Core Lab 6 still expects you to know the Linux Essentials DNS command association; do not install extra software solely for the capstone."
fi
