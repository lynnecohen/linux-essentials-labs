# Level 2 Lab 3 Pre-Reading — Practical Bash Administration

This Level 2 lab goes beyond the **Linux Essentials 010-160 / Lab 5 core scripting scope** and introduces Bash constructs that are common in real Linux administration scripts.

It is intentionally separate from the required exam-prep sequence. Nothing in this lab should be treated as evidence that a construct is required for Linux Essentials v1.6.

The main targets are:

```text
if / elif / else       make decisions
[[ ... ]]              Bash conditional expression
string tests           compare or check text
numeric tests          compare numbers
file tests             inspect paths
while                   repeat while reading/while a condition is true
case                    choose among known patterns
functions               package reusable logic
$(command)              command substitution
$(( expression ))       arithmetic expansion
read -r -p              interactive prompt
$#                      number of positional arguments
"$@"                    all positional arguments, preserving boundaries
shift                    discard/advance past positional arguments
exit STATUS              end a script with a status
return STATUS            end a function with a status
```

Lab 5 established the scripting foundation: shebangs, variables, positional arguments, `for`, `echo`, `$?`, quoting, permissions, and direct execution. This lab builds on those concepts rather than replacing them.

---

## 1. Why this lab uses Bash rather than `/bin/sh`

For portable POSIX shell scripts, a shebang such as:

```sh
#!/bin/sh
```

is appropriate when the script stays within portable `sh` syntax.

This lab deliberately uses Bash-specific conveniences, especially:

```bash
[[ ... ]]
read -p
```

so its scripts should begin with:

```bash
#!/bin/bash
```

The interpreter should match the language features used by the script.

A useful rule is:

```text
#!/bin/sh      write portable POSIX-style shell
#!/bin/bash    Bash features are allowed/required
```

---

## 2. Conditional logic: `if`, `elif`, and `else`

A script becomes much more useful when it can make decisions.

Basic form:

```bash
if [[ condition ]]
then
    commands
fi
```

With an alternative:

```bash
if [[ condition ]]
then
    commands
else
    other_commands
fi
```

With multiple branches:

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

The closing keyword is:

```text
fi
```

which is `if` reversed.

A common one-line style is also valid:

```bash
if [[ condition ]]; then
    commands
fi
```

The semicolon separates commands when `then` appears on the same line.

---

## 3. `[[ ... ]]` versus `[ ... ]`

Shell scripts commonly encounter both forms.

Portable/POSIX-style test syntax:

```sh
[ "$SERVICE" = "running" ]
```

Bash conditional syntax:

```bash
[[ "$SERVICE" == "running" ]]
```

This Level 2 lab uses `[[ ... ]]` because it is a Bash lab and because the syntax is generally easier and safer for compound Bash conditions.

Important: spaces are syntactically significant.

Correct:

```bash
[[ "$SERVICE" == "running" ]]
```

Incorrect:

```bash
[["$SERVICE"=="running"]]
```

`[[` and `]]` are shell syntax tokens, not decorative brackets.

---

## 4. String tests

Useful Bash string conditions include:

```text
[[ "$A" == "$B" ]]    strings are equal
[[ "$A" != "$B" ]]    strings differ
[[ -z "$A" ]]         string has zero length
[[ -n "$A" ]]         string has nonzero length
```

Example:

```bash
if [[ -z "$SERVICE" ]]
then
    echo "service value is missing"
fi
```

String tests are common when validating configuration values or script arguments.

---

## 5. Numeric tests

When using `[[ ... ]]`, traditional numeric comparison operators include:

```text
-eq    equal
-ne    not equal
-lt    less than
-le    less than or equal
-gt    greater than
-ge    greater than or equal
```

Example:

```bash
if [[ "$DISK" -ge 90 ]]
then
    echo "critical disk usage"
elif [[ "$DISK" -ge 80 ]]
then
    echo "disk warning"
else
    echo "disk usage acceptable"
fi
```

Do not confuse numeric operators such as `-gt` with string comparison operators.

---

## 6. File and directory tests

