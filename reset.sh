#!/bin/bash
set -u

ROOT_DIR="$(cd "$(dirname "$0")" && pwd)"
LAB="${1:-1}"

case "$LAB" in
    1|01|incident)
        WORK="$ROOT_DIR/01-incident/work"
        SOURCE="$ROOT_DIR/01-incident/source"
        rm -rf "$WORK"
        mkdir -p "$WORK"
        cp -a "$SOURCE/." "$WORK/"
        mkdir -p "$WORK/results"
        echo "Lab 1 reset to its starting state."
        ;;
    2|02|backup|deployment)
        WORK="$ROOT_DIR/02-backup-deployment/work"
        SOURCE="$ROOT_DIR/02-backup-deployment/source"
        rm -rf "$WORK"
        mkdir -p "$WORK"
        cp -a "$SOURCE/." "$WORK/"
        mkdir -p "$WORK/results" "$WORK/restore"
        rm -f "$WORK/releases/current"
        ln -s release-2026.09.03 "$WORK/releases/current"
        echo "Lab 2 reset to its starting state."
        ;;
    3|03|users|permissions)
        WORK="$ROOT_DIR/03-users-permissions/work"
        SOURCE="$ROOT_DIR/03-users-permissions/source"
        rm -rf "$WORK"
        mkdir -p "$WORK"
        cp -a "$SOURCE/." "$WORK/"
        mkdir -p "$WORK/results"

        chmod 0644 "$WORK/permissions/deploy.sh"
        chmod 0644 "$WORK/permissions/healthcheck.sh"
        chmod 0664 "$WORK/permissions/portal.conf"
        chmod 0644 "$WORK/permissions/secret.key"
        chmod 0777 "$WORK/permissions/shared-drop"
        chmod 0644 "$WORK/permissions/shared-drop/README.txt"
        chmod 0644 "$WORK/account-db/passwd" "$WORK/account-db/group"
        chmod 0640 "$WORK/account-db/shadow"

        echo "Lab 3 reset to its starting state."
        ;;
    *)
        echo "Built labs: 1, 2, and 3."
        exit 1
        ;;
esac
