# Core Lab 6 — Exact-Recall Answer Key

Use this **after** completing the exact-recall checkpoint in `INSTRUCTIONS.md`.

Equivalent commands and explanations are acceptable when they express the same Linux behavior.

1. `grep -r` searches directories recursively. `grep -v` inverts the match and outputs nonmatching lines.

2. `grep -n` prefixes matching lines with their original line numbers.

3. General pipeline:

   ```bash
   some-command | wc -l
   ```

4. `cut -d` selects the delimiter; `cut -f` selects one or more delimiter-separated fields.

5. Redirection:

   ```text
   >     redirect stdout and overwrite/truncate
   >>    redirect stdout and append
   2>    redirect stderr and overwrite/truncate
   ```

6. Tar modes:

   ```text
   c    create
   t    list
   x    extract
   ```

7. Tar compression:

   ```text
   z    gzip
   j    bzip2
   J    xz
   ```

8. General symbolic-link syntax:

   ```bash
   ln -s TARGET LINK_NAME
   ```

9. On a shared writable directory, the sticky bit restricts removal/renaming so users cannot ordinarily delete or rename other users' entries merely because the directory itself is writable.

10. Session commands:

    ```text
    who    currently logged-in sessions
    w      logged-in users plus activity
    last   recent login/session history
    ```

11. `su - USER` requests a login shell/environment for the target user; `su USER` switches user without requesting the same full login environment.

12. `free` reports memory usage. `df` reports filesystem/disk-space usage.

13. At a high level:

    ```text
    /proc    process and kernel runtime information
    /sys     structured kernel/device information
    ```

14. Modern interface and route inspection:

    ```bash
    ip addr show
    ip route show
    ```

15. The v1.6 basic DNS lookup command emphasized in the Core track is:

    ```bash
    host
    ```

16. The modern socket-inspection command is:

    ```bash
    ss
    ```

17. Kernel messages and network configuration files:

    ```text
    dmesg             kernel messages
    /etc/hosts        local static hostname mappings
    /etc/resolv.conf  resolver/DNS configuration
    ```

18. Legacy Linux `ifconfig` maps conceptually to modern:

    ```bash
    ip addr show
    ```

    Windows `ipconfig` is a Windows command, not the Linux legacy command being asked about.

19. Standard Bash shebang:

    ```bash
    #!/bin/bash
    ```

20. Ordinary shell-variable names begin with a letter or underscore; remaining characters may be letters, digits, or underscores. They are case-sensitive. Ordinary variable names do not contain spaces or hyphens. Assignments do not have spaces around `=`.

21. Positional/status parameters:

    ```text
    $1    first positional argument
    $2    second positional argument
    $?    exit status of the immediately preceding command
    ```

22. `bash script.sh` launches Bash and gives the script file to Bash to read, so the script itself does not need execute permission. `./script.sh` executes the script directly and therefore requires execute permission; its shebang identifies the interpreter.

23. One valid basic loop:

    ```bash
    for item in alpha beta gamma
    do
        echo "$item"
    done
    ```

24. Exit status `0` conventionally means success.
