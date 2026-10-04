# B1 Pre-Reading — Command Discovery & Self-Service Troubleshooting

This Level B lab teaches how to recover missing Linux knowledge from the system itself rather than memorizing every command.

## Core discovery tools

Use `man COMMAND` when you know the command name and need authoritative documentation.

Use `man -k KEYWORD` or `apropos KEYWORD` when you know the topic but not the command. They perform the same kind of search over manual-page names and short descriptions.

Many GNU utilities support `COMMAND --help` for a quick option summary.

## Manual-page sections

The same name can refer to different things. A useful example is:

- `passwd(1)` — the `passwd` command
- `passwd(5)` — the `/etc/passwd` file format

Request a specific section with `man 1 passwd` or `man 5 passwd`.

## How Bash resolves names

`type NAME` explains how Bash interprets a name: builtin, alias, function, keyword, or external executable.

`command -v NAME` shows how the current shell resolves a command name.

`which NAME` is primarily PATH-oriented executable lookup and is less shell-aware than `type` or `command -v`.

`whereis NAME` searches standard system locations for associated binaries, manuals, and related files.

## PATH

`$PATH` is a colon-separated list of directories Bash searches for executable command names.

`./tool` supplies an explicit relative path. `tool` asks the shell to resolve the bare name. Therefore an executable can work as `./tool` while bare `tool` returns `command not found`.

A temporary PATH extension looks like:

    export PATH="$PWD/tools:$PATH"

B1 does not modify `.bashrc`, `.profile`, or other persistent shell configuration.

## Shell history

`history` displays the current shell's command history list.

`history -c` clears the current shell's in-memory history list. Because this can destroy useful information, B1 practices it only inside a disposable child shell with an isolated `HISTFILE`.

Do not confuse `history` with `last`: `history` is shell command history; `last` is login history.

## Previous directory

`$OLDPWD` stores the previous working directory. `cd -` changes back to it.

## B1 boundary

B1 stops at command/documentation discovery. Filesystem discovery with `find` and advanced text/I/O work belong to B2.

## Retain this map

- `man COMMAND` — full manual
- `man -k` / `apropos` — discover manuals by topic
- `COMMAND --help` — quick help
- `type` — explain Bash interpretation
- `command -v` — shell-aware resolution
- `which` — PATH-oriented executable lookup
- `whereis` — standard associated locations
- `$PATH` — executable search path
- `history` / `history -c` — shell command history
- `cd -` / `$OLDPWD` — previous directory