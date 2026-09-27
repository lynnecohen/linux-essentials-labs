# Lab 5 Pre-Reading — Bash Automation

Read this before starting **Lab 5 — Bash Automation**. The goal is to turn a short sequence of familiar shell commands into a reusable Bash script while staying within the Linux Essentials v1.6 scripting core.

This lab deliberately focuses on:

```text
#!/bin/bash      shebang
# comment        comment
NAME=value       variable assignment
$NAME            variable expansion
$1, $2           positional arguments
echo             print text/values
for ... do ... done
$?               exit status of the previous command
chmod u+x        add execute permission
./script.sh      run an executable script from the current directory
```

Commands from earlier labs may appear inside the script, but the new skill is **Bash structure and execution**, not learning additional administration commands.

This lab does **not** require advanced scripting constructs such as `if`, `while`, functions, arithmetic expansion, or `read -p`. Command substitution is included later as **recognition-only** material because it is common in real shell scripts, but it is not a scored or required construction target for this lab.

---

## 1. What a shell script is

A shell script is a text file containing commands that a shell can execute in sequence.

For example:

```bash
#!/bin/bash
echo "Starting report"
free
echo "Report complete"
```

Instead of typing the three commands manually each time, the script stores the sequence so it can be repeated.

A script is still ordinary text. It can be inspected with commands such as `cat` or `less`, and edited with a text editor.

---

## 2. The shebang: `#!/bin/bash`

A Bash script commonly begins with:

```bash
#!/bin/bash
```

This first line is called the **shebang**.

Break it into two parts:

```text
#!          special interpreter marker
/bin/bash   path to the Bash interpreter
```

When an executable script is launched directly, the operating system uses this line to determine which interpreter should run the file.

For Linux Essentials v1.6, retain the exact association:

```text
#!/bin/bash = run this script with Bash
```

The shebang must be on the first line to serve this purpose.

### The current shell and the script interpreter are separate

The shell at the interactive prompt does not have to be the shell that interprets a script.

For example, a user can be working interactively in `zsh` and execute:

```bash
./report.sh
```

If `report.sh` begins with:

```bash
#!/bin/bash
```

the operating system launches `/bin/bash` to interpret the script.

Conceptually:

```text
interactive zsh
    ↓
./report.sh
    ↓
operating system reads #!/bin/bash
    ↓
Bash interprets report.sh
```

A script intended for the portable POSIX shell language may instead use:

```sh
#!/bin/sh
```

On Debian, `/bin/sh` is commonly a symbolic link to `dash`. That does **not** mean a script must explicitly name `dash`; `#!/bin/sh` means "use this system's standard `sh` interpreter."

This distinction is useful:

```text
#!/bin/bash    explicitly requires Bash
#!/bin/sh      targets the system's POSIX-style sh
```

When a script is launched directly with `./script.sh`, the shebang selects the interpreter. When an interpreter is named explicitly:

```bash
bash script.sh
zsh script.sh
sh script.sh
```

that named program interprets the file; the shebang is not what selected the interpreter in that invocation.

Lab 5 uses `#!/bin/bash` because Bash is the scripting target for the exercise.

---

## 3. Comments

In Bash, a comment begins with `#`:

```bash
# Build the nightly Northstar report
```

The shell ignores the comment text.

The shebang is a special exception: it begins with `#!`, but the operating system interprets it when the script is executed directly.

Comments are useful for explaining purpose or intent:

```bash
#!/bin/bash
# Summarize application logs for support staff
```

For this lab, one or two useful comments are enough. Avoid turning every line into a comment exercise.

---

## 4. Variables: assignment and expansion

A shell variable stores a value under a name.

Basic assignment:

```bash
TEAM=operations
```

There must be **no spaces around the equals sign**.

Correct:

```bash
TEAM=operations
```

Incorrect:

```bash
TEAM = operations
```

The second form is parsed as a command rather than as a variable assignment.

To retrieve the value, prefix the variable name with `$`:

```bash
echo "$TEAM"
```

which prints:

```text
operations
```

The distinction is:

