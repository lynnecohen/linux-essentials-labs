# Optional Lab 7 — Practical Bash Administration

## Status of this lab

This is an **optional post-core lab**. It intentionally goes beyond the Linux Essentials v1.6 scripting scope used by Lab 5.

It is numbered **07** so that **06-capstone** remains the end of the required exam-prep sequence. This lab can be completed after Lab 5 or after the capstone.

## Scenario

The fictional **Northstar Learning Portal** has several servers represented by status files. An administrator wants a reusable script that:

- accepts an output report path and one or more status files
- validates its arguments
- handles missing files without crashing
- parses each status file
- classifies each system as OK, WARNING, or CRITICAL
- counts processed systems, issues, and missing files
- records the local hostname
- returns a useful exit status

A second small script asks for explicit confirmation before a hypothetical maintenance action.

Everything operates inside the generated lab workspace. No real services, accounts, or system configuration are changed.

## Primary practice targets

- `if / elif / else`
- `[[ ... ]]`
- string, numeric, and file tests
- `&&`, `||`, and `!`
- `while`
- `case`
- functions
- command substitution `$(...)`
- arithmetic expansion `$((...))`
- `read -r -p`
- `$#`, `"$@"`, and `shift`
- `exit` and `return`

## Pre-reading

Read **[Optional Lab 7 Pre-Reading — Practical Bash Administration](PRE_READING.md)** before starting.

## Setup

From the repository root:

```bash
bash setup.sh 7
```

Then:

```bash
cd 07-advanced-scripting/work
```

The workspace contains:

```text
systems/
  web01.status
  web02.status
  db01.status
scripts/
results/
```

---

## Part A — Inspect the status-file format

Inspect the three status files.

Each contains four simple key/value fields:

```text
name=...
service=...
disk=...
errors=...
```

The values are intentionally simple so the scripting constructs—not configuration-file parsing edge cases—remain the focus.

The classification rules for this lab are:

```text
CRITICAL
    service is not "running"
    OR disk >= 90
    OR errors >= 5

WARNING
    otherwise, disk >= 80
    OR errors > 0

OK
    none of the above
```

For the supplied data, the expected classifications are:

```text
web01    OK
web02    WARNING
db01     CRITICAL
```

---

## Part B — Build `system-audit.sh`

Create:

```text
scripts/system-audit.sh
```

Use Bash:

```bash
#!/bin/bash
```

The script must meet the following behavioral requirements.

### 1. Validate arguments

The invocation format is:

```text
./scripts/system-audit.sh OUTPUT_FILE STATUS_FILE...
```

The script therefore needs at least two positional arguments:

1. output filename
2. at least one status filename

Use `$#` to check the argument count.

If too few arguments are supplied:

- print a short usage message
- exit with status `2`

### 2. Save the output argument, then `shift`

Store `$1` in an output variable.

Then use:

```bash
shift
```

After the shift, the remaining positional parameters should be only the status files.

The script must iterate over the remaining files using:

```bash
"$@"
```

so each original filename remains one argument.

### 3. Initialize counters

Create counters for:

```text
processed
issues
missing
```

Initialize each to zero.

### 4. Capture the local hostname

Use command substitution to capture the output of the hostname command in a variable.

The report must begin with lines in this form:

```text
Northstar system audit
host=HOSTNAME
```

The actual hostname depends on the Linux system running the lab.

### 5. Define an `audit_file` function

Create a function named:

```text
audit_file
```

It receives one status filename as its first function argument.

The function must:

1. test whether the file exists as a regular file
2. if it is missing:
   - append `MISSING PATH` to the report
   - increment the missing counter
   - return a nonzero status
3. otherwise parse its fields
4. classify the system
5. append one summary line to the report
6. increment the processed counter
7. increment the issues counter for WARNING or CRITICAL results
8. return success

### 6. Parse with `while` + `read`

Inside the function, parse the file using a loop based on:

```bash
while IFS='=' read -r KEY VALUE
do
    ...
done < "$FILE"
```

Use a `case` statement to assign the recognized keys:

```text
name
service
disk
errors
```

to named shell variables.

### 7. Classify with `if / elif / else`

Use the classification rules from Part A.

Use appropriate:

- string comparison
- numeric comparison
- logical OR

The output line for each valid status file must have this format:

