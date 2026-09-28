# Lab 2 — Backup, Restore & Deployment

## Scenario

The fictional **Northstar Learning Portal** is preparing to deploy release `2026.09.10`. Release `2026.09.03` is currently active, and the `releases/current` symbolic link points to it.

Before changing the active release, you need to create and verify backups, practice restoring them into safe staging directories, compare several Linux compression formats, and then switch the deployment symlink to the new release.

Text-processing skills from Lab 1 may appear incidentally, but this lab deliberately shifts its practice time toward archives, compression, restore workflows, and symbolic links.

## Primary practice targets

- `tar` modes: create (`c`), list (`t`), and extract (`x`)
- `tar -f` and the role of the archive filename
- gzip (`z`), bzip2 (`j`), and xz (`J`) compression with tar
- recognition of verbose mode (`v`)
- archive versus compression as separate concepts
- safe restore workflow and awareness of stored archive paths
- basic standalone compression awareness: gzip/gunzip, bzip2/bunzip2, xz/unxz, zip/unzip
- symbolic links: `ln -s TARGET LINK_NAME`
- relative symlink targets and link-versus-target behavior

## Before you begin — pre-reading

Read **[Lab 2 Pre-Reading — Archives, Compression, Restore, and Symbolic Links](PRE_READING.md)** before starting the practical tasks.

The reading explains the `tar` flag system as a reusable grammar rather than a collection of unrelated commands, with special attention to `c/x/t`, `f`, and the easy-to-confuse `z/j/J` flags. It also explains where extracted files go, why listing an archive before restoring it is useful, and how relative symbolic links are resolved.

## Setup

From the repository root, run:

```bash
bash setup.sh 2
```

Then work from:

```text
02-backup/work/
```

Do not edit files under `02-backup/source/`; `reset.sh` uses those files to rebuild the workspace.

The workspace begins approximately like this:

```text
releases/
  2026.09.03/
    VERSION
    app/
      index.html
      settings.conf
    static/
      motd.txt
  2026.09.10/
    VERSION
    app/
      index.html
      settings.conf
    static/
      motd.txt
  current -> 2026.09.03

config/
  portal.conf
  maintenance.conf

notes/
  deploy.txt

results/
restore/
```

All destructive work in this lab stays inside this generated workspace.

---

## Part A — Inspect the current deployment

These orientation tasks are not scored.

1. Inspect `releases/` in long-listing format and identify which release the `current` symlink points to.
2. Display `releases/current/VERSION` to confirm the version reached through the link.
3. Compare the `VERSION` files for the old and new release.
4. Inspect the directory tree enough to understand what will be included in the release backup.

Do not change the symlink yet.

---

## Part B — Back up and restore the current release with gzip

### 1. Create the pre-deployment backup

Create a **gzip-compressed tar archive** containing the entire directory:

```text
releases/2026.09.03/
```

Save the archive as:

```text
results/2026.09.03.tar.gz
```

Use a relative source path so the archive stores the `releases/2026.09.03/...` structure rather than an absolute filesystem path.

### 2. List the backup without extracting it

List the members of the gzip-compressed archive you just created. Save the ordinary member listing, without verbose metadata, as:

```text
results/2026.09.03.contents.txt
```

Check the listing yourself before continuing. You should be able to account for the version file, application files, and static file.

### 3. Restore the backup into staging

Create this staging directory:

```text
restore/gzip/
```

Change into that directory and extract the gzip-compressed release archive there. Do not extract over the live `releases/` directory.

When finished, the restored version file should be reachable at:

```text
restore/gzip/releases/2026.09.03/VERSION
```

Inspect at least one restored application file and confirm that the restored version is `2026.09.03`.

---

## Part C — Practice the other tar compression flags

The goal here is exact discrimination between lowercase `j` and uppercase `J`.

### 4. Back up configuration with bzip2

Create a **bzip2-compressed tar archive** containing the entire `config/` directory.

Save it as:

