# Linux Essentials 010-160 — Core Knowledge Review

This review complements Core Labs 1–6 rather than repeating them. It concentrates on knowledge and recognition that are easy to under-practice in terminal labs while still reviewing the high-value command associations from the practical track.

The official 010-160 objectives are version **1.6** and are organized into five topics.

---

# Topic 1 — The Linux Community and a Career in Open Source

## 1.1 Linux evolution and popular operating systems

A **Linux distribution** combines the Linux kernel with user-space software, package management, configuration defaults, and a release/update model.

Recognize these names and relationships:

| Distribution / platform | Association to remember |
|---|---|
| Debian | Major community distribution; basis for Ubuntu |
| Ubuntu | Debian-derived; **LTS** releases provide longer support periods |
| Linux Mint | Common desktop distribution derived from Ubuntu/Debian |
| Red Hat | Major enterprise Linux family |
| CentOS | Historically closely associated with the Red Hat ecosystem |
| Scientific Linux | Red Hat-compatible distribution named in the v1.6 objectives |
| SUSE / openSUSE | Major Linux distribution family |
| Raspberry Pi / Raspbian | Linux on small ARM-based computers and embedded/education systems |
| Android | Uses the Linux kernel and is a major mobile/embedded Linux platform |

Linux is also widely used in servers, embedded systems, networking devices, cloud computing, and virtualization.

Do not confuse the **Linux kernel** with an entire Linux distribution. The kernel is the operating-system core; a distribution packages it with the rest of a usable system.

### Cloud and virtualization

A **virtual machine (VM)** provides a software-defined computer environment that behaves like a separate machine.

**Cloud computing** provides computing resources such as virtual machines, storage, and services on demand. Linux is widely used in cloud infrastructure and cloud-hosted servers.

## 1.2 Major open-source applications

Recognize the general purpose of the applications named in the objectives.

### Desktop applications

| Application | General purpose |
|---|---|
| LibreOffice / OpenOffice.org | Office productivity suite |
| Thunderbird | Email client |
| Firefox | Web browser |
| GIMP | Image editing |

### Server and collaboration applications

| Application | General purpose |
|---|---|
| Apache HTTPD | Web server |
| NGINX | Web server / reverse proxy |
| MariaDB / MySQL | Relational database |
| NFS | Network file sharing, especially Unix/Linux environments |
| Samba | SMB/CIFS file and print sharing; commonly interoperates with Windows systems |
| Nextcloud / ownCloud | Self-hosted file synchronization/collaboration platforms |

### Development languages

Recognize that Linux development and administration commonly involve:

```text
C
Java
JavaScript
Perl
shell
Python
PHP
```

The exam does not require programming proficiency in each language.

### Package-management recognition

For 010-160, associate:

```text
Debian-family packages/tools:   dpkg, apt-get
RPM-family packages/tools:      rpm, yum
```

A **package manager** installs, removes, queries, and manages packaged software.

A **repository** is a configured source from which package-management tools can obtain packages and related metadata.

Detailed package administration is intentionally outside the Core labs.

## 1.3 Open-source software and licensing

### Free software and open source

**Free software** emphasizes the user's freedoms to run, study, modify, and redistribute software.

**Open source software** makes source code available under licenses that satisfy open-source criteria.

Common umbrella terms include:

```text
FOSS     Free and Open Source Software
FLOSS    Free/Libre and Open Source Software
```

"Free" in **free software** refers primarily to freedom, not necessarily zero price.

### FSF and OSI

```text
FSF    Free Software Foundation
OSI    Open Source Initiative
```

The FSF is strongly associated with the free-software movement and GNU.

The OSI is associated with the Open Source Definition and approval/recognition of open-source licenses.

### Copyleft versus permissive licensing

**Copyleft** licenses place reciprocal requirements on redistribution of modified/derived software. The **GPL** is the key example to recognize.

**Permissive** licenses generally allow broader reuse, including incorporation into proprietary software, while retaining comparatively limited conditions. **BSD-style licenses** are the key example named in the objectives.

**Creative Commons** licenses are commonly used for creative works and documentation rather than being the standard choice for software source code.

### Open-source business models

Open-source software can support commercial business models. Examples include paid support, consulting, hosted/cloud services, subscriptions, integration/custom development, and enterprise management or add-on products.

"Open source" does not mean that a company cannot charge money.

## 1.4 ICT skills and working in Linux

