# Lab 1 Pre-Reading — Searching and Processing Text

Read this before starting **Lab 1 — Production Incident Investigation**. The goal is not to memorize every example. It is to understand the small set of tools that you will combine during the lab.

The core mental model is:

```text
grep     select lines
cut      select fields or character positions
sort     reorder lines
wc       count
head     show the beginning
tail     show the end
less     inspect and search interactively

|        send stdout to another command
>        redirect stdout, overwriting
>>       redirect stdout, appending
2>       redirect stderr
<        feed a file to stdin
```

---

## 1. Viewing text: `cat`, `less`, `head`, and `tail`

These commands overlap, but they are useful in different situations.

| Command | Best use |
|---|---|
| `cat file` | Print an entire short file |
| `less file` | Interactively inspect and search a longer file |
| `head file` | Show the beginning of a file |
| `tail file` | Show the end of a file |

`head` and `tail` display 10 lines by default. Use `-n` when you want a specific number:

```bash
head -n 5 example.log
tail -n 20 example.log
```

### Searching inside `less`

Start the pager with:

```bash
less example.log
```

Once you are inside `less`, type:

```text
/timeout
```

and press **Enter**. This searches forward through the file.

Then use:

```text
n    repeat the search in the same direction
N    repeat the search in the opposite direction
q    quit less
```

You can also search backward by starting the search with `?` instead of `/`:

```text
?timeout
```

If your previous search was backward, `n` continues backward and `N` searches forward. In other words, `n` means "next match in the direction I was already searching," not necessarily "further down the file."

Searches in `less` are case-sensitive by default. Two useful launch options are:

```bash
less -i example.log
less -I example.log
```

- `-i` ignores case when the search pattern contains no uppercase letters. A search for `/timeout` can therefore match `timeout`, `Timeout`, and `TIMEOUT`, but an uppercase letter in the pattern makes the search case-sensitive.
- `-I` always ignores case, even if your search pattern contains uppercase letters.

You can toggle `-i` while already inside `less` by typing:

```text
-i
```

`less` searches are regular-expression searches, so regex metacharacters can matter there too. For this lab, simple literal-word searches are enough; the important skill is knowing how to search, move between matches, and quit the pager.

A useful distinction:

- `grep` is good when you want to **produce matching lines as output**.
- `less` is good when you want to **stay inside the file and navigate around matches interactively**.

---

## 2. `grep`: selecting lines of text

Basic form:

```bash
grep 'pattern' filename
```

`grep` works line by line. If a line contains a match, the entire line is normally printed.

The high-value flags for this lab are:

| Flag | Meaning | Memory cue |
|---|---|---|
| `-i` | Ignore capitalization | insensitive |
| `-n` | Show matching line numbers | number |
| `-v` | Show lines that do **not** match | invert |
| `-r` | Search directories recursively | recursive |
| `-c` | Count matching lines | count |

Example:

```bash
grep -i 'failure' example.log
```

matches `failure`, `Failure`, `FAILURE`, and other capitalization variants.

Flags can normally be combined:

```bash
grep -in 'failure' example.log
```

That means "ignore capitalization and show the matching line numbers."

Keep these distinctions straight:

```text
grep -n    print matching lines with their line numbers
grep -c    print the number of matching lines
grep -v    invert the match: print nonmatching lines
grep -r    recurse through directories and their subdirectories
```

`grep -c` counts **matching lines**, not individual occurrences. If one line contains the word `ERROR` three times, that line still contributes one to the count.

### Recursive search

When `grep` receives a file, it searches that file:

```bash
grep 'timeout' server.log
```

When it receives a directory with `-r`, it walks through that directory and its subdirectories:

```bash
grep -r 'timeout' logs/
```

Do not assume that the same option letter means the same thing for every command. For example:

```text
grep -r    recursive search
ls -r      reverse sort order
```

Options belong to their individual commands.

---

## 3. Shell globs versus regular expressions

This is an important distinction because the syntax looks similar while the interpretation is different.

### Shell globs

A shell glob is normally expanded by Bash **before the command runs**.

For example:

```bash
ls *.log
```

Bash looks for filenames matching `*.log` and substitutes the matching filenames into the command line. `ls` normally receives the resulting filenames rather than the literal text `*.log`.

Common glob characters are:

```text
*        zero or more characters
?        exactly one character
[1-3]    one character from the range 1 through 3
[abc]    one character from the set a, b, or c
```

So the shell glob:

```text
report?.txt
```

can match filenames such as:

```text
report1.txt
reportA.txt
report-.txt
```

but not:

```text
report12.txt
```

because glob `?` represents exactly one character.

