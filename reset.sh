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
        echo "Core Lab 1 reset to its starting state."
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
        echo "Core Lab 2 reset to its starting state."
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

        echo "Core Lab 3 reset to its starting state."
        ;;
    4|04|system|network)
        WORK="$ROOT_DIR/04-system-network/work"
        SOURCE="$ROOT_DIR/04-system-network/source"
        rm -rf "$WORK"
        mkdir -p "$WORK"
        cp -a "$SOURCE/." "$WORK/"
        mkdir -p "$WORK/results"
        echo "Core Lab 4 reset to its starting state."
        ;;
    5|05|script|scripting|bash)
        WORK="$ROOT_DIR/05-scripting/work"
        SOURCE="$ROOT_DIR/05-scripting/source"
        rm -rf "$WORK"
        mkdir -p "$WORK"
        cp -a "$SOURCE/." "$WORK/"
        mkdir -p "$WORK/scripts" "$WORK/results"
        chmod 0644 "$WORK/logs/"*.log
        echo "Core Lab 5 reset to its starting state."
        ;;
    l2-3|level2-3|level-2-3|advanced|advanced-scripting|7|07)
        WORK="$ROOT_DIR/level-2/03-bash/work"
        SOURCE="$ROOT_DIR/level-2/03-bash/source"
        rm -rf "$WORK"
        mkdir -p "$WORK"
        cp -a "$SOURCE/." "$WORK/"
        mkdir -p "$WORK/scripts" "$WORK/results"
        chmod 0644 "$WORK/systems/"*.status
        echo "Level 2 Lab 3 reset to its starting state."
        ;;
    *)
        echo "Built Core labs: 1, 2, 3, 4, 5."
        echo "Built Level 2 labs: l2-3."
        exit 1
        ;;
esac
