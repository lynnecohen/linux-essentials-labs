#!/bin/bash
set -u

ROOT_DIR="$(cd "$(dirname "$0")" && pwd)"

required_commands=(grep cut sort wc head tail cat less sha256sum)
missing=()

for cmd in "${required_commands[@]}"; do
    if ! command -v "$cmd" >/dev/null 2>&1; then
        missing+=("$cmd")
    fi
done

if ((${#missing[@]} > 0)); then
    echo "Missing command(s): ${missing[*]}"
    echo "Install them before running Lab 1. No packages were changed automatically."
    exit 1
fi

chmod +x "$ROOT_DIR/reset.sh" "$ROOT_DIR/cleanup.sh" "$ROOT_DIR/check.sh" "$ROOT_DIR/01-incident/check.sh"
"$ROOT_DIR/reset.sh" 1

echo
echo "Setup complete."
echo "Start Lab 1 with: cd \"$ROOT_DIR/01-incident/work\""
echo "Instructions:     $ROOT_DIR/01-incident/README.md"
