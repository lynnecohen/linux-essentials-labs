#!/bin/bash
set -u

ROOT_DIR="$(cd "$(dirname "$0")" && pwd)"
LAB="${1:-}"

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
        WORK="$ROOT_DIR/02-backup/work"
        SOURCE="$ROOT_DIR/02-backup/source"
        rm -rf "$WORK"
        mkdir -p "$WORK"
        cp -a "$SOURCE/." "$WORK/"
        mkdir -p "$WORK/results" "$WORK/restore"
        rm -f "$WORK/releases/current"
        ln -s 2026.09.03 "$WORK/releases/current"
        echo "Core Lab 2 reset to its starting state."
        ;;
    3|03|users|permissions)
        WORK="$ROOT_DIR/03-permissions/work"
        SOURCE="$ROOT_DIR/03-permissions/source"
        rm -rf "$WORK"
        mkdir -p "$WORK"
        cp -a "$SOURCE/." "$WORK/"
        mkdir -p "$WORK/results"

        chmod 0644 "$WORK/files/deploy.sh"
        chmod 0644 "$WORK/files/healthcheck.sh"
        chmod 0664 "$WORK/files/portal.conf"
        chmod 0644 "$WORK/files/secret.key"
        chmod 0777 "$WORK/files/shared-drop"
        chmod 0644 "$WORK/files/shared-drop/README.txt"
        chmod 0644 "$WORK/accounts/passwd" "$WORK/accounts/group"
        chmod 0640 "$WORK/accounts/shadow"

        echo "Core Lab 3 reset to its starting state."
        ;;
    4|04|system|network)
        WORK="$ROOT_DIR/04-inspection/work"
        SOURCE="$ROOT_DIR/04-inspection/source"
        rm -rf "$WORK"
        mkdir -p "$WORK"
        cp -a "$SOURCE/." "$WORK/"
        mkdir -p "$WORK/results"
        echo "Core Lab 4 reset to its starting state."
        ;;
    5|05|script|scripting|bash)
        WORK="$ROOT_DIR/05-bash/work"
        SOURCE="$ROOT_DIR/05-bash/source"
        rm -rf "$WORK"
        mkdir -p "$WORK"
        cp -a "$SOURCE/." "$WORK/"
        mkdir -p "$WORK/scripts" "$WORK/results"
        chmod 0644 "$WORK/logs/"*.log
        echo "Core Lab 5 reset to its starting state."
        ;;
    6|06|capstone)
        WORK="$ROOT_DIR/06-capstone/work"
        SOURCE="$ROOT_DIR/06-capstone/source"
        rm -rf "$WORK"
        mkdir -p "$WORK"
        cp -a "$SOURCE/." "$WORK/"
        mkdir -p "$WORK/backups" "$WORK/restore" "$WORK/results" "$WORK/scripts"

        rm -f "$WORK/releases/current"
        ln -s 2026.09.99 "$WORK/releases/current"

        chmod 0644 "$WORK/files/healthcheck.sh"
        chmod 0644 "$WORK/files/deploy.key"
        chmod 0777 "$WORK/files/shared-drop"
        chmod 0644 "$WORK/files/shared-drop/README.txt"

        SEED="$WORK/.config-seed"
        mkdir -p "$SEED/config"
        cat > "$SEED/config/portal.conf" <<'EOF'
environment=production
api_host=api-prod.internal
log_level=info
EOF
        tar -czf "$WORK/backups/config.tar.gz" -C "$SEED" config/portal.conf
        rm -rf "$SEED"

        echo "Core Lab 6 reset to its starting state."
        ;;
    *)
        echo "Built Core labs: 1, 2, 3, 4, 5, 6."
        echo "Usage: bash reset.sh 1|2|3|4|5|6"
        exit 1
        ;;
esac