Recognize the difference between:

```text
terminal    a program/interface used to interact with a shell
console     a system-level text interface, often available independently of a desktop GUI
shell       the command interpreter, such as Bash
```

Linux systems may be used primarily through a GUI, a terminal inside a GUI, a local text console, or a remote command-line session.

General ICT concerns in the objective include browser configuration, privacy, safe password practices, searching for and saving information, using open-source applications for ordinary workplace tasks, and understanding cloud computing and virtualization at a basic level.

---

# Topic 2 — Finding Your Way on a Linux System

## 2.1 Command-line basics

### Shell command structure

A command line commonly has this structure:

```text
command option argument
```

For example:

```bash
ls -l /etc
```

Linux command names, filenames, and variable names are generally **case-sensitive**.

### Variables

Assignment:

```bash
TEAM="technical support"
```

Expansion:

```bash
echo "$TEAM"
```

Ordinary shell variable names:

- begin with a letter or underscore
- may then contain letters, digits, and underscores
- are case-sensitive
- cannot contain spaces or hyphens

### Environment variables and `export`

A shell variable normally exists in the current shell.

```bash
export NAME=value
```

marks the variable for inheritance by commands/programs started from that shell.

### `PATH`

`PATH` contains a colon-separated list of directories the shell searches when a command is entered without a pathname.

Inspect it with:

```bash
echo "$PATH"
```

This is why commands in standard executable directories can usually be entered by name, while a script in the current directory often needs:

```bash
./script.sh
```

### `type`

`type` tells you how the shell resolves a command name—for example, whether it is a shell builtin or an external command.

Example:

```bash
type cd
type grep
```

### `history`

`history` displays commands remembered by the shell's history mechanism.

### Quoting

Keep these distinctions clear:

```text
'...'    single quotes: preserve enclosed text literally
"..."    double quotes: allow expansions such as $VAR
\        backslash: can escape a following character
```

Example:

```bash
NAME="Northstar"
echo '$NAME'
echo "$NAME"
```

The first prints the literal characters `$NAME`; the second prints the variable value.

## 2.2 Getting help

### `man`

```bash
man COMMAND
```

opens the manual page for a command or topic.

### `info`

```bash
info COMMAND
```

opens documentation in the GNU Info system when available.

### `/usr/share/doc/`

Installed packages often place additional documentation under:

```text
/usr/share/doc/
```

### `locate`

`locate` searches a filename database and can quickly find paths by name.

Because it uses a database rather than walking the entire filesystem each time, results depend on the database having been updated.

For 010-160, recognize these four help/documentation locations:

```text
man
info
/usr/share/doc/
locate
```

## 2.3 Directories and listing files

Important pathname concepts:

```text
/       filesystem root
~       current user's home directory
.       current directory
..      parent directory
```

An **absolute path** begins from `/`.

A **relative path** is interpreted from the current working directory.

Hidden files normally begin with a dot:

```text
.bashrc
.profile
```

Useful `ls` associations:

```text
ls -l    long listing
ls -a    include hidden entries
ls -R    recursive listing
ls -d    list a directory entry itself rather than its contents
```

The Core labs assume routine familiarity with `cd`, relative paths, absolute paths, and ordinary file listing.

## 2.4 Creating, moving, and deleting files

Core command map:

```text
touch FILE          create an empty file or update timestamps
cp SOURCE DEST      copy
mv SOURCE DEST      move or rename
rm FILE             remove a file
mkdir DIR           create a directory
rmdir DIR           remove an empty directory
```

Linux filenames are case-sensitive:

```text
Report.txt
report.txt
```

can be different files.

### Simple shell globbing

The shell expands filename patterns before launching a command.

```text
*       any sequence of characters
?       one character
[abc]   one character from the set
[A-C]   one character from the range
```

A shell glob is **not the same thing as a grep regular expression**.

---

# Topic 3 — The Power of the Command Line

## 3.1 Archives and compression

An **archive** combines files/directories into one container.

**Compression** reduces data size.

They are related but separate operations.

### `tar`

High-value flag map:

```text
c    create archive
t    list archive contents
x    extract archive
f    archive filename follows
v    verbose
z    gzip compression
j    bzip2 compression
J    xz compression
```

Examples:

```bash
tar -czf backup.tar.gz directory/
tar -tzf backup.tar.gz
tar -xzf backup.tar.gz
```

Recognize standalone tools:

