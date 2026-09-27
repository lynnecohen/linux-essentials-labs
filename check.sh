#!/bin/bash
set -u

ROOT_DIR="$(cd "$(dirname "$0")" && pwd)"
LAB="${1:-1}"

case "$LAB" in
    1|01|incident)
        exec bash "$ROOT_DIR/01-incident/check.sh"
        ;;
    2|02|backup|deployment)
        exec bash "$ROOT_DIR/02-backup-deployment/check.sh"
        ;;
    3|03|users|permissions)
        exec bash "$ROOT_DIR/03-users-permissions/check.sh"
        ;;
    4|04|system|network)
        exec bash "$ROOT_DIR/04-system-network/check.sh"
        ;;
    5|05|script|scripting|bash)
        exec bash "$ROOT_DIR/05-scripting/check.sh"
        ;;
    l2-3|level2-3|level-2-3|advanced|advanced-scripting|7|07)
        exec bash "$ROOT_DIR/level-2/03-bash/check.sh"
        ;;
    *)
        echo "Built Core labs: 1, 2, 3, 4, 5."
        echo "Built Level 2 labs: l2-3."
        exit 1
        ;;
esac
