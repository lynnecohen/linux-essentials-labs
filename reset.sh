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
    *)
        echo "Built labs: 1 and 2."
        exit 1
        ;;
esac