Administrative scripts frequently need to ask questions about filesystem objects before acting on them.

Common tests:

```text
-e PATH    path exists
-f PATH    regular file exists
-d PATH    directory exists
-r PATH    path is readable
-w PATH    path is writable
-x PATH    path is executable/searchable
```

Example:

```bash
if [[ ! -f "$FILE" ]]
then
    echo "Missing file: $FILE"
fi
```

The `!` negates the condition:

```text
-f "$FILE"       it is a regular file
! -f "$FILE"     it is not a regular file
```

Checking before changing or reading a file is an important administrative habit.

---

## 7. Combining conditions

Inside Bash `[[ ... ]]`, common logical operators are:

```text
&&    AND
||    OR
!     NOT
```

Example:

```bash
if [[ "$SERVICE" != "running" || "$ERRORS" -ge 5 ]]
then
    echo "critical"
fi
```

This means the branch runs if either the service is not running **or** the error count is at least five.

Parentheses can be used for more complicated expressions, but this lab keeps conditions relatively small and readable.

---

## 8. `while` loops

A `while` loop repeats commands while its controlling command/condition succeeds.

General form:

```bash
while condition
do
    commands
done
```

One of the most useful administrative patterns is reading a file line by line:

```bash
while IFS= read -r LINE
do
    echo "$LINE"
done < input.txt
```

Here:

```text
read -r LINE      read one line without special backslash processing
IFS=              avoid trimming/splitting the line on normal shell whitespace
< input.txt       feed the file to the loop through stdin
```

### Reading simple key/value files

If a file contains:

```text
name=web01
service=running
disk=72
```

Bash can split each line at `=`:

```bash
while IFS='=' read -r KEY VALUE
do
    echo "key=$KEY value=$VALUE"
done < system.status
```

That pattern is useful for simple controlled lab data. Real production configuration formats can be more complex and should not automatically be parsed this way.

---

## 9. `case`: choosing among known values

A `case` statement is useful when one value can match several known patterns.

Example:

```bash
case "$KEY" in
    name)
        NAME="$VALUE"
        ;;
    service)
        SERVICE="$VALUE"
        ;;
    disk)
        DISK="$VALUE"
        ;;
    *)
        echo "Unknown key: $KEY"
        ;;
esac
```

The structure is:

```text
case VALUE in
    PATTERN)
        commands
        ;;
    *)
        fallback
        ;;
esac
```

`;;` ends a pattern branch. `esac` closes the statement.

For administrative scripts, `case` is often clearer than a long chain of equality tests when parsing known options or values.

---

## 10. Functions

A function packages reusable commands under a name.

Example:

```bash
log_message() {
    printf "%s\n" "$1"
}
```

Then call it:

```bash
log_message "Audit started"
```

Inside the function, positional parameters such as `$1` refer to the arguments passed **to the function**, not necessarily the script's original `$1`.

Functions are useful when the same logical operation must be performed repeatedly—for example, auditing several status files.

### Function return status

A function can explicitly return a status:

```bash
return 0
```

or:

```bash
return 1
```

`return` exits the function; `exit` exits the entire script.

---

## 11. Command substitution: `$(...)`

Command substitution runs a command and substitutes its standard output.

Example:

```bash
HOST=$(hostname)
```

Afterward, `$HOST` contains the output from `hostname`.

Another example:

```bash
COUNT=$(grep -c 'ERROR' application.log)
```

The older backtick form may still be encountered:

```bash
COUNT=`grep -c 'ERROR' application.log`
```

Prefer `$(...)` in new scripts because it is easier to read and nest.

Command substitution is especially common in administrative scripts that collect a value from another utility and then make decisions or construct reports from it.

---

## 12. Arithmetic expansion: `$(( ... ))`

Arithmetic expansion evaluates an integer expression and substitutes the result.

Example:

```bash
COUNT=0
COUNT=$((COUNT + 1))
```

If `COUNT` was `0`, it becomes `1`.

Other examples:

```bash
NEXT=$((CURRENT + 1))
PERCENT=$((USED * 100 / TOTAL))
```

