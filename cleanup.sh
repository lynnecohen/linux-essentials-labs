#!/bin/bash
set -u

ROOT_DIR="$(cd "$(dirname "$0")" && pwd)"
LAB="${1:-1}"

case "$LAB" in
    1|01|incident)
        rm -rf "$ROOT_DIR/01-incident/work"
        echo "Lab 1 generated workspace removed."
        ;;
    *)
        echo "Only Lab 1 is built right now."
        exit 1
        ;;
esac
