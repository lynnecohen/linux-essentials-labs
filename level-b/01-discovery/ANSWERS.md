# B1 Exact-Recall Answer Key — Command Discovery & Self-Service Troubleshooting

1. `man grep`

2. `man -k network`

3. `apropos`

4. `type NAME`

5. `command -v NAME`

6. `PATH`; inspect it with `echo "$PATH"`.

7. `./tool` supplies an explicit relative pathname. Bare `tool` must be resolved through shell command lookup and `$PATH`.

8. `history -c` clears the current shell's in-memory history list.

9. `cd -` uses `$OLDPWD`.

10. `command -v NAME` asks the shell how the name resolves. `whereis NAME` searches standard system locations for associated binaries, manuals, and related files.

## Report-reference values

Stable values:

    ls_human_option=-h
    grep_c_counts=matching lines
    passwd_command_section=1
    passwd_file_section=5
    cd_type=shell builtin

`bash_path` and `northstar_status_path` should be validated dynamically when the checker is implemented.