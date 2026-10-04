# Level B — Practical Linux

Level B extends the completed Linux Essentials 010-160 Core curriculum into broader practical Linux administration.

**Level B is a repository learning tier. It is not a reference to LPI Linux Essentials version 2.0.**

The Core track remains the stable certification-prep sequence. Level B is optional and can continue expanding without changing Core completion.

## Curriculum plan

| Module | Status | Focus |
|---|---:|---|
| **B1 — Command Discovery & Self-Service Troubleshooting** | Planned | documentation and help systems, shell history, command resolution, environment/PATH, locating commands, and independent troubleshooting workflow |
| **B2 — File Discovery, Advanced Text Processing & I/O** | Planned | `find`; advanced `grep`; `cut`, `sort`, `uniq`, `wc`; pipelines; stdout/stderr; file descriptors; advanced redirection; practical text-processing extensions |
| **B3 — Practical Bash Administration** | **Built** | conditionals, tests, loops, functions, parsing, argument handling, command substitution, arithmetic, exit codes |
| **B4 — Package Management** | Planned | practical Debian-family package/repository work with recognition of other major package ecosystems |
| **B5 — Services & Logging** | Planned | service inspection/control, processes, systemd concepts, `journalctl`, `dmesg`, and modern system logs |
| **B6 — Network Troubleshooting & Service Exposure** | Planned | hostname/address/route/link inspection, DNS resolution, reachability, local resolver files, listening sockets, and service exposure |
| **B7 — SSH & Remote Administration** | Planned | SSH, SCP, key pairs, authentication, remote command execution, host identity, and remote administration workflow |
| **B8 — Storage & Filesystems** | Planned | disk/filesystem usage, block devices, `/proc`/`/sys`/`/dev`, filesystems, mounting, and persistent mount concepts |
| **B9 — Advanced Users, Groups & Permissions** | Planned | account creation, supplementary groups, `umask`, SUID/SGID/sticky bit, ownership, sudoers safety, and service accounts |
| **B10 — Practical Linux Troubleshooting Capstone** | Planned | independent diagnosis and remediation integrating the Level B command, Bash, package, service, network, SSH, storage, and permissions skills |

The sequence is intentional:

```text
B1   discover commands and documentation independently
 ↓
B2   find files, manipulate text, and control I/O precisely
 ↓
B3   automate richer administration workflows with Bash
 ↓
B4   manage software
 ↓
B5   inspect and manage services/logs
 ↓
B6   troubleshoot addressing, routing, DNS, and service exposure
 ↓
B7   administer systems remotely
 ↓
B8   inspect and manage storage/filesystem behavior
 ↓
B9   perform deeper account, group, and permission administration
 ↓
B10  troubleshoot independently across the full Level B skill set
```

"Planned" means the module has a defined place in the curriculum but has not yet been built.

## Level B Knowledge Review

Level B should also include an unnumbered knowledge-review component for useful concepts that do not justify artificial terminal exercises. Likely material includes:

- GPL, MIT, LGPL, AGPL, OSI, and related open-source ecosystem distinctions
- Debian-family versus RPM-family recognition
- LibreOffice application mapping
- DNS record-type recognition
- other conceptual or recognition-level material encountered in the supporting practice tests

This review should complement the labs rather than inflate them with low-value command drills.

## Curriculum design rules

Level B assumes the learner already understands basic navigation, ordinary file manipulation, basic permissions, simple redirection, and common shell commands.

The advanced tier should develop:

1. **Exact command and flag fluency.**
2. **Choosing the right command in a realistic troubleshooting situation.**
3. **Understanding observable Linux behavior**, not merely recognizing command names.

A typical module should target roughly **30–45 minutes of primary work**, with optional stretch exercises kept separate.

Where practical, each module should contain:

- a short pre-lab reading/reference section
- a realistic problem or administrative objective
- tasks that require choosing commands rather than copying them
- one or two deliberate Linux gotchas
- a short exact-syntax recall check
- optional stretch material
- automated setup/reset/check scripts

The defining Level B pattern is:

> **Known command + less-familiar flag + realistic decision + observable consequence.**

Reading can cover broadly tested concepts, but hands-on work should concentrate on skills where interaction materially improves retention.

### Practice priority

Use three tiers when deciding what belongs in hands-on work:

- **Tier 1 — must perform hands-on:** command selection, pipelines, advanced redirection, networking, Bash control flow, ownership/groups, special permissions, `umask`, exact path/command selection, and similar high-value operational skills.
- **Tier 2 — expose through short tasks:** useful but narrower commands or behaviors that benefit from seeing them once or twice.
- **Tier 3 — reading/recognition:** licensing, ecosystem distinctions, application-name mapping, and other material where terminal exercises would be artificial.

Avoid duplicating complete Core labs merely because Level B revisits a command. Reuse Core knowledge in a more demanding context instead.

For example, archive handling should be reinforced incidentally when a realistic task calls for it rather than receiving another dedicated `tar` lab.

## Built module

### B3 — Practical Bash Administration

Path:

```text
level-b/03-bash/
```

Set up the lab from the repository root:

```bash
bash setup.sh b3
```

Then read:

```text
level-b/03-bash/PRE_READING.md
level-b/03-bash/INSTRUCTIONS.md
```

Check completed work with:

```bash
bash check.sh b3
```

Reset only this module with:

```bash
bash reset.sh b3
```

Remove its generated workspace with:

```bash
bash cleanup.sh b3
```

## Scope markers

Level B may include several kinds of material:

- content deliberately excluded from the 010-160 Core because it was lower priority for that exam
- material introduced by newer Linux Essentials objectives
- highly practical Linux administration skills
- selected topics that begin bridging toward LPIC-1 or junior Linux administration

Individual Level B modules should state their scope clearly. Content appearing in Level B should not be assumed to be required for Linux Essentials 010-160.

## Lab model

Level B keeps the same learner workflow as the Core track:

```text
PRE_READING.md
        ↓
INSTRUCTIONS.md
        ↓
generated work/
        ↓
check.sh
        ↓
exact-recall checkpoint
        ↓
ANSWERS.md / reflection
```

Labs should remain scenario-based, non-destructive where possible, and explicit about which work occurs against generated fixtures versus the host Linux system.
