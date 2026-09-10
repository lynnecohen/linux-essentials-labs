#!/bin/bash
set -u

ROOT_DIR="$(cd "$(dirname "$0")" && pwd)"
LAB="${1:-1}"

case "$LAB" in
    1|01|incident)
        exec "$ROOT_DIR/01-incident/check.sh"
        ;;
    2|02|backup|deployment)
        exec "$ROOT_DIR/02-backup-deployment/check.sh"
        ;;
    *)
        echo "Built labs: 1 and 2."
        exit 1
        ;;
esac
