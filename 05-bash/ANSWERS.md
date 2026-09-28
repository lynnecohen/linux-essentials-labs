# Lab 5 — Exact-Recall Answer Key

Use this **after** completing the exact-recall checkpoint in `INSTRUCTIONS.md`.

1. Standard Bash shebang:

   ```bash
   #!/bin/bash
   ```

2. An ordinary Bash comment begins with:

   ```text
   #
   ```

3. Store the literal two-word phrase `night shift` in `TEAM`:

   ```bash
   TEAM="night shift"
   ```

4. `TEAM = "night shift"` is not an assignment because shell assignment syntax does not allow spaces around `=`. Bash parses the spaced form as command words rather than the variable assignment `TEAM="night shift"`.

5. Expand `TEAM` with either:

   ```bash
   "$TEAM"
   ```

   or:

   ```bash
   "${TEAM}"
   ```

   The braces are optional here because the variable boundary is already clear.

6. `$1` is the first positional argument passed to the script; `$2` is the second.

7. One valid loop is:

   ```bash
   for item in alpha beta gamma
   do
       echo "$item"
   done
   ```

8. `$?` contains the exit status of the **immediately preceding command**.

9. Exit status `0` conventionally means success.

10. Every subsequent command updates the shell's most recent exit status. Inspect `$?` immediately or you may read the status of a later command instead.

11. Add owner execute permission:

   ```bash
   chmod u+x report.sh
   ```

12. Execute it directly from the current directory:

   ```bash
   ./report.sh
   ```

   Add positional arguments after the pathname when the script requires them.

13. `bash report.sh` launches Bash and gives the file to Bash to interpret; the script file itself does not need execute permission. `./report.sh` asks the operating system to execute the script directly, so the execute bit is required.

14. During direct execution, the shebang identifies the interpreter that should run the script.

15. The two terminal editors explicitly recognized in this lab are:

   ```text
   vi
   nano
   ```

16. Of `for`, `if`, `while`, and functions, only **`for`** is part of this lab's required Linux Essentials v1.6 scripting scope.