```text
gzip / gunzip
bzip2 / bunzip2
xz / unxz
zip / unzip
```

A `.tar.gz` file is a tar archive compressed with gzip.

## 3.2 Searching and extracting data

High-value tool map:

```text
grep    select matching text
less    page/search interactively
cat     output file contents
head    beginning of a file/stream
tail    end of a file/stream
sort    sort lines
cut     extract characters or delimited fields
wc      count lines/words/bytes
```

Frequently practiced options:

```text
grep -i    ignore case
grep -n    show line numbers
grep -v    invert/exclude matching lines
grep -r    recurse through directories
grep -c    count matching lines

cut -d     choose delimiter
cut -f     choose field
cut -c     choose character positions

wc -l      count lines
```

### Pipes and redirection

```text
|      send stdout from one command to stdin of another
>      redirect stdout, overwrite
>>     redirect stdout, append
2>     redirect stderr, overwrite
<      provide stdin from a file
```

### Shell glob versus regular expression

A shell glob selects filenames.

A regular expression describes text patterns for tools such as `grep`.

Do not transfer the meaning of `*`, `?`, or brackets blindly between the two systems.

For regular expressions, retain the basic concepts from the Core text-processing material, including `.` as a pattern character with special meaning, bracket expressions such as `[abc]`, repetition with `*`, and the pattern behavior practiced in the labs.

## 3.3 Turning commands into a script

Core Bash scripting map:

```text
#!/bin/bash      Bash shebang
# comment        ordinary comment
NAME=value       assignment
$NAME            variable expansion
$1, $2           positional arguments
for              basic repetition
echo             output
$?               previous command's exit status
```

Conventionally:

```text
0        success
nonzero  some non-success condition
```

Read `$?` immediately after the command whose status matters.

Direct execution:

```bash
chmod u+x script.sh
./script.sh
```

Explicit interpreter:

```bash
bash script.sh
```

The second form executes Bash and has Bash read the file, so the script itself does not need execute permission.

Recognize `vi` and `nano` as common terminal text editors.

---

# Topic 4 — The Linux Operating System

## 4.1 Choosing an operating system

Recognize broad distinctions among Linux, Windows, and macOS/OS X rather than memorizing marketing claims.

Linux distributions may differ in package-management systems, release cadence, default desktop/software, configuration choices, and support/maintenance life cycle.

### Beta versus stable

A **beta** release is pre-release software intended for testing and feedback.

A **stable** release is intended for normal production/general use.

### Maintenance cycles and LTS

Distributions have support and maintenance periods. An **LTS** release is intended to receive support for a longer period than ordinary short-cycle releases.

## 4.2 Computer hardware

Recognize the basic role of:

```text
motherboard    connects major system components
processor/CPU  executes instructions
power supply   converts/provides electrical power
RAM            volatile working memory
hard drive     persistent magnetic storage
SSD            persistent solid-state storage
optical drive  reads/writes optical media where present
peripherals    attached input/output devices
```

A disk can be divided into **partitions**.

Traditional Linux disk device names may appear under `/dev` in forms such as:

```text
/dev/sda
/dev/sda1
```

The exact device naming scheme depends on hardware and system configuration; the objective specifically expects recognition of `/dev/sd*`.

A **device driver** enables the operating system to communicate with hardware.

## 4.3 Where data is stored

High-value directory map:

```text
/etc       system configuration
/var/log   log files
/boot      boot-related files
/proc      process and kernel runtime information
/dev       device nodes
/sys       structured kernel/device information
```

High-value command map:

```text
ps       process snapshot
top      live interactive process view
free     memory usage
dmesg    kernel messages
```

**syslog** is a general logging concept/system named in the v1.6 objective. On a Linux system, log locations and implementations can vary, but `/var/log/` is the important filesystem association for this exam.

Do not confuse:

```text
free    memory usage
df      filesystem/disk-space usage
```

## 4.4 Your computer on the network

Basic concepts:

- an **IP address** identifies an interface on an IP network
- **IPv4** and **IPv6** are different IP protocol/address families
- a **router** forwards traffic between networks
- **DNS** resolves names through the configured resolver system

High-value command/file map:

```text
ip addr show       interface addresses
ip route show      routing table/default route
ping               reachability testing
host               basic DNS lookup
ss                 socket inspection
/etc/hosts         local static hostname mappings
/etc/resolv.conf   resolver/DNS configuration
```

Legacy associations:

