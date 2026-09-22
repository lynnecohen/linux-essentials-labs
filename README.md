# Linux Essentials Labs

Hands-on practice environment for **LPI Linux Essentials 010-160 / WGU D281**.

## Quick start

Clone the repository to the Debian server, then from the repository root set up the lab you want:

```bash
bash setup.sh 1
bash setup.sh 2
bash setup.sh 3
```

Current built labs:

```text
01-incident/           Lab 1 — Production Incident Investigation
02-backup-deployment/ Lab 2 — Backup, Restore & Deployment
03-users-permissions/ Lab 3 — Users, Sessions & Permissions
```

Each built lab contains a `READING.md` pre-reading and a `README.md` practical exercise.

When you finish the scored tasks, run the checker from the repository root:

```bash
bash check.sh 1
bash check.sh 2
bash check.sh 3
```

To rebuild a lab from scratch:

```bash
bash reset.sh 1
bash reset.sh 2
bash reset.sh 3
```

## Study strategy

This repository is intentionally optimized for high-ROI exam preparation rather than exhaustive Linux administration. Basic navigation and file-management skills are assumed; labs concentrate on commands, flags, and distinctions that still need deliberate practice.

The working sequence is:

1. **Production Incident Investigation** — text processing, pipes, redirection, quoting, glob/regex distinctions
2. **Backup, Restore & Deployment** — tar/compression and symbolic links
3. **Users, Sessions & Permissions** — permissions, ownership, sessions, account files, sticky bit
4. **System & Network Inspection** — processes, memory, Linux system paths, IP/routing/DNS/socket inspection
5. **Bash Automation** — Linux Essentials v1.6 scripting core
6. **Capstone** — independent troubleshooting across the prior labs

## Scope rule

Required lab work is gated to **Linux Essentials v1.6 / 010-160** scope, with a small amount of instructor-emphasized syntax reinforcement where it has high exam value. Useful but lower-ROI Linux administration topics belong in the post-WGU `learn-later/` track rather than the required exam labs.

## Repository workflow

Labs are built incrementally. After each lab, later labs may be adjusted based on what becomes fluent and what still needs repetition. The capstone remains intentionally unrevealed until the prerequisite labs are complete.

Use `PROGRESS.md` as a lightweight checkpoint after a lab so later exercises can be tuned around what was automatic versus what still required recall support.

## Safety

Exercises that touch the real Debian server should be read-only or deliberately isolated. Destructive or configuration-changing tasks belong inside the lab workspace, not the production server environment.
