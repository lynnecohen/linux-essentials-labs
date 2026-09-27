# Lab Progress Notes

Use this as a lightweight checkpoint after each lab. The purpose is to tune later labs, not to create a detailed study journal.

## Lab 1 — Production Incident Investigation

**Completed:** Yes

**Commands/flags that felt automatic by the exact-recall checkpoint:**

- `wc -l`
- `tail -n`
- `grep -i`, `grep -n`, `grep -c`, `grep -v`, `grep -r`
- `cut -d` / `cut -f`
- `>` versus `>>`
- `2>`
- pipelines

**Items clarified during the lab:**

- interactive searching inside `less`, including `/pattern`, `n`, `N`, and case-insensitive search
- shell globs versus grep/less regular-expression patterns
- filtering CSV rows with `grep` before extracting fields with `cut`
- lexical versus numeric sorting
- `wc -c` counts bytes rather than characters

**Exact-recall errors:** None in the submitted checkpoint.

**Plan adjustment:** Treat Lab 1 text-processing targets as retained skills. Reuse them incidentally later, but do not spend dedicated lab time reteaching them unless later performance shows regression.

---

## Lab 2 — Backup, Restore & Deployment

**Completed:** Yes

**Tar combinations that were recalled correctly:**

- `tar -czf` — create gzip-compressed tar archive
- `tar -tzf` — list gzip-compressed tar archive
- `tar -xzf` — extract gzip-compressed tar archive
- `c`, `x`, and `t` mode distinctions
- `f` as the archive-filename indicator
- `z` = gzip, `j` = bzip2, `J` = xz
- `v` = verbose
- plain `.tar` versus compressed `.tar.gz`

**Symbolic-link concepts retained:**

- `ln -s TARGET LINK_NAME`
- relative targets are resolved relative to the link's containing directory
- deleting a symbolic link does not delete its target

**Items clarified during the lab:**

- verbose tar listings add metadata rather than changing the archive operation
- standalone `gzip` / `gunzip` behavior
- ZIP creation needs both an archive filename and input file(s); `unzip archive.zip` extracts

**Exact-recall result:** All major Lab 2 targets were correct; only ZIP creation syntax needed tightening.

**Plan adjustment:** Treat tar create/list/extract and `z/j/J/f` as retained skills. Reuse archive syntax incidentally later rather than dedicating another lab to it.

---

## Lab 3 — Users, Sessions & Permissions

**Completed:** Yes

**Permission/account targets recalled correctly:**

- numeric mode `640`
- symbolic `chmod u+x`
- symbolic `chmod g-w`
- numeric permission values `r=4`, `w=2`, `x=1`
- interpretation of owner/group/other permission triplets
- `id` versus `whoami`
- `/etc/passwd`, `/etc/shadow`, and `/etc/group`
- `useradd`, `groupadd`, and `passwd`
- `chown OWNER:GROUP FILE`
- `/tmp` versus `/var/tmp`

**Items clarified during/after the checkpoint:**

- sticky bit: on a shared writable directory it restricts deletion/renaming of entries, rather than making file permissions replace directory permissions
- `last`: historical login/session records, not specifically only SSH/command-line logins
- `su USER` versus `su - USER`: the hyphen requests a login shell/environment for the target user
- `sudo COMMAND`: normally runs as root by default, but sudo can be configured to run a command as another authorized user

**Exact-recall result:** Strong overall. No need to repeat ordinary permission arithmetic or account-file mapping as dedicated material.

**Plan adjustment:** Carry sticky-bit semantics, `who`/`w`/`last`, and login-shell distinctions forward only as incidental spaced reinforcement.

---

## Lab 4 — System & Network Inspection

**Completed:** Yes

**System/network targets recalled correctly:**

- `ps` versus `top`
- `free`
- `dmesg`
- `ip addr show`
- `ip route show`
- `inet` versus `inet6`
- `ping -c 4`
- `ss`
- `/etc/hosts`
- `/etc/resolv.conf`
- `free` versus `df`

**Items clarified during/after the checkpoint:**

- `/proc` is broader than processes alone: it exposes process and kernel runtime information
- `/sys` is a structured view of kernel/device information rather than a process directory
- Linux Essentials v1.6 DNS recall target is `host`; `dig` is useful real-world tooling but belongs outside this required track
- legacy Linux `ifconfig` must not be confused with Windows `ipconfig`
- `ip addr show` answers what addresses interfaces have; `ip route show` answers where packets should be sent

**Exact-recall result:** Strong overall. The main missed command association was `host` versus `dig`; the other corrections were precision/naming distinctions.

**Plan adjustment:** Carry `host` versus `dig`, `ifconfig` versus `ipconfig`, and `/proc` versus `/sys` into the capstone as spaced reinforcement. Do not add more dedicated networking study unless later testing shows regression.

---

## Lab 5 — Bash Automation

**Completed:**

**Scripting syntax that felt automatic:**

-

**Syntax I had to look up or ask about:**

-

**Were variable assignment versus expansion automatic?**

-

**Were `$1` / `$2` positional arguments automatic?**

-

**Was the `for ... do ... done` structure automatic?**

-

**Was `$?` and the zero-success convention automatic?**

-

**Was direct execution (`chmod u+x` + `./script`) automatic?**

-

**Anything I want repeated in the capstone:**

-
