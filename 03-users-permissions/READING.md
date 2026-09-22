# Lab 3 Pre-Reading — Users, Sessions, Ownership, and Permissions

Read this before starting **Lab 3 — Users, Sessions & Permissions**. Labs 1 and 2 showed that text processing and archive syntax are now largely retained, so this lab shifts deliberate practice toward permissions, session-inspection commands, account files, and basic user/group administration syntax.

The core mental model is:

```text
ls -l              read file type, permissions, owner, and group
chmod              change permission bits
chown              change owner and/or group

id                 UID, GID, and group memberships
who                users logged in now
w                  users logged in now + what they are doing
last               recent login history

sudo COMMAND       run a command under sudo policy
su - USER          switch to USER with a login shell

/etc/passwd        account identity and basic account information
/etc/shadow        protected password-hash information
/etc/group         group definitions and memberships

useradd USER       create a user account
groupadd GROUP     create a group
passwd USER        set/change a user's password
```

---

## 1. Reading an `ls -l` permission string

A long listing might begin like this:

```text
-rwxr-x--- 1 alice staff 418 Sep 20 09:00 deploy.sh
```

Focus first on:

```text
-rwxr-x---
││  │  │
││  │  └── other permissions
││  └───── group permissions
│└──────── owner/user permissions
└───────── file type
```

The first character describes the object type. Common values include:

```text
-    regular file
d    directory
l    symbolic link
```

The next nine characters are three permission triplets:

```text
rwx r-x ---
^^^ ^^^ ^^^
 u   g   o
```

where:

```text
u = user/owner
g = group
o = other
```

For each triplet:

```text
r = read
w = write
x = execute
- = permission absent
```

So:

```text
-rwxr-x---
```

means:

- regular file
- owner: read, write, execute
- group: read and execute
- other: no permissions

The owner and group names appear later in the same `ls -l` line.

---

## 2. Permissions mean slightly different things for files and directories

For a regular file:

```text
r    read file contents
w    modify file contents
x    execute the file as a program/script
```

For a directory:

```text
r    read/list directory entries
w    create, remove, or rename entries in the directory
x    traverse/search the directory and access entries within it
```

Directory permissions are therefore not just "the same permissions applied to a folder." In practice, useful access to a directory often depends on combinations of these bits, especially `x`.

---

## 3. Numeric `chmod`: 4, 2, 1

Numeric permissions use these values:

```text
r = 4
w = 2
x = 1
```

Add the values for each owner/group/other triplet:

```text
7 = 4 + 2 + 1 = rwx
6 = 4 + 2     = rw-
5 = 4     + 1 = r-x
4 = 4         = r--
0 =             ---
```

Then place the three digits in owner/group/other order.

Example:

```bash
chmod 640 report.txt
```

means:

```text
6    owner = rw-
4    group = r--
0    other = ---
```

So the resulting permission bits are:

```text
rw-r-----
```

Another common example:

```bash
chmod 755 script.sh
```

means:

```text
owner = rwx
group = r-x
other = r-x
```

Do not memorize every possible number as a separate fact. Reconstruct the value from:

```text
r=4, w=2, x=1
```

---

## 4. Symbolic `chmod`: who + operation + permission

Symbolic mode lets you state the change instead of replacing the entire numeric mode.

The "who" characters are:

```text
u    owner/user
g    group
o    other
a    all
```

The operators are:

```text
+    add permission
-    remove permission
=    set exactly these permissions for that class
```

The ordinary permission letters are:

```text
r    read
w    write
x    execute
```

Examples:

```bash
chmod u+x deploy.sh
```

adds execute permission for the owner without changing the owner's existing read/write bits or the group/other bits.

```bash
chmod g-w portal.conf
```

removes group write permission.

```bash
chmod o=r notice.txt
```

sets the **other** permissions to exactly read-only. Because `=` is used, any previous write or execute permission for other is removed.

The distinction between `+` and `=` matters:

```text
o+r    add read, preserve other existing permissions
o=r    set other to read only
```

For this exam, be comfortable moving both directions:

```text
numeric mode  <->  rwx meaning
symbolic change  ->  resulting permission state
```

---

## 5. Ownership: user and group

Linux files have both an owning user and an owning group.

A long listing might show:

```text
-rw-r----- 1 alice staff 82 Sep 20 10:30 portal.conf
                   ^^^^^
                   group
             ^^^^^
             owner
```

The basic `chown` form to set both is:

```bash
chown OWNER:GROUP FILE
```

For example:

```bash
chown alice:staff report.txt
```

changes the owning user to `alice` and the owning group to `staff`.

Changing ownership usually requires appropriate privileges. Because Prometheus is a real server, the scored portion of this lab does **not** require you to alter real system ownership or create real accounts. You will practice the syntax without making production-account changes.

---

## 6. The sticky bit

The sticky bit is especially relevant on shared writable directories.

A classic example is a directory where many users need to create files. Without additional protection, directory write permission can allow one user to remove another user's directory entries. The sticky bit restricts deletion/renaming so that, in the usual shared-directory case, users cannot simply delete other users' files.

