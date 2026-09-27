# Linux Essentials Labs

Hands-on practice labs for **LPI Linux Essentials 010-160**.

Created by **OpenAI GPT-5.6 Sol** with prompting & testing by **Lynne Cohen**, lynnecohen.com.

***This repo is still a work in progress. Expect further changes until this line is updated.***

## Getting a Linux system

These labs need a persistent Linux environment with Bash and standard command-line utilities. A dedicated physical server is **not** required.

### Recommended distribution: Debian

**Debian Stable is the recommended environment** because these labs were developed and tested against Debian and use the GNU/Bash command-line behavior, filesystem layout, and networking tools commonly found there. Debian also maps cleanly to the Debian-family package-management concepts covered by Linux Essentials.

Ubuntu and other Debian-derived distributions should usually work with little or no adjustment. Other mainstream Linux distributions will support most of the commands, but package names, default utilities, service configuration, filesystem contents, and command output can differ.

The labs intentionally avoid depending on a large software stack. The setup scripts check for required commands and report anything missing rather than silently installing packages.

### Low-cost, low-barrier options

| Option | Cost | Barrier | Notes |
|---|---:|---|---|
| **Debian virtual machine on an existing computer** | Free | Low | Best general-purpose option. Install Debian in a free hypervisor such as VirtualBox on supported systems or UTM on macOS. The VM is isolated, persistent, and behaves like a normal Linux machine. |
| **WSL 2 on Windows with Debian** | Free | Very low | Fastest option for many Windows users. Most labs work normally, although process, login-session, kernel, and networking output can look different because Linux is running under WSL rather than as a conventional standalone system. |
| **Spare or older computer running Debian** | Free if hardware is available | Medium | Provides the most traditional Linux experience. A minimal Debian installation is sufficient; a desktop environment is optional. |
| **Small Debian cloud VM** | Usually low-cost; provider pricing varies | Low–medium | Useful when no suitable local machine is available or when SSH/server practice is desired. A very small instance is sufficient for these labs. Remember to shut down or delete billable resources when they are no longer needed. |
| **ChromeOS Linux development environment** | Free on supported Chromebooks | Low | Can provide a usable Debian-based terminal environment, although some system-level behavior may differ from a full standalone Debian installation. |

For a learner who wants the **closest match to the lab environment with no ongoing hosting cost**, a small local Debian virtual machine is the safest default recommendation.

A web-based disposable terminal such as WebTerm Free Play can be useful for isolated command practice, but it should be treated as a supplement rather than the primary lab system. Browser sandboxes may omit system files, utilities, persistent storage, networking behavior, or account/session features used by the full labs.

### Hardware requirements

The labs themselves are lightweight. A minimal command-line Debian installation with roughly **1–2 GB of RAM and several GB of free disk space** is more than sufficient. More resources may make a graphical desktop or VM feel smoother, but they are not required by the exercises.

## Clone the repository

The repository is public, so the lowest-barrier method is HTTPS cloning. First confirm that Git is installed:

```bash
git --version
```

If Git is missing on Debian or Ubuntu, install it with:

```bash
sudo apt update
sudo apt install git
```

A convenient place to keep the labs is a `labs` directory under the current user's home directory:

```bash
cd ~
mkdir -p labs
cd labs
git clone https://github.com/lynnecohen/linux-essentials-labs.git
cd linux-essentials-labs
```

Because the repository is public, HTTPS cloning does not require a GitHub account.

If SSH authentication with GitHub is already configured, the SSH form can be used instead:

```bash
git clone git@github.com:lynnecohen/linux-essentials-labs.git
```

After the initial clone, retrieve later updates from inside the repository with:

```bash
git pull
```

The generated `work/` directories used by the labs are ignored by Git, so normal lab activity should not interfere with pulling repository updates.

## Quick start

From the repository root, set up **only the lab you are about to work on**:

```bash
bash setup.sh LAB_NUMBER
```

Replace `LAB_NUMBER` with the number of the lab you want to run. For example, to set up Lab 3:

```bash
bash setup.sh 3
```

Valid built lab numbers are currently `1`, `2`, `3`, `4`, `5`, and optional Lab `7`. You do **not** need to run the setup command once for every lab.

Current built labs:

```text
01-incident/           Lab 1 — Production Incident Investigation
02-backup-deployment/ Lab 2 — Backup, Restore & Deployment
03-users-permissions/ Lab 3 — Users, Sessions & Permissions
04-system-network/    Lab 4 — System & Network Inspection
05-scripting/         Lab 5 — Bash Automation
07-advanced-scripting/ Optional Lab 7 — Practical Bash Administration
```

Each built lab contains a `READING.md` pre-reading and a `README.md` practical exercise.

When you finish the scored tasks for a lab, run **one checker command for that lab only** from the repository root:

```bash
bash check.sh LAB_NUMBER
```

For example, to check Lab 4:

```bash
bash check.sh 4
```

Replace `LAB_NUMBER` with the lab you just completed. Do **not** run the checker once for every lab unless you intentionally want to check them all.

To rebuild **one lab** from scratch:

```bash
bash reset.sh LAB_NUMBER
```

For example, to reset Lab 2:

```bash
bash reset.sh 2
```

Replace `LAB_NUMBER` with the lab you want to reset. This deletes and recreates that lab's generated `work/` directory, so run it only for the lab you intend to restart.

## Study strategy

This repository is intentionally optimized for high-ROI exam preparation rather than exhaustive Linux administration. Basic navigation and file-management skills are assumed; labs concentrate on commands, flags, and distinctions that still need deliberate practice.

The working sequence is:

1. **Production Incident Investigation** — text processing, pipes, redirection, quoting, glob/regex distinctions
2. **Backup, Restore & Deployment** — tar/compression and symbolic links
3. **Users, Sessions & Permissions** — permissions, ownership, sessions, account files, sticky bit
4. **System & Network Inspection** — processes, memory, Linux system paths, IP/routing/DNS/socket inspection
5. **Bash Automation** — Linux Essentials v1.6 scripting core
6. **Capstone** — independent troubleshooting across the prior labs

### Optional post-core lab

**Optional Lab 7 — Practical Bash Administration** goes beyond the Linux Essentials v1.6 exam scope and introduces scripting constructs commonly encountered in practical Linux administration, including conditionals, tests, `while`, `case`, functions, command substitution, arithmetic expansion, interactive prompts, richer positional-argument handling, and explicit exit statuses.

It is numbered after the capstone so that Labs 1–6 remain the required exam-prep sequence. It can be completed after Lab 5 or after the capstone.

## Scope rule

Required Labs 1–6 are gated to **Linux Essentials v1.6 / 010-160** scope, with a small amount of instructor-emphasized syntax reinforcement where it has high exam value. Optional Lab 7 is explicitly outside that exam scope and is intended as practical post-core Bash practice. Other useful but lower-ROI Linux administration topics belong in the post-exam `learn-later/` track rather than the required exam labs.

## Repository workflow

Labs are built incrementally. After each lab, later labs may be adjusted based on what becomes fluent and what still needs repetition. The capstone remains intentionally unrevealed until the prerequisite labs are complete.

Use `PROGRESS.md` as a lightweight checkpoint after a lab so later exercises can be tuned around what was automatic versus what still required recall support.

## Safety

Exercises that touch the host Linux system should be read-only or deliberately isolated. Destructive or configuration-changing tasks belong inside the generated lab workspace, not the host system.
