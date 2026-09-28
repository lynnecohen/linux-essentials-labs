# Linux Essentials 010-160 — Core Review Answers

Use this only after attempting `QUIZ.md`.

Equivalent wording is acceptable unless the question asks for exact command syntax.

---

# Topic 1

### 1
**B. Debian and Ubuntu.**

### 2
Acceptable examples include **Android**, **Raspberry Pi/Raspbian**, embedded systems, or Linux in cloud environments.

### 3

```text
LibreOffice      office productivity
Thunderbird      email client
GIMP             image editor
Apache HTTPD     web server
MariaDB          relational database
Samba            SMB/CIFS file sharing
```

### 4
A repository is a configured source of packaged software and package metadata used by package-management tools.

### 5

```text
Debian family:  dpkg and apt-get
RPM family:     rpm and yum
```

### 6
**Copyleft** imposes reciprocal requirements when modified/derived software is redistributed; **GPL** is the key example.

**Permissive** licensing generally allows broader reuse with fewer reciprocal restrictions; **BSD** is the key example.

### 7
A **terminal** is an interface/program used to interact with a shell. A **console** is a system-level text interface. A **shell** is the command interpreter, such as Bash.

---

# Topic 2

### 8
`PATH` is the ordered, colon-separated set of directories the shell searches for commands entered without a pathname.

### 9
`export` marks the variable so programs/child processes launched from that shell can inherit it.

### 10
It reports how the shell resolves the name `grep`, such as whether it is a builtin, alias, function, or external command.

### 11

```text
echo '$NAME'    prints: $NAME
echo "$NAME"    prints: Northstar
```

### 12

```bash
history
```

### 13

```text
man             manual pages
info            GNU hypertext-style documentation
/usr/share/doc/ installed package documentation
locate          filename-database search
```

### 14

```text
absolute path   starts from filesystem root /
relative path   interpreted from the current directory
~               current user's home directory
.               current directory
..              parent directory
```

### 15
A leading dot normally marks a hidden entry. Use:

```bash
ls -a
```

### 16

```text
touch    create empty file/update timestamps
cp       copy
mv       move or rename
rm       remove file
mkdir    create directory
rmdir    remove empty directory
```

`*.log` is a shell glob because the **shell expands it into matching filenames before the command runs**.

---

# Topic 3

### 17

```bash
tar -czf backup.tar.gz project/
```

### 18

```text
c    create
t    list
x    extract
```

### 19

```text
-z    gzip
-j    bzip2
-J    xz
```

### 20
Archiving combines files/directories into a container; compression reduces the amount of data/storage required.

### 21

```text
grep -i    ignore case
grep -n    include line numbers
grep -v    select nonmatching lines
grep -r    search recursively
grep -c    count matching lines
```

In an extended regular expression, `?` means **zero or one occurrence of the preceding pattern**. In a shell glob, `?` means **exactly one arbitrary filename character**.

### 22

```text
|      stdout of left command -> stdin of right command
>      redirect stdout and overwrite
>>     redirect stdout and append
2>     redirect stderr
<      provide stdin from a file
```

### 23

```bash
cut -d',' -f3 users.csv
wc -l
```

### 24

```bash
#!/bin/bash

LABEL="night shift"

for item in alpha beta gamma
do
    echo "$item"
done
```

Equivalent valid variable and loop names are acceptable.

### 25

```text
$1    first positional argument
$2    second positional argument
$?    exit status of the immediately preceding command
```

`bash script.sh` executes **Bash**, which reads the script as input; the script file itself does not need execute permission. `./script.sh` executes the script directly, so execute permission is required and the shebang selects the interpreter.

---

# Topic 4

### 26
A **beta** release is pre-release/test software; a **stable** release is intended for ordinary production/general use. **LTS** means Long Term Support.

### 27

```text
CPU            executes instructions
RAM            volatile working memory
SSD            persistent solid-state storage
motherboard    connects major hardware components
power supply   provides electrical power
device driver  lets the OS communicate with hardware
```

### 28
It is a Linux device pathname representing a disk/partition. In the traditional `/dev/sd*` scheme, `/dev/sda1` is a partition associated with the `sda` disk.

### 29

```text
/etc       system configuration
/var/log   log files
/boot      boot-related files
```

### 30

```text
/proc    process and kernel runtime information
/dev     device nodes
/sys     structured kernel/device information
```

### 31

```text
ps       process snapshot
top      live process view
free     memory usage
dmesg    kernel messages
```

### 32

```bash
ip addr show
ip route show
ping -c 4 127.0.0.1
```

### 33

```text
basic DNS lookup = host
socket inspection = ss
local static hostname mappings = /etc/hosts
resolver configuration = /etc/resolv.conf
legacy ifconfig replacement = ip addr show
legacy route replacement = ip route show
legacy netstat replacement = ss
```

---

# Topic 5

### 34
**root** is the administrative superuser and has UID **0**. A **standard user** is an ordinary user account. A **system user** is generally an account used by a service or system component.

### 35

```text
/etc/passwd    basic account information
/etc/shadow    protected password/password-related data
/etc/group     group information
```

### 36

```text
useradd     create user account
groupadd    create group
passwd      set/change password
/etc/skel   template files used when creating new user home directories
```

### 37

```text
id       UID, GID, group memberships
who      current login sessions
w        current users plus activity
last     recent login/session history
sudo     run an authorized command as another user, normally root by default
su -     switch user with a login shell/environment
```

### 38

```text
640 = rw-r-----
      owner: read/write
      group: read
      others: none
```

Command:

```bash
chmod u+x deploy.sh
```

### 39
On a shared writable directory, the sticky bit prevents users from ordinarily deleting or renaming entries belonging to other users merely because the directory is writable.

Broadly, `/tmp` is for shorter-lived temporary data and may be cleared more aggressively; `/var/tmp` is intended for temporary data that persists longer. Exact cleanup policy is system-dependent.

### 40

```bash
ln -s release-2 current
```

1. The relative target is interpreted relative to the directory containing the link—in this example, `releases/`.
2. `ls -d releases/` lists the directory entry itself rather than listing its contents.

---

# Interpretation

Do not use one total score as the only diagnostic. Review misses by topic:

```text
Topic 1 miss -> ecosystem, applications, licensing, ICT concepts
Topic 2 miss -> shell fundamentals, help, paths, routine file operations
Topic 3 miss -> archives, text processing, redirection, scripting
Topic 4 miss -> OS/hardware, Linux storage locations, networking
Topic 5 miss -> accounts, sessions, permissions, special directories/links
```

A missed exact command should be typed in a terminal afterward when practical. A missed conceptual item should be reviewed in `REVIEW.md` and then answered again from memory.
