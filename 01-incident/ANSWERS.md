# Lab 1 — Exact-Recall Answer Key

Use this **after** completing the exact-recall checkpoint in `INSTRUCTIONS.md`.

Equivalent commands are acceptable when they produce the requested result.

1. Count the lines in `logs/auth.log`:

   ```bash
   wc -l logs/auth.log
   ```

2. Show the last 12 lines of `logs/access.log`:

   ```bash
   tail -n 12 logs/access.log
   ```

3. Search `logs/application.log` for `permission denied`, ignoring capitalization:

   ```bash
   grep -i 'permission denied' logs/application.log
   ```

4. Search recursively under `logs/` for `timeout`:

   ```bash
   grep -r 'timeout' logs/
   ```

5. `grep` flags:

   ```text
   -n    show matching line numbers
   -c    count matching lines
   -v    invert the match; show nonmatching lines
   -r    search directories recursively
   ```

6. Extract field 3 from comma-delimited `example.csv`:

   ```bash
   cut -d',' -f3 example.csv
   ```

7. `>` redirects standard output and overwrites/truncates the destination file; `>>` redirects standard output and appends to the destination.

8. `2>` redirects **standard error (stderr)**, conventionally file descriptor 2.

9. In an extended regular expression, `?` means **zero or one occurrence of the preceding pattern**. In a shell glob, `?` means **exactly one arbitrary filename character**.
