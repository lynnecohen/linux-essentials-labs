# Linux Essentials Labs

Hands-on Linux learning with a defined **LPI Linux Essentials 010-160 Core track** and an optional **Level 2 practical Linux track**.

Created by **OpenAI GPT-5.6 Sol** with prompting & testing by **Lynne Cohen**, lynnecohen.com.

## Project status

This repository has two separate completion tracks:

- **Core — Linux Essentials 010-160:** In development. Core Labs 1–5 are built. The Core Capstone and Knowledge Review are the remaining planned pieces before the Core track is considered complete.
- **Level 2 — Practical Linux:** Expanding. This optional track continues beyond the certification core and can grow independently after the Core track is complete.

Level 2 is a repository difficulty label. It does **not** mean LPI Linux Essentials version 2.0.

The separation is intentional: future Level 2 additions should not make the completed Core curriculum appear unfinished.

## Repository structure

```text
01-incident/             Core Lab 1 — Production Incident Investigation
02-backup/    Core Lab 2 — Backup, Restore & Deployment
03-permissions/    Core Lab 3 — Users, Sessions & Permissions
04-inspection/       Core Lab 4 — System & Network Inspection
05-scripting/            Core Lab 5 — Bash Automation
06-capstone/             Core Lab 6 — Capstone
review/                  Core knowledge-review material

level-2/
  README.md              Level 2 roadmap and scope
  03-bash/               Level 2 Lab 3 — Practical Bash Administration
```

Only built modules contain full learner materials and working lab infrastructure. Planned Level 2 modules are documented in `level-2/README.md` rather than represented by placeholder directories.

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
bash setup.sh LAB_ID
```

For Core labs, use the lab number. For example:

```bash
bash setup.sh 3
```

Currently built Core lab IDs are:

```text
1
2
3
4
5
```

The Core Capstone will use ID `6` after it is built.

Level 2 uses an explicit track prefix so its numbering cannot be confused with the Core sequence. The currently built Level 2 module is:

```bash
bash setup.sh l2-3
```

Each built lab uses clearly separated learner materials:

```text
PRE_READING.md    concept preparation
INSTRUCTIONS.md   hands-on exercise
```

When you finish a lab, run the checker for **that lab only**:

```bash
bash check.sh LAB_ID
```

Examples:

```bash
bash check.sh 4
bash check.sh l2-3
```

To rebuild one generated workspace from scratch:

```bash
bash reset.sh LAB_ID
```

To remove one generated workspace:

```bash
bash cleanup.sh LAB_ID
```

## Core track — Linux Essentials 010-160

The Core track is optimized for high-ROI Linux Essentials preparation rather than exhaustive Linux administration. Basic navigation and file-management skills are assumed; labs concentrate on commands, flags, and distinctions that benefit from deliberate practice.

The sequence is:

1. **Production Incident Investigation** — text processing, pipes, redirection, quoting, glob/regex distinctions
2. **Backup, Restore & Deployment** — tar/compression and symbolic links
3. **Users, Sessions & Permissions** — permissions, ownership, sessions, account files, sticky bit
4. **System & Network Inspection** — processes, memory, Linux system paths, IP/routing/DNS/socket inspection
5. **Bash Automation** — Linux Essentials v1.6 scripting core
6. **Capstone** — independent diagnosis, tool selection, remediation, and verification across prior labs
7. **Knowledge Review** — non-lab objectives and recognition material that do not justify a full terminal scenario

The Capstone is the practical endpoint. The Knowledge Review closes remaining objective coverage that is better tested by recognition and recall than by artificial hands-on exercises.

## Level 2 — Practical Linux

The optional `level-2/` track extends the Core curriculum into practical Linux administration.

Its modules may include material that was deliberately excluded from the 010-160 Core because it was lower priority for that exam, material from newer objectives, and practical administration skills that are valuable beyond Linux Essentials.

The first built Level 2 module is:

```text
level-2/03-bash/    Practical Bash Administration
```

Its topics include conditionals, tests, `while`, `case`, functions, command substitution, arithmetic expansion, interactive prompts, richer positional-argument handling, and meaningful exit statuses.

See `level-2/README.md` for the Level 2 roadmap.

## Scope rule

Core Labs 1–6 and the Core Knowledge Review are gated to **Linux Essentials v1.6 / 010-160** scope, with limited high-value reinforcement where needed for the current course.

Level 2 is deliberately broader. Every Level 2 module should identify its own scope rather than implying that all of its content is required for 010-160.

## Repository workflow

The Core track has a defined finish line. Once Core Lab 6 and the Core Knowledge Review are complete and tested, the Core track can be marked complete and released even if Level 2 continues to expand.

Level 2 is therefore additive rather than a blocker for a stable Core release.

Use `PROGRESS.md` as a lightweight checkpoint after a lab so later exercises can be tuned around what was automatic versus what still required recall support.

## Safety

Exercises that touch the host Linux system should be read-only or deliberately isolated. Destructive or configuration-changing tasks belong inside the generated lab workspace, not the host system.
