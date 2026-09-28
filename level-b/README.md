# Level B — Practical Linux

Level B extends the completed Linux Essentials 010-160 Core curriculum into broader practical Linux administration.

**Level B is a repository learning tier. It is not a reference to LPI Linux Essentials version 2.0.**

The Core track remains the stable certification-prep sequence. Level B is optional and can continue expanding without changing Core completion.

## Curriculum plan

| Module | Status | Focus |
|---|---:|---|
| **B1 — Command Discovery & Self-Service Troubleshooting** | Planned | documentation, help systems, command resolution, environment/PATH, locating commands and files |
| **B2 — File Discovery & Advanced Text Processing** | Planned | `find`, `grep -E`, `uniq`, and practical text-processing extensions such as `sed` and `awk` |
| **B3 — Practical Bash Administration** | **Built** | conditionals, tests, loops, functions, parsing, argument handling, command substitution, arithmetic, exit codes |
| **B4 — Package Management** | Planned | practical Debian-family package/repository work with recognition of other major package ecosystems |
| **B5 — Services & Logging** | Planned | service inspection/control, processes, systemd concepts, and modern system logs |
| **B6 — SSH & Remote Administration** | Planned | SSH, SCP, key pairs, authentication, and remote administration workflow |
| **B7 — Storage & Filesystems** | Candidate | disks, filesystems, usage, mounting, and persistent mount concepts |
| **B8 — Advanced Users & Permissions** | Candidate | deeper user/group administration, supplementary groups, `umask`, SUID/SGID, and privilege configuration |

The sequence is intentional:

```text
B1  discover commands and documentation independently
 ↓
B2  expand file-finding and text-processing capability
 ↓
B3  automate richer administration workflows with Bash
 ↓
B4  manage software
 ↓
B5  inspect and manage services/logs
 ↓
B6  administer remote systems
 ↓
B7  work with storage/filesystems
 ↓
B8  perform deeper account/permission administration
```

"Planned" means the module has a defined place in the curriculum but has not yet been built. "Candidate" means the topic is useful and logically placed but may be reorganized before implementation.

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