```text
TEAM=operations     assign a value
$TEAM               expand/retrieve the value
```

### `$NAME` versus `${NAME}`

Both forms expand the same variable:

```bash
echo "$TEAM"
echo "${TEAM}"
```

Curly braces make the **boundary of the variable name explicit**.

For example:

```bash
COLOR=blue
echo "${COLOR}ish"
```

prints:

```text
blueish
```

Without the braces:

```bash
echo "$COLORish"
```

the shell looks for a variable named `COLORish`, because letters, numbers, and underscores can be part of a variable name.

Braces are therefore about **where the variable name ends**. They are not what protects spaces.

That is the job of quotes:

```text
$COLOR          expand the variable
${COLOR}        expand the variable with an explicit name boundary
"$COLOR"        expand it and preserve the result as one shell argument
"${COLOR}.txt"  preserve the value as one argument and append .txt
```

For example, if:

```bash
COLOR="blue green"
```

then:

```bash
touch "${COLOR}.txt"
```

passes one filename to `touch`:

```text
blue green.txt
```

The quote characters themselves do **not** become part of the filename. They are shell syntax used while parsing the command.

GNU `ls` may display a filename containing spaces with visible quotes:

```text
'blue green.txt'
```

Those quotes are display formatting added by `ls` to make it clear that the text is one filename; they are not stored in the filename.

---

## 5. Why quote variable expansions?

A robust Bash habit is:

```bash
echo "$TEAM"
```

rather than:

```bash
echo $TEAM
```

Double quotes preserve the expanded value as one shell argument even if it contains spaces.

For example:

```bash
LABEL="night shift"
echo "$LABEL"
```

prints:

```text
night shift
```

This connects to the quoting rules from Lab 1:

```text
single quotes   preserve text literally; variable expansion does not occur
double quotes   allow variable expansion
```

Compare:

```bash
echo '$LABEL'
echo "$LABEL"
```

The first prints the literal characters:

```text
$LABEL
```

The second prints the variable's value.

For this lab, use double quotes around variable expansions unless there is a specific reason not to.

---

## 6. Positional arguments: `$1`, `$2`, and so on

A script can receive values from the command line.

Suppose a script is run as:

```bash
./report.sh results/report.txt "night shift"
```

Inside the script:

```text
$1    results/report.txt
$2    night shift
```

These are called **positional parameters** or **positional arguments**.

A script can store them in named variables:

```bash
REPORT="$1"
LABEL="$2"
```

Then later use:

```bash
echo "$LABEL" > "$REPORT"
```

This makes the script reusable because the output filename and label do not need to be hard-coded.

The high-value mapping is:

```text
$1 = first argument supplied to the script
$2 = second argument supplied to the script
```

---

## 7. Reading input with `read -r` — useful shell practice

Although the scored Lab 5 script receives data through positional arguments, interactive shell scripts often use `read` to accept input:

```sh
read color
```

A common safer form is:

```sh
read -r color
```

The `-r` option tells `read` to treat backslashes literally rather than using them as escape characters or line-continuation markers.

For example, if a user enters:

```text
blue\green
```

`read -r` preserves the backslash in the variable value.

The `-r` option is **not** what preserves spaces in a response. A value such as:

```text
dark green
```

can be read into one variable with or without `-r`. The purpose of `-r` is specifically to disable special backslash handling.

For straightforward text input, `read -r VARIABLE` is a good default habit.

---

## 8. `echo` and `printf`: simple output and exact formatting

`echo` is convenient for simple output:

```bash
echo "Starting"
echo "$LABEL"
```

It normally adds a newline automatically.

`printf` provides more explicit and portable formatting:

```sh
printf "Starting\n"
printf "%s\n" "$LABEL"
```

Unlike `echo`, `printf` does not automatically add a newline; `\n` requests one explicitly.

This makes `printf` especially useful for prompts that should leave the cursor on the same line:

```sh
printf "What's your favorite color?: "
read -r color
```

A commonly seen alternative is:

```sh
echo -n "What's your favorite color?: "
```

