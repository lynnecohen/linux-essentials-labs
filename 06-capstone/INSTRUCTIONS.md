# Core Lab 6 — Capstone

## Scenario

A deployment of the fictional **Northstar Learning Portal** was interrupted during an evening handoff. The next administrator needs to determine what was left incomplete, restore the intended production state, prepare an incident packet, and leave a small reusable handoff script.

You have inherited a workspace containing releases, configuration, logs, data files, a backup archive, and several filesystem objects. Some state is correct and some is not.

The deployment briefing is:

```text
briefing.txt
```

Read it first.

## Purpose

Unlike Labs 1–5, this capstone usually tells you **what outcome is required**, not which command to type.

Use the Linux Essentials tools you have already practiced. The checker validates the resulting state and required artifacts rather than one exact command sequence.

Do not inspect `source/` or `check.sh` for solutions while completing the exercise.

---

## Setup

From the repository root:

```bash
bash setup.sh 6
```

Then work from:

```text
06-capstone/work/
```

Read:

```text
briefing.txt
```

Inspect the workspace before changing anything.

---

## Part A — Recover the deployment state

The handoff says the intended active release is **2026.09.24**.

1. Determine whether `releases/current` currently resolves to a usable release.
2. Correct the deployment so `releases/current` is a **relative symbolic link** to the intended release.
3. Do not delete the previous release.

The handoff also says the current `config/portal.conf` should be replaced with the known-good production copy stored in:

```text
backups/config.tar.gz
```

Before restoring it, inspect the archive contents without extracting them. Restore the archived configuration and make the live `config/portal.conf` match the archived production copy.

Keep the backup archive intact.

---

## Part B — Correct filesystem permissions

The briefing describes three required states:

- `files/healthcheck.sh` must be directly executable by its **owner**
- `files/deploy.key` must be readable and writable by the **owner only**
- `files/shared-drop/` is intentionally writable by everyone, but users must not be able to remove or rename files belonging to other users merely because the directory is shared

Inspect the existing modes first, then make only the necessary permission changes.

Do not change file ownership.

---

## Part C — Build the incident packet

Create all output files under:

```text
results/
```

### 1. Operational error inventory

Search **recursively** through all files under `logs/` for lines containing `error`, regardless of capitalization.

Exclude lines marked `DEBUG`.

Include the source filename and original line number for every retained match. Work from the capstone workspace root so the recorded filenames begin with `logs/`, not an absolute path or `./logs/`.

Sort the completed lines alphabetically and save them as:

```text
results/errors.txt
```

### 2. Timeout total

Determine the total number of lines under `logs/`, including archived subdirectories, that contain `timeout` regardless of capitalization.

Save **only the number** as:

```text
results/timeouts.txt
```

### 3. Active support usernames

The file:

```text
data/users.csv
```

uses this field order:

```text
username,department,status,email
```

Create a sorted list containing only usernames whose department is `support` and whose status is `active`.

Save it as:

```text
results/support.txt
```

### 4. Slowest response times

The file:

```text
data/latency.txt
```

contains one response time per line.

Create a report containing the **three largest numeric values**, from largest to smallest:

```text
results/slowest.txt
```

---

## Part D — Inspect the host and reconstruct the command map

Use the host Linux system for a short read-only inspection. Determine how you would inspect:

- a process snapshot
- a live process view
- memory usage
- kernel messages
- interface addresses
- the routing table/default gateway
- a basic DNS lookup
- sockets
- the local static hostname-mapping file
- the resolver/DNS configuration file
- currently logged-in users
- what logged-in users are doing
- recent login history

You may actually run the appropriate commands while checking the system.

Then create:

```text
results/tool-map.txt
```

with exactly these keys, filling in the command or command form that belongs after each equals sign:

```text
process-snapshot=
process-live=
memory=
kernel-messages=
addresses=
routes=
dns=
sockets=
hosts-file=
resolver-file=
current-users=
user-activity=
login-history=
```

Use the full modern Linux command forms emphasized in the Core labs where a modern/legacy distinction exists; do not substitute shorthand forms in this map.

Also save your current identity information—the output that includes your UID, GID, and group memberships—as:

```text
results/id.txt
```

Do not modify host accounts, networking, routes, resolver files, or running processes.

---

## Part E — Build the handoff script

Create:

```text
scripts/handoff.sh
```

The script must remain within the Core Lab 5 Bash scope.

It must:

1. use the standard Bash shebang
2. contain at least one useful comment
3. accept an output filename as its first positional argument
4. accept a human-readable label as its second positional argument
5. assign both arguments to named variables
6. overwrite the requested output file with:
   ```text
   Northstar handoff: LABEL
   ```
7. append:
   ```text
   Log checks:
   ```
8. use a basic `for` loop over the top-level `logs/*.log` files
9. for each log:
   - append the log pathname
   - append case-insensitive matches for `error`
   - immediately append that search command's exit status as:
     ```text
     grep-status=STATUS
     ```

Do not hard-code the output path or label.

Make the script executable by its owner and test it **by executing the script directly**, not only by passing it to `bash`.

For your learner-generated test, create:

```text
results/script-report.txt
```

using this label:

```text
deployment handoff
```

---

## Part F — Produce the final handoff summary

After completing and verifying the preceding work, create:

```text
results/handoff.txt
```

containing exactly these five keys with the values you determined:

```text
release=
config-environment=
timeout-count=
active-support-count=
slowest-latency=
```

This is the compact handoff another administrator could use to verify the recovered state.

---

## Check your work

From the repository root:

```bash
bash check.sh 6
```

The checker validates end state, required reports, and the behavior of the Bash script. It does not require one exact troubleshooting sequence.

To rebuild the capstone from the beginning:

```bash
bash reset.sh 6
```

---

## Exact-recall checkpoint

Complete these **after** the practical work, without looking back at prior labs if possible.

1. What is the difference between `grep -r` and `grep -v`?
2. What does `grep -n` add to matching output?
3. Write a pipeline that counts matching lines produced by another command.
4. What do `cut -d` and `cut -f` control?
5. What is the difference between `>`, `>>`, and `2>`?
6. Give the tar mode letters for create, list, and extract.
7. Give the tar compression letters for gzip, bzip2, and xz.
8. Write the general syntax for creating a symbolic link.
9. What does the sticky bit change on a shared writable directory?
10. What is the difference between `who`, `w`, and `last`?
11. What does `su - USER` request that `su USER` does not?
12. Which command shows memory usage? How is that different from `df`?
13. What is the difference between `/proc` and `/sys` at a high level?
14. What modern commands show interface addresses and routes?
15. Which basic DNS lookup command was emphasized for Linux Essentials v1.6?
16. What modern socket-inspection command replaces much legacy `netstat` usage?
17. What command displays kernel messages, and which files hold local hostname mappings and resolver configuration?
18. What legacy Linux interface command is associated with `ip addr show`, and why is Windows `ipconfig` not the answer?
19. Write the standard Bash shebang.
20. State the ordinary shell-variable naming rules.
21. What do `$1`, `$2`, and `$?` represent?
22. Why can `bash script.sh` work when `./script.sh` fails with a permission error?
23. Write a basic `for ... do ... done` loop from memory.
24. What exit status conventionally means success?

## Completion point

Finishing this lab completes the **hands-on Core lab sequence**.

The remaining Core component is the Knowledge Review, which covers Linux Essentials objectives that are better suited to recognition and recall than to a constructed terminal scenario.