This lab uses arithmetic primarily for counters. Shell arithmetic is integer arithmetic; it is not a general floating-point calculation system.

---

## 13. Interactive input with `read -r -p`

Bash can display a prompt as part of `read`:

```bash
read -r -p "Continue? [y/N]: " ANSWER
```

The options serve different purposes:

```text
-r    preserve backslashes literally
-p    display a prompt before reading
```

Then a conditional can interpret the response:

```bash
if [[ "$ANSWER" == "y" || "$ANSWER" == "Y" ]]
then
    echo "approved"
else
    echo "cancelled"
fi
```

For automated or unattended administrative scripts, interactive prompts can be undesirable. Use them when human confirmation is genuinely part of the workflow, not merely because they are available.

---

## 14. More advanced positional-argument handling

Lab 5 introduced `$1` and `$2`. Bash also provides:

```text
$#      number of positional arguments
"$@"    all positional arguments, each preserved as its own argument
```

Example validation:

```bash
if [[ "$#" -lt 2 ]]
then
    echo "Usage: $0 OUTPUT FILE..."
    exit 2
fi
```

### `shift`

`shift` removes the current `$1` and moves the remaining positional parameters down one position.

Suppose:

```text
$1 = results/audit.txt
$2 = systems/web01.status
$3 = systems/db01.status
```

After:

```bash
OUTPUT="$1"
shift
```

the remaining arguments are conceptually:

```text
$1 = systems/web01.status
$2 = systems/db01.status
```

and:

```bash
for FILE in "$@"
do
    echo "$FILE"
done
```

processes each remaining filename safely.

The quotes around `"$@"` are important: they preserve each original command-line argument as a separate argument, including filenames containing spaces.

---

## 15. `exit` and meaningful status codes

A script can explicitly end with:

```bash
exit STATUS
```

By convention:

```text
exit 0      success
exit nonzero  some kind of failure
```

A usage error might use:

```bash
exit 2
```

The exact nonzero values are a script design choice unless a command or interface defines specific meanings.

This matters because other scripts, schedulers, monitoring systems, and administrators can inspect the exit status to determine whether automation succeeded.

---

## 16. A practical administration pattern

A realistic Bash administration script often follows a structure like:

```text
1. validate arguments
2. initialize counters/variables
3. gather information with commands
4. define reusable functions
5. iterate over files/hosts/items
6. check that inputs exist
7. parse input
8. use if/elif/else to classify results
9. update counters
10. write a report
11. exit with a meaningful status
```

The point is not to make a script complicated. The point is to make repeated work predictable, inspectable, and safer than ad hoc manual repetition.

---

## 17. Practical cautions

### Quote expansions that represent data or paths

Prefer:

```bash
"$FILE"
"$OUTPUT"
"$@"
```

unless deliberate word splitting or glob expansion is intended.

### Validate before acting

Check files, arguments, and expected values before destructive operations. This lab performs only read/write operations inside its generated workspace.

### Do not blindly copy "strict mode"

Real Bash scripts often contain combinations such as:

```bash
set -euo pipefail
```

Those options can be useful, but their behavior—especially `set -e`—has subtleties. This lab does not require them. They should be learned deliberately rather than copied as unexplained boilerplate.

---

## 18. What to retain

After this Level 2 lab, the high-value mental map is:

```text
if / elif / else        branch on conditions
[[ ... ]]               Bash condition syntax
-f / -d / -e            file/path tests
-z / -n                  string-empty/nonempty tests
-eq -ne -lt -le -gt -ge numeric comparisons
&& / || / !             AND / OR / NOT

while                   repeat while condition/read succeeds
case                    choose among patterns
function_name() { ...; } reusable logic

$(command)              capture command output
$(( expression ))       integer arithmetic

read -r -p              interactive input with prompt

$#                      argument count
"$@"                    all arguments, preserving boundaries
shift                    advance positional arguments

exit                    end the script
return                  end a function
```

The accompanying practical lab combines these into a non-destructive system-status audit similar to the kinds of small utilities commonly written for Linux administration.