but `echo` option and escape handling has historically varied across shell implementations. For portable shell scripts, `printf` is more predictable when exact formatting matters.

### Format strings

`printf` uses a format string:

```sh
printf "User: %s\n" "$USER"
```

where:

```text
%s    insert a string
\n    newline
```

A useful pattern is to keep variable data separate from the format string:

```sh
printf "%s's favorite color is %s!\n" "$user" "$color"
```

rather than:

```sh
printf "$color\n"
```

If user-controlled data contains characters such as `%`, putting it directly into the format string can cause `printf` to interpret those characters as formatting instructions. Supplying the data as a separate argument with `%s` avoids that problem.

Both `echo` and `printf` can participate in redirection:

```bash
echo "Report" > "$REPORT"
printf "%s\n" "More data" >> "$REPORT"
```

The redirection rules remain the same as in Lab 1:

```text
>     write stdout to a file, overwriting
>>    write stdout to a file, appending
```

For the Linux Essentials v1.6 exercise, `echo` remains the required command to recognize and use. `printf` is included here as practical shell-portability knowledge.

A script does not change the meaning of these operators. It simply lets the same command sequence be stored and repeated.

---

## 9. The basic `for` loop

A `for` loop repeats commands for each item in a list.

A simple example:

```bash
for NAME in alice bob carol
do
    echo "$NAME"
done
```

Conceptually:

```text
take alice -> put it in NAME -> run the body
take bob   -> put it in NAME -> run the body
take carol -> put it in NAME -> run the body
```

The structure to remember is:

```bash
for VARIABLE in LIST
do
    commands
done
```

### Looping over matching files

Shell globbing can provide the list:

```bash
for LOG in logs/*.log
do
    echo "$LOG"
done
```

Before the loop runs, the shell expands `logs/*.log` to matching filenames. The loop then assigns each filename to `LOG` one at a time.

This combines two earlier concepts:

```text
shell glob    selects filenames
for loop      repeats a command block for each selected item
```

For Linux Essentials v1.6, the important target is the basic `for ... in ...; do ...; done` structure. Advanced loop forms are outside this lab.

---

## 10. Exit status and `$?`

After a command finishes, it returns an **exit status**.

By convention:

```text
0       success
nonzero some kind of failure, false result, or other non-success condition
```

Bash makes the previous command's exit status available through:

```text
$?
```

Example:

```bash
grep -i 'error' application.log
echo "$?"
```

If `grep` found at least one matching line, its status is normally:

```text
0
```

If it found no matching lines, its status is normally:

```text
1
```

The important rule is:

> **Read `$?` immediately after the command whose status matters.**

Every subsequent command produces its own exit status and replaces the previous value.

For example:

```bash
grep -i 'error' application.log
echo "Search finished"
echo "$?"
```

The final `$?` now describes the `echo "Search finished"` command, not the earlier `grep`.

A safer sequence is:

```bash
grep -i 'error' application.log
echo "grep-status=$?"
```

The variable expansion for `$?` occurs while Bash prepares the `echo` command, so it captures the status produced by `grep`.

For this exam:

```text
$? = exit status of the immediately preceding command
0  = success
```

Do not overgeneralize all nonzero values into one exact meaning; different commands can use different nonzero codes.

---

## 11. Running a script with `bash`

A script can be passed explicitly to Bash:

```bash
bash report.sh
```

In this form, the `bash` executable is explicitly told to read commands from `report.sh`.

The script file itself does not need execute permission for this form, because Bash is the executable being launched.

This is useful while developing or inspecting a script.

---

## 12. Executing a script directly

To launch a script directly, it normally needs execute permission:

```bash
chmod u+x report.sh
```

If the owner is the person who needs to run the script, `u+x` is sufficient; there is no need to make the script executable by every user merely to run it personally.

Then, from the directory containing it:

```bash
./report.sh
```

The pieces are:

```text
chmod u+x     give the owner execute permission
./            current directory
report.sh     script filename
```

Why `./`?

The current directory is normally not searched automatically through the shell's command-search path. Writing:

