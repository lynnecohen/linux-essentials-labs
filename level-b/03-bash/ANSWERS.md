# B3 — Exact-Recall Answer Key

Use this **after** completing the exact-recall checkpoint in `INSTRUCTIONS.md`.

Equivalent valid Bash syntax is acceptable.

1. Basic `if / elif / else` structure:

   ```bash
   if [[ condition1 ]]
   then
       commands
   elif [[ condition2 ]]
   then
       other_commands
   else
       fallback_commands
   fi
   ```

2. A Bash `if` statement closes with:

   ```text
   fi
   ```

3. File tests:

   ```text
   -f    regular file exists
   -d    directory exists
   -e    path exists
   ```

4. String tests:

   ```text
   -z    string has zero length
   -n    string has nonzero length
   ```

5. Numeric comparison operators:

   ```text
   -ge    greater than or equal
   -lt    less than
   ```

6. Logical operators:

   ```text
   &&    AND
   ||    OR
   !     NOT
   ```

7. Basic `while` loop:

   ```bash
   while condition
   do
       commands
   done
   ```

8. `IFS='=' read -r KEY VALUE` reads a line and splits it at `=`, putting the portion before the delimiter into `KEY` and the remaining portion into `VALUE`; `-r` prevents backslash interpretation by `read`.

9. `case` is useful for selecting commands based on one value matching one of several known patterns.

10. Function syntax:

    ```bash
    check_file() {
        commands
    }
    ```

11. `return` exits the current function with a status. `exit` terminates the entire script/process with a status.

12. `HOST=$(hostname)` runs `hostname` and stores its standard output in `HOST`.

13. `COUNT=$((COUNT + 1))` evaluates integer arithmetic and assigns the incremented result back to `COUNT`.

14. Argument parameters:

    ```text
    $#      number of positional arguments
    "$@"    all positional arguments, each preserved as its own argument
    ```

15. `shift` discards the current `$1` and renumbers the remaining positional arguments downward.

16. Quoted `"$@"` preserves the boundaries of the original arguments, including arguments containing spaces.

17. `read -r` prevents backslash escaping/interpretation; `read -p` displays a prompt before reading input.

18. A script can produce a useful partial report yet return nonzero so callers, schedulers, or monitoring tools can detect that some requested work failed.

19. This lab uses `#!/bin/bash` because it deliberately uses Bash-specific constructs such as `[[ ... ]]` and `read -p`.

20. Checking `[[ -f "$FILE" ]]` can prevent an operation from assuming that a missing path, directory, or other non-regular object is a valid input file.
