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
    *)
        echo "Built labs: 1, 2, 3, and 4."
        exit 1
        ;;
esac
