#!/bin/bash
set -u

ROOT_DIR="$(cd "$(dirname "$0")" && pwd)"
LAB="${1:-1}"

case "$LAB" in
    1|01|incident)
        WORK="$ROOT_DIR/01-incident/work"
        SOURCE="$ROOT_DIR/01-incident/source"
        rm -rf "$WORK"
        mkdir -p "$WORK/results"
        cp -r "$SOURCE/." "$WORK/"
        mkdir -p "$WORK/results"
        echo "Lab 1 reset to its starting state."
        ;;
    *)
        echo "Only Lab 1 is built right now."
        exit 1
        ;;
esac