```text
ifconfig    -> ip addr show
route       -> ip route show
netstat     -> ss
```

Do not confuse Linux `ifconfig` with Windows `ipconfig`.

---

# Topic 5 — Security and File Permissions

## 5.1 User types and basic security

Recognize three broad account categories:

```text
root user       administrative superuser; UID 0
standard user   ordinary interactive user
system user     account commonly used by a service or system component
```

Do not memorize one universal UID range for system users; ranges vary by distribution/configuration.

Important account files:

```text
/etc/passwd    basic account information
/etc/shadow    protected password hashes and password-related data
/etc/group     group information
```

Session/user inspection:

```text
id      UID, GID, group memberships
who     currently logged-in sessions
w       logged-in users plus activity
last    recent login/session history
```

Privilege/user switching:

```text
sudo COMMAND    run an authorized command as another user, normally root by default
su USER         switch user
su - USER       switch user and request a login shell/environment
```

## 5.2 Creating users and groups

Core recognition:

```text
useradd     create a user account
groupadd    create a group
passwd      set/change a password
```

`/etc/skel/` contains template files that can be copied into a newly created user's home directory.

User IDs (UIDs) identify users numerically. Group IDs (GIDs) identify groups numerically.

## 5.3 Permissions and ownership

A long listing begins with a file-type character followed by three permission triplets:

```text
-rwxr-x---
 ||| ||| |||
  u   g   o
```

The triplets apply to:

```text
u    owner/user
g    group
o    others
```

Permission values:

```text
r = 4
w = 2
x = 1
```

Example:

```text
640 = rw-r-----
```

Commands:

```bash
chmod 640 file
chmod u+x script.sh
chown OWNER:GROUP file
```

For directories, permissions affect directory operations:

- `r`: read/list directory entries
- `w`: create, remove, or rename entries, subject to other rules
- `x`: traverse/access entries in the directory

## 5.4 Special directories, permissions, and symbolic links

### `/tmp` and `/var/tmp`

Both are locations for temporary files.

Broad distinction:

- `/tmp`: temporary data that may be cleared more aggressively
- `/var/tmp`: temporary data generally intended to persist longer

Exact cleanup policy depends on the system.

### Sticky bit

On a shared writable directory, the sticky bit restricts removal/renaming so users cannot ordinarily delete or rename other users' files merely because the directory itself is writable.

A familiar mode is:

```text
1777
```

which is commonly associated with shared temporary directories.

### Symbolic links

Create a symbolic link with:

```bash
ln -s TARGET LINK_NAME
```

A symbolic link stores a pathname to another object.

Deleting the symbolic link does not delete its target.

A relative symlink target is interpreted relative to the directory containing the link.

### `ls -d`

When a directory pathname is supplied, `ls -d` lists the directory entry itself rather than listing the directory's contents.

---

# Final Core recall map

Before taking the quiz, these associations should be fast:

```text
GPL                 copyleft
BSD                 permissive
FSF                 Free Software Foundation
OSI                 Open Source Initiative

dpkg / apt-get      Debian-family package tools
rpm / yum           RPM-family package tools

PATH                command-search directories
export              pass variable into child-process environment
type                how shell resolves a command
history             prior shell commands
man / info          help systems
/usr/share/doc      installed documentation

tar c/t/x           create/list/extract
tar z/j/J           gzip/bzip2/xz
grep                search text
cut                 extract fields/characters
wc -l               count lines

ps / top            snapshot / live process view
free                memory
dmesg               kernel messages
/etc                 configuration
/var/log             logs
/proc                process + kernel runtime info
/dev                 device nodes
/sys                 kernel/device information

ip addr show        addresses
ip route show       routes
host                DNS lookup
ss                  sockets
/etc/hosts          local static mappings
/etc/resolv.conf    resolver configuration

id                  UID/GID/groups
who                 current sessions
w                   current sessions + activity
last                login history
sudo                authorized command as another user
su - USER           switch user with login environment

/etc/passwd         account information
/etc/shadow         protected password data
/etc/group          groups
/etc/skel           new-home templates

chmod               permissions
chown               ownership
sticky bit          shared-directory deletion/rename restriction
ln -s               symbolic link
```

## Scope guard

The Core review does not require broader Level 2 material such as advanced Bash branching/functions, detailed package administration, SSH administration, systemd service management, `sed`, `awk`, or other post-Core topics merely because they are useful in practice.
