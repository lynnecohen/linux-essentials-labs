#!/bin/bash
set -u

LAB_DIR="$(cd "$(dirname "$0")" && pwd)"
WORK="$LAB_DIR/work"
SOURCE="$LAB_DIR/source"

if [[ ! -d "$WORK" ]]; then
    echo "Lab 2 workspace not found. Run: bash setup.sh 2"
    exit 1
fi

pass_count=0
fail_count=0

pass() {
    echo "PASS: $1"
    pass_count=$((pass_count + 1))
}

fail() {
    echo "FAIL: $1"
    fail_count=$((fail_count + 1))
}

normalized_tar_listing() {
    local mode="$1"
    local archive="$2"
    tar "$mode" "$archive" 2>/dev/null | sed 's#^\./##'
}

check_archive_members() {
    local label="$1"
    local archive="$2"
    local mode="$3"
    shift 3

    if [[ ! -f "$archive" ]]; then
        fail "$label — archive is missing"
        return
    fi

    local listing
    if ! listing="$(normalized_tar_listing "$mode" "$archive")"; then
        fail "$label — archive cannot be read with the expected compression mode"
        return
    fi

    local member
    for member in "$@"; do
        if ! grep -Fxq "$member" <<< "$listing"; then
            fail "$label — required archive member is missing: $member"
            return
        fi
    done

    pass "$label"
}

check_saved_listing() {
    local label="$1"
    local listing_file="$2"
    shift 2

    if [[ ! -s "$listing_file" ]]; then
        fail "$label — saved listing is missing or empty"
        return
    fi

    local listing
    listing="$(sed 's#^\./##' "$listing_file")"

    local member
    for member in "$@"; do
        if ! grep -Fxq "$member" <<< "$listing"; then
            fail "$label — expected member is not present: $member"
            return
        fi
    done

    pass "$label"
}

echo "Lab 2 — checking backup, restore, and deployment state"
echo

check_archive_members \
    "gzip release backup" \
    "$WORK/results/release-2026.09.03.tar.gz" \
    "-tzf" \
    "releases/release-2026.09.03/VERSION" \
    "releases/release-2026.09.03/app/index.html" \
    "releases/release-2026.09.03/app/settings.conf" \
    "releases/release-2026.09.03/static/motd.txt"

check_saved_listing \
    "gzip archive member listing" \
    "$WORK/results/release-2026.09.03.contents.txt" \
    "releases/release-2026.09.03/VERSION" \
    "releases/release-2026.09.03/app/index.html" \
    "releases/release-2026.09.03/app/settings.conf" \
    "releases/release-2026.09.03/static/motd.txt"

if [[ -d "$WORK/restore/gzip/releases/release-2026.09.03" ]] && \
   diff -r "$SOURCE/releases/release-2026.09.03" "$WORK/restore/gzip/releases/release-2026.09.03" >/dev/null 2>&1; then
    pass "gzip restore matches the original release"
else
    fail "gzip restore does not match the original release"
fi

check_archive_members \
    "bzip2 configuration backup" \
    "$WORK/results/config-backup.tar.bz2" \
    "-tjf" \
    "config/portal.conf" \
    "config/maintenance.conf"

if [[ -d "$WORK/restore/bzip2/config" ]] && \
   diff -r "$SOURCE/config" "$WORK/restore/bzip2/config" >/dev/null 2>&1; then
    pass "bzip2 restore matches the original configuration"
else
    fail "bzip2 restore does not match the original configuration"
fi

check_archive_members \
    "xz deployment-notes backup" \
    "$WORK/results/deployment-notes.tar.xz" \
    "-tJf" \
    "notes/deployment-notes.txt"

check_saved_listing \
    "xz archive member listing" \
    "$WORK/results/deployment-notes-xz.contents.txt" \
    "notes/deployment-notes.txt"

check_archive_members \
    "plain tar archive" \
    "$WORK/results/deployment-notes.tar" \
    "-tf" \
    "notes/deployment-notes.txt"

if [[ -L "$WORK/releases/current" ]]; then
    link_target="$(readlink "$WORK/releases/current")"
    if [[ "$link_target" == "release-2026.09.10" ]] && \
       [[ -d "$WORK/releases/release-2026.09.03" ]] && \
       [[ "$(cat "$WORK/releases/current/VERSION" 2>/dev/null)" == "2026.09.10" ]]; then
        pass "current is a relative symlink to the new release and the prior release remains"
    else
        fail "current symlink target or release state is not correct"
    fi
else
    fail "releases/current is not a symbolic link"
fi

echo
echo "Result: $pass_count passed, $fail_count failed"

if [[ $fail_count -eq 0 ]]; then
    echo "All scored Lab 2 outcomes are correct."
    echo "Finish the exact-recall checkpoint in 02-backup-deployment/INSTRUCTIONS.md."
    exit 0
else
    echo "One or more Lab 2 outcomes need another look."
    echo "The checker intentionally does not show solution commands."
    exit 1
fi