The period in a shell glob is normally just a literal period. Thus the `.txt` in `report?.txt` really means the filename extension `.txt`.

### `grep` patterns are regular expressions

`grep` does **not** interpret its pattern as a shell glob. By default, GNU `grep` uses **basic regular expressions (BRE)**.

This has several consequences:

| Symbol | Shell glob | Basic `grep` regex |
|---|---|---|
| `*` | Any number of characters | Repeat the preceding regex item zero or more times |
| `?` | Exactly one character | Normally a literal `?` in BRE |
| `.` | Literal period | Any one character |
| `[1-3]` | One character in the range | One character in the range |
| `^` | No ordinary "start" meaning | Start of line |
| `$` | No ordinary "end" meaning | End of line |

This means these two patterns are **not equivalent**:

```bash
ls report?.txt
grep 'report?.txt' names.txt
```

In the shell glob, `?` means one arbitrary character and `.` is literal.

In basic `grep` regex, the `?` is normally literal while `.` means one arbitrary character.

If `names.txt` contains one filename per line and you want a basic regex analogous to the glob `report?.txt`, you could write:

```bash
grep '^report.\.txt$' names.txt
```

Breakdown:

```text
^          beginning of line
report     literal text
.          any one character
\.         literal period
 txt       literal text
$          end of line
```

The anchors `^` and `$` make the regex match the whole line rather than merely finding the pattern somewhere inside a longer line.

Another comparison:

```bash
ls *.log
```

uses glob `*` to mean "any string of characters before `.log`."

An analogous regex for a line containing only a filename would be:

```bash
grep '^.*\.log$' names.txt
```

Here:

```text
.     any one character
*     repeat the preceding `.` zero or more times
.*    therefore means zero or more arbitrary characters
```

That is why regex `*` is fundamentally different from glob `*`: regex `*` modifies the expression immediately before it.

### What about `grep -E`?

`grep -E` uses **extended regular expressions (ERE)**. In ERE, `?` becomes a quantifier meaning "the preceding item is optional" (zero or one occurrence).

For example:

```text
colou?r
```

matches both `color` and `colour` under ERE.

`grep -E` is useful real-world Linux knowledge, but it is not a deliberate memorization target for this v1.6 lab plan. The important exam-prep distinction here is **shell globbing versus text regex matching**.

### Quoting and expansion

Quoting does not "turn a glob into regex." It controls what the **shell** is allowed to interpret before the command receives its arguments.

Compare:

```bash
ls *.log
```

with:

```bash
ls '*.log'
```

In the first command, Bash expands the glob into matching filenames.

In the second, the single quotes prevent glob expansion, so `ls` receives the literal characters `*.log` and looks for a file literally named `*.log`.

By contrast:

```bash
grep '.*\.log' names.txt
```

quotes the regex so Bash passes it intact to `grep`. `grep`, not the shell, interprets the regex metacharacters.

A useful mental model is:

> **Shell globs usually select filenames for the shell. Regular expressions select text for programs such as `grep` and for searches inside tools such as `less`.**

---

## 4. Extracting data with `cut`

`cut` extracts fields or character positions. It does not decide which records are logically "active," "failed," or "important"; another tool such as `grep` can perform that filtering first.

Imagine this CSV data:

```text
alice,IT,active
bob,Finance,inactive
carol,IT,active
```

To define comma as the delimiter and extract field 2:

```bash
cut -d',' -f2 employees.csv
```

The result is:

```text
IT
Finance
IT
```

The mental pattern is:

```text
cut -d'DELIMITER' -fFIELD FILE
```

For a colon-delimited file such as `/etc/passwd`:

```bash
cut -d':' -f1 /etc/passwd
```

There is another mode:

```bash
cut -c1-5 file.txt
```

`-c` means character positions. It extracts characters 1 through 5 from every line.

Remember:

```text
-d + -f    delimiter + field extraction
-c         character-position extraction
```

### Combining row filtering and field extraction

Suppose you first need only rows containing a particular status and then need one field from those rows. Think of that as two separate transformations:

```text
input rows
   ↓
select the rows you want
   ↓
extract the desired field
```

A pipeline lets each command handle one job.

---

## 5. Counting with `wc`

`wc` can count several properties of text:

| Option | Counts |
|---|---|
| `wc -l` | Lines |
| `wc -w` | Words |
| `wc -c` | Bytes |

For this lab, `wc -l` is the main target:

```bash
wc -l example.log
```

### Why does `wc -c` mean bytes instead of characters?

The name is historical: `-c` originally meant a character count in environments where one character commonly occupied one byte. Modern encodings such as UTF-8 make the distinction important.

For example, in UTF-8:

```text
A    one character, one byte
é    one character, usually two bytes
```

