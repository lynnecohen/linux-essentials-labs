# Lab 1 — Production Incident Investigation

## Scenario

The fictional **Northstar Learning Portal** experienced a cluster of errors during the morning of August 27, 2026. You have application, access, authentication, and archived logs plus several small data files. Your job is to inspect the evidence and produce a compact incident-analysis packet.

This lab assumes you already know basic navigation, copying, moving, directory creation, and ordinary file listing. Those skills may appear incidentally, but they are not the point of the exercise.

## Primary practice targets

- `grep`: case-insensitive search, line numbers, inverse matching, recursive search, match counts
- `cut`: delimiter/field extraction and character positions
- `sort`: ordinary, reverse, and numeric sorting
- `wc`: especially line counting
- `head`, `tail`, `cat`, `less`
- pipelines and redirection: `|`, `>`, `>>`, `2>`, `<`
- quoting, case sensitivity, and shell-glob versus text-pattern distinctions

## Before you begin — pre-reading

Read **[Lab 1 Pre-Reading — Searching and Processing Text](READING.md)** before starting the practical tasks.

The reading covers the syntax and mental models used in this lab, including:

- interactive searching and navigation inside `less`
- `grep` flags and recursive searching
- shell globbing versus regular expressions, including how `*`, `?`, `.`, character classes, quoting, and regex anchors behave differently
- `cut`, `wc`, pipes, sorting, and redirection
- stdin, stdout, and stderr

The reading intentionally teaches the tools without giving the required Lab 1 artifact commands. Use the lab afterward to reinforce retrieval and combination of those tools.

## Setup

From the repository root, run:

```bash
bash setup.sh
```

Then work from:

```text
01-incident/work/
```

Do not edit files under `01-incident/source/`; `reset.sh` uses those files to rebuild the workspace.

The workspace contains:

```text
logs/
  access.log
  application.log
  auth.log
  archived/
    access-1.log
    access-2.log

data/
  users.csv
  departments.csv
  request-ids.txt
  response-times.txt

results/
```

`users.csv` has four comma-separated fields in this order:

```text
username,department,status,email
```

## Part A — Inspect before acting

1. Page through `logs/application.log` interactively. Search inside the pager for `timeout` and move between matches.
2. Display only the first 5 lines of `logs/access.log`.
3. Display only the last 4 lines of `logs/application.log`.
4. Confirm for yourself that Linux treats uppercase and lowercase filenames distinctly. Do not rename any source files.

These orientation tasks are not scored.

## Part B — Build the incident packet

Create each requested file under `results/`. The checker validates the resulting content, not which exact command sequence you chose.

### 1. Error inventory

From `logs/application.log`, find every line containing the text `error` regardless of capitalization. Include the original line number in the output.

Save the result as:

```text
results/error-lines.txt
```

### 2. Operational errors only

Create another report containing lines from `logs/application.log` that contain `error` regardless of case, **but exclude DEBUG lines**.

Save it as:

```text
results/clean-errors.txt
```

### 3. Recursive timeout count

Search **all log files under `logs/`, including the archived subdirectory**, for lines containing `timeout` regardless of capitalization. Save only the total number of matching lines, not the matching text itself.

Save it as:

```text
results/timeout-count.txt
```

### 4. Active usernames

From `data/users.csv`, select only records whose status is `active`, then extract only the username field. Preserve the original file order.

Save it as:

```text
results/active-users.txt
```

### 5. Department list

Extract the department field from every record in `data/users.csv`, then sort the resulting lines alphabetically. Duplicate department names should remain present.

Save it as:

```text
results/departments.txt
```

### 6. Request-ID prefixes

Each line of `data/request-ids.txt` begins with an eight-character request identifier. Extract only those first eight characters from every line.

Save it as:

```text
results/request-prefixes.txt
```

### 7. Response times, ascending

Numerically sort `data/response-times.txt` from smallest to largest. For this task, deliberately feed the file into the sorting command using **standard-input redirection (`<`)** rather than naming the input file as a normal argument.

Save the output as:

```text
results/response-times-asc.txt
```

### 8. Response times, descending

Numerically sort the same response-time data from largest to smallest.

Save the output as:

```text
results/response-times-desc.txt
```

### 9. Capture stderr only

Attempt to display this intentionally nonexistent file:

```text
data/missing-config.ini
```

Redirect **only the error output** into:

```text
results/stderr.txt
```

Normal stdout should remain untouched.

### 10. Practice overwrite versus append

Using shell output redirection, create `results/incident-summary.txt` containing exactly these two lines in this order:

```text
Portal incident review
Review complete
```

Write the first line by creating/overwriting the file, then append the second line without overwriting the first.

## Check your work

From the repository root:

```bash
bash check.sh 1
```

The checker reports pass/fail for each required artifact. It does not reveal the commands needed to produce them.

If you want to start over:

```bash
bash reset.sh 1
```

## Exact-recall checkpoint

Do this **after** the practical tasks, without looking back at previous answers if possible. Type each command in your terminal or answer verbally when working through the lab interactively.

1. Count the number of lines in `logs/auth.log`.
2. Show the last 12 lines of `logs/access.log`.
3. Search `logs/application.log` for `permission denied`, ignoring capitalization.
4. Search recursively under `logs/` for `timeout`.
5. State the difference between `grep -n`, `grep -c`, `grep -v`, and `grep -r`.
6. Extract field 3 from a comma-delimited file named `example.csv`.
7. Explain when `>` and `>>` behave differently.
8. Explain what `2>` redirects.

## Stop point

When this lab is complete, do **not** move directly into a prebuilt Lab 2. Review what was automatic, what required looking something up, and what you got wrong. Lab 2 will be tuned around that evidence.
