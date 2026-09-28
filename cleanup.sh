#!/bin/bash
set -u

ROOT_DIR="$(cd "$(dirname "$0")" && pwd)"
LAB="${1:-}"

case "$LAB" in
    1|01|incident)
        rm -rf "$ROOT_DIR/01-incident/work"
        echo "Core Lab 1 generated workspace removed."
        ;;
    2|02|backup|deployment)
        rm -rf "$ROOT_DIR/02-backup/work"
        echo "Core Lab 2 generated workspace removed."
        ;;
    3|03|users|permissions)
        rm -rf "$ROOT_DIR/03-permissions/work"
        echo "Core Lab 3 generated workspace removed."
        ;;
    4|04|system|network)
        rm -rf "$ROOT_DIR/04-inspection/work"
        echo "Core Lab 4 generated workspace removed."
        ;;
    5|05|script|scripting|bash)
        rm -rf "$ROOT_DIR/05-bash/work"
        echo "Core Lab 5 generated workspace removed."
        ;;
    6|06|capstone)
        rm -rf "$ROOT_DIR/06-capstone/work"
        echo "Core Lab 6 generated workspace removed."
        ;;
    *)
        echo "Built Core labs: 1, 2, 3, 4, 5, 6."
        echo "Usage: bash cleanup.sh 1|2|3|4|5|6"
        exit 1
        ;;
esac
