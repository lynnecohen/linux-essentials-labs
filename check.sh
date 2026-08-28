#!/bin/bash
set -u

ROOT_DIR="$(cd "$(dirname "$0")" && pwd)"
LAB="${1:-1}"

case "$LAB" in
    1|01|incident)
        exec "$ROOT_DIR/01-incident/check.sh"
        ;;
    *)
        echo "Only Lab 1 is built right now."
        exit 1
        ;;
esac
