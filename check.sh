#!/bin/bash
set -u

ROOT_DIR="$(cd "$(dirname "$0")" && pwd)"
LAB="${1:-}"

case "$LAB" in
    1|01|incident)
        exec bash "$ROOT_DIR/01-incident/check.sh"
        ;;
    2|02|backup|deployment)
        exec bash "$ROOT_DIR/02-backup/check.sh"
        ;;
    3|03|users|permissions)
        exec bash "$ROOT_DIR/03-permissions/check.sh"
        ;;
    4|04|system|network)
        exec bash "$ROOT_DIR/04-inspection/check.sh"
        ;;
    5|05|script|scripting|bash)
        exec bash "$ROOT_DIR/05-bash/check.sh"
        ;;
    6|06|capstone)
        exec bash "$ROOT_DIR/06-capstone/check.sh"
        ;;
    *)
        echo "Built Core labs: 1, 2, 3, 4, 5, 6."
        echo "Usage: bash check.sh 1|2|3|4|5|6"
        exit 1
        ;;
esac
