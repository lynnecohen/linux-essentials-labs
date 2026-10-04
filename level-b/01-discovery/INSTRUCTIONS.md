# B1 — Command Discovery & Self-Service Troubleshooting

## Scenario

You have access to a fictional Northstar Learning Portal Linux server, but the previous administrator left incomplete notes. Your task is to recover commands, options, paths, and shell behavior from Linux itself.

## Primary practice targets

`man`, manual sections, `man -k`, `apropos`, `--help`, `type`, `command -v`, `$PATH`, `./command`, `which`, `whereis`, `history`, `history -c`, `cd -`, and `$OLDPWD`.

Read `PRE_READING.md` before starting.

## Current setup status

B1 automation is not wired yet. The eventual workspace will contain:

    tools/northstar-status
    clues/admin-notes.txt
    results/
    history/

## Part A — Ask the system for help

1. Use local documentation to determine which `ls` option produces human-readable sizes.
2. Use local documentation to determine precisely what `grep -c` counts.
3. Run both `man -k network` and `apropos network`. Confirm that they perform the same kind of keyword search.

## Part B — Same name, different manual

Open both `man 1 passwd` and `man 5 passwd`.

Determine which page documents the command and which documents the `/etc/passwd` file format.

## Part C — What will Bash execute?

Investigate `cd`, `bash`, and `ls` using both `type` and `command -v`.

Also inspect at least one external command using `which` and `whereis`.

You should be able to explain why these four tools are not interchangeable.

## Part D — Diagnose a PATH problem

The final wired lab will provide `tools/northstar-status` as an executable file.

From the B1 workspace:

1. Confirm the file is executable.
2. Run `northstar-status` and observe that it initially fails to resolve by bare name.
3. Run `./tools/northstar-status` and confirm it works.
4. Run `command -v northstar-status` and inspect `echo "$PATH"`.
5. Temporarily add the tools directory with `export PATH="$PWD/tools:$PATH"`.
6. Run `command -v northstar-status` again, then run `northstar-status` by bare name.

Do not modify persistent shell startup files.

## Part E — Practice shell history safely

Do not clear your normal shell history.

From the B1 workspace, launch a disposable child shell:

    HISTFILE="$PWD/history/b1_history" bash

Inside it, run a few harmless commands, inspect `history`, then run `history -c` and inspect `history` again. Exit the child shell afterward.

## Part F — Recover the previous directory

Run:

    cd /etc
    cd /var/log
    echo "$OLDPWD"
    cd -

Confirm that `cd -` returns to the prior directory.

## Part G — Discovery report

Create `results/discovery-report.txt` with exactly these keys:

    ls_human_option=
    grep_c_counts=
    passwd_command_section=
    passwd_file_section=
    cd_type=
    bash_path=
    northstar_status_path=

Expected stable values include:

    ls_human_option=-h
    grep_c_counts=matching lines
    passwd_command_section=1
    passwd_file_section=5
    cd_type=shell builtin

`bash_path` and `northstar_status_path` are environment-dependent.

## Exact-recall checkpoint

1. Open the manual page for `grep`.
2. Search manual-page names/descriptions for `network`.
3. What command is equivalent to `man -k`?
4. Which Bash command explains whether a name is a builtin, alias, function, or external command?
5. Which shell-aware command shows how Bash resolves a command name?
6. What environment variable contains executable-search directories?
7. Why can `./tool` work when `tool` reports `command not found`?
8. What does `history -c` do?
9. What does `cd -` use to determine the previous directory?
10. What is the difference between `command -v NAME` and `whereis NAME`?

Compare your answers with `ANSWERS.md` only after attempting them from memory.

## Stop point

B2 will introduce `find` plus advanced text processing and I/O behavior. B1 deliberately stops before those topics.