So modern `wc` distinguishes:

```text
wc -c    bytes
wc -m    characters
```

For Linux Essentials v1.6 preparation, prioritize `-l`, `-w`, and `-c`. Deliberate memorization of `-m` is not required for this lab.

A powerful use of `wc` is counting output from another command:

```bash
some-command | wc -l
```

That counts the lines produced by `some-command`.

---

## 6. Pipes: chaining small tools

The pipe operator:

```text
|
```

takes **standard output** from the command on the left and feeds it to **standard input** of the command on the right.

Example:

```bash
grep 'ERROR' example.log | wc -l
```

Conceptually:

```text
example.log
    ↓
grep selects matching lines
    ↓
wc counts those lines
```

You can compose multiple tools:

```bash
command1 | command2 | command3
```

The point is not to make commands as long as possible. The point is to let each utility perform one clear transformation.

---

## 7. Sorting text

Basic `sort` orders lines as text:

```bash
sort file.txt
```

Use `-r` to reverse the resulting order:

```bash
sort -r file.txt
```

Use `-n` when the lines should be interpreted numerically:

```bash
sort -n numbers.txt
```

Combine them for descending numeric order:

```bash
sort -nr numbers.txt
```

### "Lexical" versus "alphabetical"

Lexical or lexicographic sorting is similar to alphabetical sorting, but "lexical" is more precise because the values are treated as **text strings**, not numbers.

For ordinary words, lexical order often looks alphabetical:

```text
apple
banana
cherry
```

Numbers expose the difference more clearly. Text sorting can produce an order such as:

```text
1
10
100
2
20
3
```

because the values are being compared as strings of characters.

Numeric sorting instead interprets their numerical values:

```text
1
2
3
10
20
100
```

For exam purposes:

```text
sort       order lines as text
sort -n    interpret values numerically
sort -r    reverse the resulting order
```

Locale, capitalization, and punctuation can also affect text ordering, which is another reason "lexical" is more precise than simply saying "alphabetical."

---

## 8. Standard input, standard output, and standard error

Linux processes conventionally use three standard streams:

| Number | Stream | Purpose |
|---:|---|---|
| `0` | stdin | Input |
| `1` | stdout | Normal output |
| `2` | stderr | Error output |

This explains the redirection operators.

### Standard output

```bash
command > output.txt
```

redirects stdout and overwrites the target file.

```bash
command >> output.txt
```

redirects stdout and appends to the target file.

If the target does not yet exist, both `>` and `>>` create it. Their difference becomes important when the target already contains data.

### Standard error

```bash
command 2> errors.txt
```

redirects only stderr. Ordinary stdout remains on the terminal unless it is redirected separately.

The `2` refers to file descriptor 2, which is stderr.

### Standard input

```bash
command < input.txt
```

has the shell open `input.txt` and connect it to the command's stdin.

For example, these may produce the same visible result:

```bash
sort numbers.txt
sort < numbers.txt
```

but the mechanism is different:

- In the first form, `sort` receives a filename argument.
- In the second, the shell feeds the file's contents into `sort` through stdin.

---

## 9. Quoting

Quotes affect how Bash interprets text before a command runs.

Single quotes preserve text essentially literally:

```bash
echo '$HOME'
```

prints:

```text
$HOME
```

Double quotes still allow variable expansion:

```bash
echo "$HOME"
```

prints the value of your home-directory variable.

For searches containing spaces, quoting is necessary:

```bash
grep 'permission denied' example.log
```

Without quotes, Bash would split `permission` and `denied` into separate command arguments.

For regex or glob work, remember the more general rule:

> **The shell gets the first chance to interpret your command line. Quoting controls that shell interpretation. The program then interprets the arguments it receives according to its own rules.**

This explains why quoting a regex for `grep` is usually desirable, while quoting a glob intended for Bash expansion changes its behavior.

---

## 10. What to retain before starting Lab 1

You do not need to memorize every example above. Be able to recognize and retrieve this core set:

```text
grep:  -i -n -v -r -c
cut:   -d -f -c
sort:  -r -n
wc:    -l   (plus recognition of -w and -c)
head:  -n
tail:  -n
less:  /pattern, ?pattern, n, N, q; -i/-I for case behavior
```

And keep these concepts distinct:

```text
shell glob        filename matching performed by the shell
regex             text-pattern matching performed by grep/less

|                 stdout → stdin of another command
>                 stdout → file, overwrite
>>                stdout → file, append
2>                stderr → file
<                 file → stdin
```

The lab will provide the retrieval and combination practice. If you have to look up a detail once, that is fine; note it and see whether you can retrieve it unaided by the exact-recall checkpoint.