```text
results/config-backup.tar.bz2
```

### 5. Restore the bzip2 configuration backup

Create:

```text
restore/bzip2/
```

Change into that directory and extract `results/config-backup.tar.bz2` there.

After extraction, both configuration files should exist under:

```text
restore/bzip2/config/
```

### 6. Archive the deployment notes with xz

Create an **xz-compressed tar archive** containing the `notes/` directory.

Save it as:

```text
results/deployment-notes.tar.xz
```

Then list that archive without extracting it and save the ordinary member listing as:

```text
results/deployment-notes-xz.contents.txt
```

This task is intentionally similar to the earlier gzip task but changes the compression flag.

---

## Part D — Separate archiving from compression

### 7. Create a plain tar archive

Create an **uncompressed tar archive** containing the `notes/` directory.

Save it as:

```text
results/deployment-notes.tar
```

Do not apply gzip, bzip2, or xz compression to this archive.

Compare its filename and purpose with `results/deployment-notes.tar.xz`. The key distinction is conceptual: both are tar archives, but only one is compressed with xz.

### 8. Observe standalone gzip behavior — unscored

Make a disposable copy of `notes/deploy.txt` somewhere under `restore/`. Compress that copy using the standalone gzip utility, observe what happens to the original copied filename, and then decompress it again with the corresponding decompression utility.

This task is not checked. Its purpose is simply to connect the `z` in tar with the standalone gzip/gunzip utilities.

If `zip` and `unzip` are installed on your Linux system, you may also create and extract a small ZIP archive as optional practice. Do not install additional software solely for this optional step.

---

## Part E — Switch the deployed release

### 9. Update `current`

The existing link is:

```text
releases/current -> 2026.09.03
```

Remove **the symbolic link only**. Do not remove either release directory.

Then create a new **relative symbolic link** named:

```text
releases/current
```

that points to its sibling directory:

```text
2026.09.10
```

The target stored in the link should be the relative name `2026.09.10`, not an absolute path to the repository.

Afterward:

1. inspect the link with a long listing;
2. display `releases/current/VERSION`;
3. confirm it now reaches version `2026.09.10`;
4. confirm that the old `2026.09.03` directory still exists.

This models a simple versioned deployment in which switching a symlink changes which release is considered current without deleting the rollback copy.

---

## Check your work

From the repository root:

```bash
bash check.sh 2
```

The checker validates the archive formats and required contents, restored directory trees, saved archive listings, and final symbolic-link state. It validates outcomes rather than requiring one exact command spelling.

If you want to start over:

```bash
bash reset.sh 2
```

---

## Exact-recall checkpoint

Do this **after** the practical tasks, without using the reading if possible.

1. Write the command that creates a gzip-compressed tar archive named `backup.tar.gz` from a directory named `website/`.
2. Write the command that lists the contents of `backup.tar.gz` without extracting it.
3. Write the command that extracts `backup.tar.gz` into the current directory.
4. State what each of these tar flags means: `c`, `x`, `t`, `f`, `z`, `j`, `J`, `v`.
5. Which tar compression flag corresponds to bzip2? Which corresponds to xz?
6. Explain the role of `-f` and which argument is the archive filename in `tar -czf archive.tar.gz project/`.
7. Explain the difference between a `.tar` archive and a `.tar.gz` archive.
8. What standalone commands would you associate with compressing/decompressing `.gz` files? What commands create/extract `.zip` archives?
9. Write the general syntax for creating a symbolic link named `current` that points to `release-2`.
10. If `current -> release-2` is a relative symbolic link located inside `releases/`, explain what directory the relative target is resolved from and what happens to `release-2` if only the `current` link is deleted.

After attempting all ten questions from memory, compare your responses with **[Lab 2 Exact-Recall Answer Key](ANSWERS.md)**.

## Stop point

Before moving to Lab 3, note any tar flags, compression formats, or symbolic-link concepts that still required a lookup. Revisit only those items, then continue with the next Core lab.
