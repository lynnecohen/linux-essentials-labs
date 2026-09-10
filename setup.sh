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
    *)
        echo "Built labs: 1 and 2."
        echo "Usage: bash setup.sh 1|2"
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

chmod +x "$ROOT_DIR/reset.sh" "$ROOT_DIR/cleanup.sh" "$ROOT_DIR/check.sh"
if [[ -f "$ROOT_DIR/$LAB_DIR/check.sh" ]]; then
    chmod +x "$ROOT_DIR/$LAB_DIR/check.sh"
fi

"$ROOT_DIR/reset.sh" "$LAB_NUMBER"

echo
echo "Setup complete for Lab $LAB_NUMBER."
echo "Start with:   cd \"$ROOT_DIR/$LAB_DIR/work\""
echo "Reading:      $ROOT_DIR/$LAB_DIR/READING.md"
echo "Instructions: $ROOT_DIR/$LAB_DIR/README.md"
