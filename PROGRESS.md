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

**Completed:**

**Permission syntax that felt automatic:**

-

**Permission syntax I had to look up or ask about:**

-

**Was `who` versus `w` versus `last` automatic?**

-

**Was `id` versus `whoami` automatic?**

-

**Account-file mapping (`passwd` / `shadow` / `group`) that caused hesitation:**

-

**Sticky-bit or `/tmp` versus `/var/tmp` questions:**

-

**Anything I want repeated in a later lab:**

-
