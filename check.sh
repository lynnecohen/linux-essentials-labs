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
    7|07|advanced|advanced-scripting)
        exec bash "$ROOT_DIR/07-advanced-scripting/check.sh"
        ;;
    *)
        echo "Built labs: 1, 2, 3, 4, 5, and optional 7."
        exit 1
        ;;
esac