A familiar system example is `/tmp`.

A sticky directory often looks like:

```text
drwxrwxrwt
```

Notice the final:

```text
t
```

The `t` occupies the **other execute position**.

You can add the sticky bit symbolically:

```bash
chmod +t shared-directory
```

Numeric notation can represent it with an additional leading digit:

```text
1777
│└── ordinary rwx permissions
└─── sticky bit
```

For this lab, understand both what the sticky bit does and how to recognize `t` in a long listing.

Do **not** expand this into SUID/SGID study for the current exam plan; those are outside the deliberate scope of this lab.

---

## 7. `/tmp` versus `/var/tmp`

Both are locations for temporary data, but the conventional distinction is:

```text
/tmp       short-lived temporary files; may be cleared automatically or at reboot
/var/tmp   temporary files intended to persist longer, including across reboots
```

Exact cleanup policy is system-dependent, but that conceptual distinction is the one to retain.

You can inspect the permissions on both without changing anything:

```bash
ls -ld /tmp /var/tmp
```

On a typical Linux system, the sticky bit is visible on these shared temporary directories.

---

## 8. Identity: `whoami` versus `id`

`whoami` answers a narrow question:

```bash
whoami
```

It prints the current effective username.

`id` gives substantially more account information:

```bash
id
```

Typical output includes:

```text
uid=1000(alice) gid=1000(alice) groups=1000(alice),27(sudo)
```

The key terms are:

```text
UID    user ID
GID    primary group ID
groups supplementary group memberships
```

So retain:

```text
whoami = username only
id     = UID, GID, and groups
```

---

## 9. `who`, `w`, and `last`

These three commands answer related but different questions.

### `who`: who is logged in now?

```bash
who
```

This reports current login sessions.

### `w`: who is logged in now, and what are they doing?

```bash
w
```

This adds activity information and commonly includes system summary information such as uptime/load.

### `last`: who logged in previously?

```bash
last
```

This shows login history using the system's login-record data.

The exam-friendly distinction is:

```text
who     current sessions
w       current sessions + activity
last    historical/recent login records
```

This was previously a weak distinction, so Lab 3 deliberately makes you run all three close together.

---

## 10. `sudo` versus `su`

These commands are related to privilege/user context but are not interchangeable.

### `sudo COMMAND`

```bash
sudo COMMAND
```

asks the configured sudo policy to run a particular command with another security context, commonly root.

The important idea is **run this command with permitted elevated privileges**.

### `su USER`

```bash
su alice
```

switches to another user shell.

### `su - USER`

```bash
su - alice
```

or equivalently:

```bash
su -l alice
```

requests a **login shell** for that user. The login-shell form more closely initializes the target user's login environment, including their home/environment setup.

For the current exam plan, retain the distinction:

```text
sudo command    run a command under sudo policy
su user         switch user
su - user       switch user with a login shell
```

---

## 11. The three account files to recognize

### `/etc/passwd`

Despite the name, modern Linux normally does **not** store password hashes directly in `/etc/passwd`.

A line is colon-delimited and contains basic account information such as:

```text
username:x:UID:GID:comment:home:shell
```

For example:

```text
alice:x:1001:1001:Alice Example:/home/alice:/bin/bash
```

High-value recognition points:

- username
- UID
- primary GID
- home directory
- login shell

### `/etc/shadow`

`/etc/shadow` contains protected password-related information, including password hashes when local password authentication is used. It is much more tightly permissioned than `/etc/passwd`.

For this exam plan, recognize the file and its purpose. You do **not** need to memorize detailed password-aging fields.

### `/etc/group`

This contains group definitions. A simplified line looks like:

```text
staff:x:2001:alice,bob
```

High-value recognition points:

- group name
- GID
- listed member usernames

The compact mapping is:

```text
/etc/passwd    users/account identity
/etc/shadow    protected password information
/etc/group     groups and memberships
```

---

## 12. Basic account-administration commands

The v1.6-focused command set for this lab is deliberately small.

Create a user:

```bash
useradd USER
```

Create a group:

```bash
groupadd GROUP
```

Set or change a user's password:

```bash
passwd USER
```

These operations change system account state and typically require privileges. In this lab you will construct the commands for exact recall but will **not execute them against Prometheus**.

Do not spend required study time here on `usermod`, `userdel`, `groupdel`, `visudo`, password-aging flags, account lock/unlock flags, or detailed shadow-field administration. Those belong in the post-WGU learn-later track for this project.

---

## 13. What to retain before starting the lab

You do not need to memorize this reading word-for-word. Be able to reconstruct these ideas:

```text
r=4, w=2, x=1

chmod 640 FILE
chmod u+x FILE
chmod g-w FILE
chmod +t DIRECTORY

chown OWNER:GROUP FILE

id      UID/GID/groups
who     current sessions
w       current sessions + activity
last    login history

sudo COMMAND
su - USER

/etc/passwd   user/account data
/etc/shadow   protected password data
/etc/group    group data

useradd USER
groupadd GROUP
passwd USER
```

The practical lab will make you apply these rather than merely reread them.
