#!/bin/bash
set -u

LAB_DIR="$(cd "$(dirname "$0")" && pwd)"
WORK="$LAB_DIR/work"
EXPECTED="$LAB_DIR/.expected.sha256"

if [[ ! -d "$WORK" ]]; then
    echo "Lab 1 workspace not found. Run: bash setup.sh 1"
    exit 1
fi

cd "$WORK" || exit 1

echo "Lab 1 — checking required output files"
echo

hash_ok=1

while read -r expected_hash file; do
    if [[ ! -f "$file" ]]; then
        echo "$file: FAILED — missing"
        hash_ok=0
        continue
    fi

    actual_hash="$(sha256sum "$file" | cut -d' ' -f1)"
    if [[ "$actual_hash" == "$expected_hash" ]]; then
        echo "$file: OK"
    else
        echo "$file: FAILED — content does not match"
        hash_ok=0
    fi
done < "$EXPECTED"

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
    echo "Finish the exact-recall checkpoint in 01-incident/INSTRUCTIONS.md, then check 01-incident/ANSWERS.md."
    exit 0
else
    echo "One or more artifacts need another look."
    echo "The checker validates output only; it intentionally does not show solution commands."
    exit 1
fi
