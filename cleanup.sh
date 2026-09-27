#!/bin/bash
set -u

ROOT_DIR="$(cd "$(dirname "$0")" && pwd)"
LAB="${1:-1}"

case "$LAB" in
    1|01|incident)
        rm -rf "$ROOT_DIR/01-incident/work"
        echo "Lab 1 generated workspace removed."
        ;;
    2|02|backup|deployment)
        rm -rf "$ROOT_DIR/02-backup-deployment/work"
        echo "Lab 2 generated workspace removed."
        ;;
    3|03|users|permissions)
        rm -rf "$ROOT_DIR/03-users-permissions/work"
        echo "Lab 3 generated workspace removed."
        ;;
    4|04|system|network)
        rm -rf "$ROOT_DIR/04-system-network/work"
        echo "Lab 4 generated workspace removed."
        ;;
    5|05|script|scripting|bash)
        rm -rf "$ROOT_DIR/05-scripting/work"
        echo "Lab 5 generated workspace removed."
        ;;
    *)
        echo "Built labs: 1, 2, 3, 4, and 5."
        exit 1
        ;;
esac
