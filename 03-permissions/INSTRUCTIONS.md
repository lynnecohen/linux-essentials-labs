# Lab 3 — Users, Sessions & Permissions

## Scenario

The fictional **Northstar Learning Portal** is preparing a shared administration workspace. Several files have overly broad permissions, two maintenance scripts are not executable in the intended way, and a shared drop directory needs the protection normally associated with a multi-user temporary directory.

At the same time, you will inspect the host Linux system's current login/session information and review account databases without modifying real accounts.

Skills from Labs 1 and 2 may recur incidentally, but Lab 3 deliberately concentrates on permissions, users/groups, sessions, and account files.

## Primary practice targets

- reading `ls -l` file type and owner/group/other permission strings
- numeric `chmod`
- symbolic `chmod`, especially `u+x`
- owner/group concepts and `chown OWNER:GROUP FILE` syntax
- sticky bit recognition and use
- `id`
- `who` versus `w` versus `last`
- `sudo` versus `su - USER`
- `/etc/passwd`, `/etc/shadow`, and `/etc/group`
- recognition of `useradd`, `groupadd`, and `passwd`

## Before you begin — pre-reading

Read **[Lab 3 Pre-Reading — Users, Sessions, Ownership, and Permissions](PRE_READING.md)** before starting the practical work.

The reading explains permission strings, numeric and symbolic chmod, the sticky bit, session commands, account files, and the limited account-administration syntax required for this lab.

## Setup

From the repository root, run:

```bash
bash setup.sh 3
```

Then work from:

```text
03-permissions/work/
```

Do not edit files under `03-permissions/source/`; `reset.sh` uses those files to rebuild the workspace.

The generated workspace contains:

```text
files/
  deploy.sh
  healthcheck.sh
  portal.conf
  secret.key
  shared-drop/
    README.txt

accounts/
  passwd
  shadow
  group

results/
```

The files under `accounts/` are **sanitized fictional examples**, not copies of the host system's account secrets.

---

## Part A — Read the starting permission state

These orientation tasks are not scored.

1. Use a long listing to inspect the files under `files/`.
2. Use a long directory listing to inspect `files/shared-drop/` itself, not only its contents.
3. For each of the following, state to yourself the owner, group, and other permissions:
   - `files/deploy.sh`
   - `files/healthcheck.sh`
   - `files/portal.conf`
   - `files/secret.key`
4. Identify the first character in the long listing for:
   - a regular file
   - the `shared-drop` directory

Do not change anything until you understand the starting modes.

---

## Part B — Repair the permission state

These tasks are scored. The checker validates the resulting permission state, not the particular `chmod` spelling you used unless the task explicitly asks you to practice a form.

### 1. Owner execute permission

`files/deploy.sh` starts as a normal non-executable text file.

Using **symbolic chmod syntax**, add execute permission for the **owner only** while preserving all existing permissions.

### 2. Numeric executable mode

Set:

```text
files/healthcheck.sh
```

to numeric mode:

```text
755
```

Before running the command, mentally translate 755 into owner/group/other rwx permissions.

### 3. Remove group write

`files/portal.conf` begins with group write permission enabled.

Using **symbolic chmod syntax**, remove write permission from the group while leaving the other bits alone.

### 4. Protect a secret

Set:

```text
files/secret.key
```

to numeric mode:

```text
600
```

Confirm with a long listing that only the owner has read/write access.

### 5. Protect the shared drop directory with the sticky bit

`files/shared-drop/` begins writable by owner, group, and other.

Add the **sticky bit** while preserving the existing ordinary permissions. The final numeric mode should be equivalent to:

```text
1777
```

Confirm that the directory's long-listing permission string ends in:

```text
t
```

Do not remove the directory or its README file.

---

## Part C — Inspect your identity and active sessions

These tasks are read-only and are not scored because session output depends on the current server state.

Run each command separately and compare what it tells you:

