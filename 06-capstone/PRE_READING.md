# Core Lab 6 Pre-Reading — Capstone Strategy

This capstone does **not** introduce new Linux Essentials syntax. It is the practical endpoint of the Core track.

The purpose is different from Labs 1–5: earlier labs usually told you what class of tool to practice. Here, the scenario describes a system state and an expected outcome. You choose the commands.

## What this capstone measures

You should be able to move among several kinds of work without being told exactly which utility to use:

- inspect text and logs
- combine filters and redirection
- work with archives and restore files safely
- interpret and repair symbolic links
- correct ordinary permissions and shared-directory permissions
- extract and summarize delimited data
- inspect or recall basic system, network, and session tools
- write and directly execute a small Bash script using the Core Lab 5 constructs

The capstone is therefore a **transfer exercise** rather than another tutorial.

## Working method

Use the same general troubleshooting cycle throughout:

1. **Inspect** the current state before changing it.
2. **Compare** that state with the handoff requirements.
3. **Choose** a tool from the Core labs.
4. **Make the smallest necessary change.**
5. **Verify** the result independently.
6. **Record** the required evidence under `results/`.

Avoid changing unrelated files just because they look unusual.

## Scope

Everything required here is drawn from Core Labs 1–5 and Linux Essentials 010-160 material already practiced in this repository.

You do **not** need post-Core Bash constructs such as:

```text
if / elif / else
while
case
functions
arithmetic expansion
advanced argument handling
```

If you already know broader Linux techniques, you may use them, but the capstone is designed to be solvable without them.

## Workspace rule

Work only inside the generated `06-capstone/work/` directory unless a task explicitly asks you to inspect the host Linux system.

The tracked `source/` directory and `check.sh` contain setup/checking material. Do not use them as an answer key while solving the capstone.

## Before you start

The capstone intentionally contains several independent symptoms. Do not assume the first problem you notice explains every other problem.

When you are ready, continue to `INSTRUCTIONS.md`.
