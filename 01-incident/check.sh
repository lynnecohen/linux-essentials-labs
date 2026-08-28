#!/bin/bash
set -u

LAB_DIR="$(cd "$(dirname "$0")" && pwd)"
WORK="$LAB_DIR/work"
EXPECTED="$LAB_DIR/.expected.sha256"

if [[ ! -d "$WORK" ]]; then
    echo "Lab 1 workspace not found. Run: bash setup.sh"
    exit 1
fi

cd "$WORK" || exit 1

echo "Lab 1 — checking required output files"
echo

hash_ok=0
if sha256sum -c "$EXPECTED"; then
    hash_ok=1
fi

echo
stderr_ok=0
if [[ -s results/stderr.txt ]] && grep -q "missing-config.ini" results/stderr.txt; then
    echo "results/stderr.txt: OK"
    stderr_ok=1
else
    echo "results/stderr.txt: FAILED"
fi

echo
if [[ $hash_ok -eq 1 && $stderr_ok -eq 1 ]]; then
    echo "All scored Lab 1 artifacts are correct."
    echo "Finish the exact-recall checkpoint in 01-incident/README.md before moving on."
    exit 0
else
    echo "One or more artifacts need another look."
    echo "The checker validates output only; it intentionally does not show solution commands."
    exit 1
fi
