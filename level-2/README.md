# Level 2 — Practical Linux

This track extends the repository beyond the Linux Essentials 010-160 core into practical Linux administration.

**Level 2 is a repository difficulty label. It does not mean LPI Linux Essentials version 2.0.**

The Core track remains the defined certification-prep sequence. Level 2 is optional and can continue expanding without changing whether the Core track is complete.

## Current status

| Module | Status | Focus |
|---|---|---|
| 01 — Command Discovery | Planned | finding commands, documentation, help, environment and command lookup |
| 02 — Text & File Tools | Planned | deeper file discovery and text-processing tools |
| 03 — Practical Bash Administration | **Built** | conditionals, tests, loops, functions, argument handling, meaningful exit codes |
| 04 — Package Management | Planned | practical Debian-family package and repository work, with cross-family recognition |
| 05 — Services & Logging | Planned | service inspection/control, processes, and modern system logs |
| 06 — SSH | Planned | remote administration, file transfer, and key-based authentication |
| 07 — Storage | Candidate | disks, filesystems, usage, mounting, and persistent mount concepts |
| 08 — Administration | Candidate | deeper user, group, permission, and administrative workflows |

"Planned" means the topic has a place in the curriculum but has not yet been built. "Candidate" means it is useful material that may be reorganized before implementation.

## Built module

### 03 — Practical Bash Administration

Path:

```text
level-2/03-bash/
```

Start it from the repository root with:

```bash
bash setup.sh l2-3
```

Then read:

```text
level-2/03-bash/PRE_READING.md
level-2/03-bash/INSTRUCTIONS.md
```

Check completed work with:

```bash
bash check.sh l2-3
```

Reset only this module with:

```bash
bash reset.sh l2-3
```

## Scope markers

Level 2 may include several kinds of material:

- content that was deliberately deprioritized from the 010-160 core
- material from newer Linux Essentials objectives
- highly practical Linux administration skills
- selected topics that begin bridging toward more advanced Linux study

Each module should state its own scope clearly. Material appearing in Level 2 should not be assumed to be required for the Linux Essentials 010-160 exam.

## Design rules

Level 2 keeps the same lab model as the Core track:

```text
PRE_READING.md
        ↓
INSTRUCTIONS.md
        ↓
generated work/
        ↓
check.sh
        ↓
exact-recall / reflection
```

Labs should remain scenario-based, non-destructive where possible, and explicit about which work is performed against generated fixtures versus the host Linux system.
