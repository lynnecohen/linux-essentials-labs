# Lab 5 — Bash Automation

## Scenario

The fictional **Northstar Learning Portal** support team repeatedly performs the same small log review: identify each log, search it for `error`, record the matches, and record whether the search succeeded.

Instead of typing the sequence manually for every log file, build a reusable Bash script that generates the report.

This lab deliberately stays within the Linux Essentials v1.6 scripting core. The challenge is not to write the most sophisticated script possible. It is to use the required Bash fundamentals correctly and exactly.

## Primary practice targets

- `#!/bin/bash`
- Bash comments
- variable assignment and expansion
- positional arguments `$1` and `$2`
- double-quoting variable expansions
- `echo`
- basic `for` loops
- `$?` exit status
- `chmod u+x`
- direct execution with `./script.sh`
- awareness of `vi` and `nano`

## Before you begin — pre-reading

Read **[Lab 5 Pre-Reading — Bash Automation](PRE_READING.md)** before starting the practical work.

## Setup

From the repository root:

```bash
bash setup.sh 5
```

Then:

```bash
cd 05-scripting/work
```

The workspace contains:

```text
logs/
  application.log
  auth.log
  worker.log
scripts/
results/
```

All script creation and execution happens inside this generated workspace.

---

## Part A — Inspect the input

Use ordinary file-viewing commands to inspect:

```text
logs/application.log
logs/auth.log
logs/worker.log
```

Notice that some files contain the word `error` in varying capitalization and at least one does not.

The eventual script must process the whole `logs/*.log` set rather than hard-coding individual filenames.

---

## Part B — Observe exit status directly

Before writing the script, run a case-insensitive `grep` search that **does** match text in one of the logs.

Immediately afterward, run:

```bash
echo "$?"
```

Observe the value.

Then run a search pattern that does **not** occur in one of the logs and immediately inspect `$?` again.

The intended observation is:

```text
matching grep       exit status 0
no-match grep       exit status 1
```

Now demonstrate why timing matters:

1. run a `grep`
2. run an unrelated successful `echo`
3. run `echo "$?"`

The final status belongs to the unrelated `echo`, not to the earlier `grep`.

This part is unscored; it exists to make `$?` behavior concrete.

---

## Part C — Create the report script

Create:

```text
scripts/northstar-report.sh
```

Use either `nano`, `vi`, or another plain-text editor.

The script must satisfy all of the following requirements.

### 1. Interpreter

The first line must select Bash using the standard Linux Essentials shebang.

### 2. Comment

Include at least one useful comment describing the script or a section of it.

### 3. Positional arguments

The script must receive:

```text
$1    output report filename
$2    human-readable report label
```

Assign both positional arguments to named variables near the beginning of the script.

Do not hard-code the report path or label.

### 4. Report heading

The script must overwrite the requested report file with a first line in this form:

```text
Northstar report: LABEL
```

where `LABEL` comes from the second positional argument.

Then append:

```text
Source logs:
```

### 5. Loop over the logs

Use a Bash `for` loop over:

```text
logs/*.log
```

For each log file, the loop must:

1. append that log's pathname to the report
2. search the log case-insensitively for `error` and append matching lines to the report
3. immediately append the search command's exit status in this form:

```text
grep-status=STATUS
```

The status line must describe the `grep` that immediately precedes it.

Do not use `if`, `while`, functions, command substitution, or arithmetic expansion. They are not needed.

---

## Part D — Test with Bash first

Before making the script executable, run it explicitly through Bash with:

```text
first argument:  results/daily-report.txt
second argument: night shift
```

After running it, inspect:

```text
results/daily-report.txt
```

The report should:

- begin with `Northstar report: night shift`
- include `Source logs:`
- name all three `.log` files
- include the case-insensitive `error` matches
- contain both a `grep-status=0` result and a `grep-status=1` result

The exact ordering of the log filenames follows shell glob expansion.

---

## Part E — Make the script directly executable

Add **owner execute permission** to:

```text
scripts/northstar-report.sh
```

Use symbolic `chmod` syntax.

Then execute the script directly using its relative pathname beginning with:

```text
./
```

For this direct-execution test, supply:

```text
first argument:  results/direct-report.txt
second argument: direct run
```

Inspect the result and confirm that the label changed because the script used its positional arguments rather than hard-coded values.

This step deliberately reinforces the connection between:

```text
#!/bin/bash
chmod u+x
./script
```

---

## Part F — Confirm the script itself

Inspect the final script with:

```bash
cat scripts/northstar-report.sh
```

Before running the checker, confirm that it visibly contains:

- the Bash shebang on line 1
- at least one comment
- assignments using `$1` and `$2`
- a basic `for` / `do` / `done` loop
- variable expansion
- `echo`
- `$?`
- no advanced branching or loop constructs

---

## Check your work

From the repository root:

```bash
bash check.sh 5
```

The checker validates both the script structure and its behavior with a controlled set of arguments. It does not require a particular editor.

If you need to rebuild the workspace:

```bash
bash reset.sh 5
```

---

## Exact-recall checkpoint

Complete these without looking back at the reading if possible.

1. Write the standard Bash shebang used in this lab.
2. What character begins an ordinary Bash comment?
3. Write a valid variable assignment that stores `operations` in a variable named `TEAM`.
4. Why is `TEAM = operations` not equivalent to `TEAM=operations`?
5. How do you expand the value of a variable named `TEAM`?
6. What do `$1` and `$2` represent inside a script?
7. Write a basic `for` loop that prints `alpha`, `beta`, and `gamma` one at a time.
8. What does `$?` contain?
9. What exit status conventionally means success?
10. Why must `$?` be inspected immediately after the command of interest?
11. Write the symbolic command that adds owner execute permission to `report.sh`.
12. Assuming `report.sh` is executable and is in the current directory, write the command to execute it directly.
13. At a high level, how does `bash report.sh` differ from `./report.sh`?
14. Why does the shebang matter when the script is executed directly?
15. Name two terminal text editors recognized in this lab.
16. Which of these is part of this lab's required scripting scope: `for`, `if`, `while`, or functions?

## Stop point

After the practical and exact-recall checkpoint, note any syntax that required a lookup. The next required exercise is the cumulative capstone, so any remaining weak distinctions from Labs 1–5 should be carried into that scenario rather than expanded into new out-of-scope Bash material.