1. Run `id`. Identify your UID, primary GID, and group memberships.
2. Run `who`. Note which users/sessions are currently logged in.
3. Run `w`. Compare its output with `who`; identify what additional activity/system information it adds.
4. Run `last | head -n 8` to inspect a small amount of login history without flooding the terminal.

Then save your current `id` output for the checker:

```text
results/current-id.txt
```

The checker only verifies that it looks like `id` output; it does not expect any particular username or numeric UID.

---

## Part D — Inspect Linux account files safely

First inspect the real server **read-only**:

1. Display a few lines from `/etc/passwd`.
2. Display a few lines from `/etc/group`.
3. Use `ls -l /etc/shadow` to inspect its permissions. Do **not** copy or display password hashes from the host system for this exercise.

Then inspect the sanitized examples in:

```text
accounts/passwd
accounts/group
accounts/shadow
```

Use them to identify:

- where a username, UID, GID, home directory, and shell appear in a passwd entry
- where the group name, GID, and member list appear in a group entry
- why the shadow file is treated as more sensitive than passwd

Create:

```text
results/account-files.txt
```

containing exactly these three lines:

```text
user-identity=/etc/passwd
password-data=/etc/shadow
group-data=/etc/group
```

This is intentionally a recognition check, not a detailed shadow-field exercise.

---

## Part E — Account-administration syntax without changing the host

The following commands can modify real system account state, so **do not execute them** for this lab.

On paper, in a scratch file, or verbally, construct the commands you would use to:

1. create a group named `lpi_staff`
2. create a user named `lpi_alice`
3. set/change the password for `lpi_alice`
4. change `example.txt` so its owner is `lpi_alice` and its group is `lpi_staff`
5. switch to `lpi_alice` using a login shell

Also be able to explain why `sudo COMMAND` and `su - USER` are not the same operation.

This section is deliberately unscored in the filesystem checker. It is tested again in the exact-recall checkpoint below.

---

## Part F — Inspect temporary-directory permissions

This section is read-only and unscored.

Run:

```bash
ls -ld /tmp /var/tmp
```

Look for the sticky-bit `t` in the permission string.

Be able to state the conventional distinction:

- `/tmp`: short-lived temporary data
- `/var/tmp`: temporary data intended to persist longer, commonly across reboots

Do not change either system directory.

---

## Check your work

From the repository root:

```bash
bash check.sh 3
```

The checker validates the scored workspace permissions and recognition files. It does not modify real users, groups, account databases, or system temporary directories.

If you want to reset the generated workspace:

```bash
bash reset.sh 3
```

---

## Exact-recall checkpoint

Do this **after** the practical tasks, without looking back at the reading if possible.

1. A file should be owner read/write, group read-only, and inaccessible to other. What numeric `chmod` mode is that?
2. Write the symbolic command that adds execute permission for the owner of `deploy.sh`.
3. Write the symbolic command that removes group write permission from `portal.conf`.
4. What do the values 4, 2, and 1 represent in numeric permissions?
5. In `-rwxr-x---`, what do the three permission triplets mean?
6. What does a final `t` in a directory permission string such as `drwxrwxrwt` indicate?
7. State the difference between `who`, `w`, and `last`.
8. What additional information does `id` provide beyond `whoami`?
9. Which files correspond to account identity, protected password information, and group definitions?
10. Write the basic commands to create user `lpi_alice`, create group `lpi_staff`, and set `lpi_alice`'s password.
11. Write the basic syntax to make `lpi_alice` the owner and `lpi_staff` the group of `example.txt`.
12. What is the difference between `su lpi_alice` and `su - lpi_alice`?
13. At a high level, how does `sudo COMMAND` differ from `su - USER`?
14. What is the conventional difference between `/tmp` and `/var/tmp`?

After attempting all fourteen questions from memory, compare your responses with **[Lab 3 Exact-Recall Answer Key](ANSWERS.md)**.

## Stop point

Before moving to Lab 4, note any permission, session, account-file, or privilege-switching concepts that still required a lookup. Revisit only those items, then continue with the next Core lab.