```bash
./report.sh
```

explicitly tells the shell where the executable file is.

When a script is executed this way, its shebang determines the interpreter.

This gives a useful distinction:

```text
bash report.sh    explicitly invoke Bash on the file
./report.sh       execute the file directly; execute bit + shebang matter
```

---

## 13. Editors: `vi` and `nano`

Linux Essentials expects awareness of common text editors such as:

```text
vi
nano
```

Either can be used to create a shell script.

Examples:

```bash
nano report.sh
vi report.sh
```

This lab does not require advanced editor proficiency. The target is recognition that scripts are ordinary text files and can be created or edited with a terminal text editor.

---

## 14. A complete v1.6-sized example

This example stays within the deliberate scope of the lab:

```bash
#!/bin/bash
# Print a label and inspect each matching log

LABEL="$1"

echo "Report: $LABEL"

for LOG in logs/*.log
do
    echo "$LOG"
    grep -i 'error' "$LOG"
    echo "grep-status=$?"
done
```

It demonstrates:

```text
shebang
comment
variable assignment
positional argument
variable expansion
echo
for loop
shell glob
exit status
```

It intentionally does **not** use a conditional statement. The script can display each command's exit status without making a branching decision from it.

---

## 15. Recognition-only: command substitution

Command substitution runs a command and replaces the substitution expression with that command's standard output.

Modern Bash syntax uses:

```bash
$(command)
```

For example:

```bash
TODAY=$(date)
echo "$TODAY"
```

Bash runs `date`, captures its output, and assigns that output to `TODAY`.

A common older form uses **backticks** (also called grave accents):

```bash
TODAY=`date`
```

The backtick form and `$(...)` both perform command substitution, but modern shell scripts generally prefer `$(...)` because it is easier to read and easier to nest.

For recognition:

```text
$(command)    modern command substitution
`command`     older/legacy command-substitution syntax
```

Command substitution is **not the same thing as quoting**:

```text
'single quotes'    preserve enclosed text literally
"double quotes"    allow expansions such as $VAR while preserving the result as one argument
$(command)         execute a command and substitute its output
`command`          legacy syntax for the same command-substitution operation
```

Double quotes can contain command substitution:

```bash
echo "Today is $(date)"
```

In that example, Bash runs `date`, substitutes its output into the double-quoted string, and then passes the resulting text as one argument to `echo`.

This section is included so that common Bash scripts and textbook examples using either form are understandable. Writing command substitutions is not required by the Lab 5 practical or checker.

---

## 16. What is deliberately outside this lab

Bash can do much more than the Linux Essentials v1.6 core used here. The following are useful real-world topics, but they are reserved for later study in this project:

```text
if / elif / else
while loops
functions
read -p
arithmetic expansion:  $(( ... ))
advanced command-substitution use
numeric/string/file test operators
more advanced argument handling
```

Keeping these out of the required lab prevents broader Bash knowledge from crowding out the exact syntax targeted by the current exam.

---

## 17. What to retain before starting the lab

Be able to reconstruct these forms:

```bash
#!/bin/bash

NAME=value
echo "$NAME"

FIRST="$1"
SECOND="$2"

for ITEM in item1 item2 item3
do
    echo "$ITEM"
done

command
echo "$?"

chmod u+x script.sh
./script.sh
```

And keep these concepts distinct:

```text
NAME=value      assign
$NAME           expand the variable
${NAME}         same expansion with an explicit variable-name boundary
"${NAME}.txt"   quote the resulting filename; braces delimit the name

$1              first positional argument
$2              second positional argument

$?              previous command's exit status
0               success

bash file.sh     Bash reads the file
./file.sh        direct execution; execute permission and shebang matter

$(command)       modern command substitution — recognition only
`command`         legacy command substitution — recognition only

read -r NAME     read input while preserving backslashes — practical enrichment
printf           predictable formatted output — practical enrichment
```

The practical lab will use the required pieces to automate a small log-inspection task. Command substitution is included only so common shell-script syntax can be recognized; it is not required by the practical exercise.