```text
NAME service=SERVICE disk=DISK errors=ERRORS status=CLASSIFICATION
```

### 8. Use arithmetic expansion for counters

Increment counters with arithmetic expansion, for example:

```bash
COUNT=$((COUNT + 1))
```

Do not use external programs merely to add one to an integer.

### 9. Process every remaining argument

After defining the function, iterate over the remaining status-file arguments:

```bash
for FILE in "$@"
do
    ...
done
```

Call the function once for each file.

### 10. Append final totals

The report must end with:

```text
processed=N
issues=N
missing=N
```

### 11. Exit status

For this lab:

- exit `0` if no files were missing
- exit `1` if at least one requested status file was missing
- exit `2` for incorrect usage

This gives the script a small but meaningful interface that other automation could inspect.

---

## Part C — Make it executable and test normal input

Make the script executable for its owner.

Run:

```bash
./scripts/system-audit.sh   results/audit.txt   systems/web01.status   systems/web02.status   systems/db01.status
```

Then immediately inspect:

```bash
echo "$?"
```

The script should return:

```text
0
```

Inspect `results/audit.txt`.

It should contain all three systems and totals equivalent to:

```text
processed=3
issues=2
missing=0
```

---

## Part D — Test a missing input file

Now run:

```bash
./scripts/system-audit.sh   results/audit-missing.txt   systems/web01.status   systems/missing.status
```

Immediately inspect `$?`.

Expected exit status:

```text
1
```

The report should contain a `MISSING systems/missing.status` line and totals equivalent to:

```text
processed=1
issues=0
missing=1
```

This demonstrates the difference between:

- detecting a problem
- recording the problem
- continuing useful work
- returning a nonzero overall status

---

## Part E — Build an interactive confirmation script

Create:

```text
scripts/confirm-maintenance.sh
```

Requirements:

1. Bash shebang
2. use `read -r -p` to ask:
   ```text
   Continue with maintenance? [y/N]:
   ```
3. if the answer is `y` or `Y`, print:
   ```text
   maintenance-approved
   ```
   and exit `0`
4. otherwise print:
   ```text
   maintenance-cancelled
   ```
   and exit `1`

Make the script executable and test both branches.

This is intentionally a **hypothetical confirmation**. It does not run a real maintenance command.

---

## Part F — Argument-boundary experiment

Create a temporary empty status file whose filename contains a space:

```text
systems/test node.status
```

The file does not need to produce a valid classification; the point of this experiment is argument handling.

Run:

```bash
printf '<%s>\n' "$@"
```

inside a temporary test script or function and compare it with an unquoted `$@`.

The important result to retain is:

```text
"$@"    preserves each original positional argument as one argument
```

Remove the temporary file afterward if desired.

This section is unscored.

---

## Check your work

From the repository root:

```bash
bash check.sh 7
```

The checker validates both script structure and behavior. It runs only against the generated workspace.

To reset:

```bash
bash reset.sh 7
```

---

## Exact-recall checkpoint

1. Write the basic structure of an `if / elif / else` statement.
2. What closes a Bash `if` statement?
3. What do `-f`, `-d`, and `-e` test?
4. What do `-z` and `-n` test?
5. Give the numeric operators for greater-than-or-equal and less-than.
6. What do `&&`, `||`, and `!` mean in a condition?
7. Write the basic structure of a `while` loop.
8. What does `IFS='=' read -r KEY VALUE` accomplish for a simple `key=value` line?
9. What is `case` useful for?
10. Write the basic syntax for defining a Bash function named `check_file`.
11. What is the difference between `return` and `exit`?
12. What does `HOST=$(hostname)` do?
13. What does `COUNT=$((COUNT + 1))` do?
14. What do `$#` and `"$@"` represent?
15. What does `shift` do to positional arguments?
16. Why should `"$@"` normally be quoted?
17. What do `read -r` and `read -p` each contribute?
18. Why might an administrative script deliberately return a nonzero status even after producing a useful report?
19. Why does this lab use `#!/bin/bash` instead of `#!/bin/sh`?
20. Name one reason to check a file with `[[ -f "$FILE" ]]` before operating on it.

## Stop point

This lab is deliberately broader than the exam-focused scripting lab. The goal is practical literacy: being able to read, modify, and write small Bash utilities that validate inputs, make decisions, process files, and report failures predictably.
