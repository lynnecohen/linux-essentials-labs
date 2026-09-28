# Linux Essentials 010-160 — 40-Question Core Review

Complete this without `REVIEW.md` or `ANSWERS.md` open if possible.

The topic distribution mirrors the official v1.6 objective weights as a study exercise. It is **not** a claim about the exact distribution of questions on the real exam.

---

# Topic 1 — Linux Community and Open Source

### 1
Which pair is most directly associated with the Debian family?

A. Red Hat and CentOS  
B. Debian and Ubuntu  
C. SUSE and Fedora  
D. Android and BSD

### 2
Give one example from the v1.6 objectives of Linux being used outside a conventional desktop/server PC environment.

### 3
Match each application to its primary role:

```text
LibreOffice
Thunderbird
GIMP
Apache HTTPD
MariaDB
Samba
```

Roles:

```text
image editor
office productivity
email client
web server
relational database
SMB/CIFS file sharing
```

### 4
What is the general purpose of a software **repository** in package management?

### 5
Complete the package-tool associations:

```text
Debian family:  ________ and ________
RPM family:     ________ and ________
```

Use only tools named in the 010-160 v1.6 objectives.

### 6
Briefly distinguish **copyleft** from **permissive** licensing, and name one objective-listed example of each.

### 7
What is the difference among a **terminal**, a **console**, and a **shell** at a high level?

---

# Topic 2 — Finding Your Way on Linux

### 8
What does the `PATH` environment variable control?

### 9
What does `export` do to a shell variable?

### 10
What is `type grep` intended to tell you?

### 11
Assume:

```bash
NAME="Northstar"
```

What do these print?

```bash
echo '$NAME'
echo "$NAME"
```

### 12
Which command displays the shell's remembered command history?

### 13
Match each item to its role:

```text
man
info
/usr/share/doc/
locate
```

Roles:

```text
GNU hypertext-style documentation
manual pages
installed package documentation
filename-database search
```

### 14
Define:

```text
absolute path
relative path
~
.
..
```

### 15
What does a leading dot normally indicate in a filename, and which `ls` option includes such entries?

### 16
Write the command names normally used to:

```text
create an empty file
copy
move/rename
remove a file
create a directory
remove an empty directory
```

Then explain in one sentence why `*.log` is a shell glob rather than a grep regular expression.

---

# Topic 3 — The Power of the Command Line

### 17
Write a command that creates a gzip-compressed tar archive named `backup.tar.gz` from a directory named `project/`.

### 18
What do the tar mode letters `c`, `t`, and `x` mean?

### 19
Match each tar compression flag:

```text
-z
-j
-J
```

to:

```text
gzip
bzip2
xz
```

### 20
What is the difference between **archiving** and **compression**?

### 21
State the purpose of each:

```text
grep -i
grep -n
grep -v
grep -r
grep -c
```

Then state what `?` means in an extended regular expression and how that differs from shell-glob `?`.

### 22
State what each shell operator does:

```text
|
>
>>
2>
<
```

### 23
Write the core syntax for extracting field 3 from a comma-delimited file named `users.csv`. Then name the command/option used to count lines.

### 24
Write:

1. the standard Bash shebang used in the Core labs
2. a valid assignment storing the literal phrase `night shift` in `LABEL`
3. a basic `for` loop that prints `alpha`, `beta`, and `gamma`

### 25
What do `$1`, `$2`, and `$?` mean inside a shell script? Why can `bash script.sh` work even when `./script.sh` fails with a permission error?

---

# Topic 4 — The Linux Operating System

### 26
Briefly distinguish a **beta** release from a **stable** release. What does **LTS** indicate?

### 27
Match each hardware term to its role:

```text
CPU
RAM
SSD
motherboard
power supply
device driver
```

Roles:

```text
volatile working memory
executes instructions
persistent solid-state storage
connects major hardware components
provides electrical power
lets the OS communicate with hardware
```

### 28
What does a name such as `/dev/sda1` represent at a high level?

### 29
Match:

```text
/etc
/var/log
/boot
```

to:

```text
system configuration
log files
boot-related files
```

### 30
Briefly distinguish:

```text
/proc
/dev
/sys
```

### 31
Match each command:

```text
ps
top
free
dmesg
```

to:

```text
process snapshot
live process view
memory usage
kernel messages
```

### 32
Write the modern Linux command forms emphasized in the Core labs for:

```text
interface addresses
routing table/default route
```

Then write a command that sends exactly four ping requests to `127.0.0.1`.

### 33
Fill in the network map:

```text
basic DNS lookup = ________
socket inspection = ________
local static hostname mappings = ________
resolver configuration = ________
legacy ifconfig replacement = ________
legacy route replacement = ________
legacy netstat replacement = ________
```

---

# Topic 5 — Security and File Permissions

### 34
Distinguish **root**, a **standard user**, and a **system user**. What UID is associated with root?

### 35
Match:

```text
/etc/passwd
/etc/shadow
/etc/group
```

to:

```text
group information
basic account information
protected password/password-related data
```

### 36
What do `useradd`, `groupadd`, and `passwd` do? What is the purpose of `/etc/skel/`?

### 37
Distinguish:

```text
id
who
w
last
sudo
su -
```

### 38
Interpret the permission mode:

```text
640
```

Then write a symbolic command that adds owner execute permission to `deploy.sh`.

### 39
What does the **sticky bit** accomplish on a shared writable directory? Also give the broad distinction between `/tmp` and `/var/tmp`.

### 40
Write the general syntax for creating a symbolic link named `current` pointing to `release-2`.

Then answer:

1. If `release-2` is a relative target and the link is inside `releases/`, relative to what directory is the target interpreted?
2. What does `ls -d releases/` do differently from a normal listing of that directory?
