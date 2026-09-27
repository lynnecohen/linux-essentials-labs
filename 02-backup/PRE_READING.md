# Lab 2 Pre-Reading — Archives, Compression, Restore, and Symbolic Links

Read this before starting **Lab 2 — Backup, Restore & Deployment**. This reading concentrates on `tar` modes, compression flags, archive/restore workflow, and symbolic-link behavior. Text-processing skills from Lab 1 may appear incidentally, but they are not the main focus here.

The core mental model is:

```text
tar      collect files/directories into an archive
-c       create an archive
-t       list an archive's contents
-x       extract an archive
-f       use the next argument as the archive filename
-v       verbose: show member names while working
-z       gzip compression
-j       bzip2 compression
-J       xz compression

ln -s TARGET LINK_NAME
         create a symbolic link
```

---

## 1. Archive and compression are not the same thing

This distinction makes the `tar` flags much easier to remember.

An **archive** combines multiple files and directories into one logical file. A plain tar archive might be named:

```text
backup.tar
```

A plain `.tar` file is an archive, but it is not necessarily compressed.

**Compression** reduces the amount of storage required. Common Linux compression formats include:

```text
gzip    .gz
bzip2   .bz2
xz      .xz
```

That is why names such as these have two meaningful suffixes:

```text
backup.tar.gz
backup.tar.bz2
backup.tar.xz
```

Read them from right to left:

```text
backup.tar.gz
       ^^^ compressed with gzip
   ^^^     the compressed object is a tar archive
```

Conceptually, `tar` first bundles the directory tree and a compressor then compresses that archive. GNU `tar` lets you request both operations in one command.

A `.zip` file is somewhat different: the `zip` format handles both archiving and compression itself, so you do not normally create a tar archive first.

---

## 2. The three primary `tar` modes: create, list, extract

For Linux Essentials, keep three mutually exclusive operations straight:

```text
-c    create
-t    list/table of contents
-x    extract
```

Think of them as the verb in the command. You normally choose **one** of these for a particular `tar` operation.

### Create

```bash
tar -cf backup.tar project/
```

This creates an uncompressed archive called `backup.tar` containing `project/`.

### List

```bash
tar -tf backup.tar
```

This displays the archive members without extracting them.

Listing an unfamiliar archive before extracting it is a good operational habit because it lets you see what paths the archive will create.

### Extract

```bash
tar -xf backup.tar
```

This extracts the archive into the **current working directory** by default.

So the simplest mental cycle is:

```text
-c    pack it
-t    inspect it
-x    unpack it
```

The filename option `-f` appears in all three because each operation needs to know which archive file you are working with.

---

## 3. Why `-f` matters

`-f` means **file**: use an archive file whose name is supplied as an argument.

For example:

```bash
tar -cf backup.tar project/
```

Break that apart as:

```text
tar
-c              create
-f backup.tar   archive filename
project/        item to put inside the archive
```

This distinction is worth making explicit: `tar` does not infer that `backup.tar` is the output filename merely because it looks like one. `-f` tells `tar` that the associated argument is the archive file.

When short options are combined, you commonly see:

```bash
tar -czf backup.tar.gz project/
```

Here:

```text
-c    create
-z    gzip
-f    archive file follows
```

The next argument, `backup.tar.gz`, is therefore the archive filename. The later argument, `project/`, is what goes into the archive.

You may also see traditional `tar` syntax without the leading hyphen:

```bash
tar czf backup.tar.gz project/
```

Both forms are common. For these labs, use the hyphenated form consistently because it makes the options easier to read.

---

## 4. Compression flags: `z`, `j`, and `J`

These are deliberately easy to confuse, so they deserve exact recall.

| Compression | Typical suffix | `tar` flag |
|---|---|---|
| gzip | `.tar.gz` | `-z` |
| bzip2 | `.tar.bz2` | `-j` |
| xz | `.tar.xz` | `-J` |

The uppercase/lowercase distinction matters:

```text
-j    bzip2
-J    xz
```

A useful pattern is to keep the mode and filename flags stable and swap only the compressor:

```bash
tar -czf backup.tar.gz project/
tar -cjf backup.tar.bz2 project/
tar -cJf backup.tar.xz project/
```

Likewise for listing:

```bash
tar -tzf backup.tar.gz
tar -tjf backup.tar.bz2
tar -tJf backup.tar.xz
```

And extracting:

```bash
tar -xzf backup.tar.gz
tar -xjf backup.tar.bz2
tar -xJf backup.tar.xz
```

Notice that the overall grammar barely changes:

```text
MODE + COMPRESSION + f
```

Examples:

```text
czf    create + gzip + archive file
xjf    extract + bzip2 + archive file
tJf    list + xz + archive file
```

That is more reliable than trying to memorize each full combination as an unrelated command.

---

## 5. What `-v` does

`-v` means **verbose**. It causes `tar` to print archive member names while it works.

For example:

```bash
tar -czvf backup.tar.gz project/
```

still creates a gzip-compressed archive, but now filenames are printed during creation.

Likewise:

```bash
tar -xzvf backup.tar.gz
```

prints filenames while extracting.

`-v` changes the amount of information shown to you; it does not change the archive format.

For exam recall:

```text
v = verbose
```

Do not let the presence or absence of `v` distract you from the more important mode and compression flags.

---

## 6. The paths stored inside an archive matter

Suppose your current directory contains:

```text
releases/
  release-1/
    VERSION
    app/
      index.html
```

If you run:

```bash
tar -czf backup.tar.gz releases/release-1/
```

`tar` normally stores names beginning with:

```text
releases/release-1/
```

When you later extract that archive into an empty directory, it recreates that path beneath your **current directory**:

```text
./releases/release-1/
```

This is why listing with `-t` before extracting is useful: it tells you what directory structure will be recreated.

For this lab, stay with relative paths inside the workspace. You do not need advanced `tar` destination or exclusion options.

---

## 7. Extraction happens where you are

With a command such as:

```bash
tar -xzf backup.tar.gz
```

there is no destination argument in the basic syntax. The archive is extracted into your **current working directory**.

Therefore your shell location matters.

A safe restore workflow often looks conceptually like this:

```text
1. make a separate restore/staging directory
2. move into that directory
3. list the archive first
4. extract it there
5. inspect the restored files
```

This reduces the chance of accidentally dropping restored files on top of live ones.

The lab will make you practice this rather than introduce more advanced `tar` flags.

---

## 8. Standalone compression commands

The compression programs can also be used without `tar`.

### gzip

```bash
gzip report.txt
```

normally produces:

```text
report.txt.gz
```

and removes the uncompressed `report.txt` after successful compression.

To reverse it:

```bash
gunzip report.txt.gz
```

### bzip2

```bash
bzip2 report.txt
```

produces `report.txt.bz2`. `bunzip2` reverses it.

### xz

```bash
xz report.txt
```

produces `report.txt.xz`. `unxz` reverses it.

These compressors fundamentally operate on data streams/files. They do not by themselves provide the convenient multi-file directory-tree archive behavior that `tar` does. This is why `tar` plus compression is so common on Linux.

### zip and unzip

A ZIP archive is created with `zip` and extracted with `unzip`:

```text
zip      create/update ZIP archives
unzip    extract ZIP archives
```

For Linux Essentials v1.6 preparation, recognition of `zip`/`unzip` is more important than learning a large set of ZIP options.

---

## 9. File extensions are conventions, not magic

Linux does not fundamentally determine a file's behavior from its extension the way users sometimes expect from graphical operating systems.

The name:

```text
backup.tar.gz
```

is a useful convention telling a human that the file is probably a gzip-compressed tar archive. But simply naming something `.tar.gz` does not gzip-compress it.

This command:

```bash
tar -cf backup.tar.gz project/
```

creates a **plain uncompressed tar archive** despite the misleading `.gz` filename, because no gzip option was requested.

Conversely, compression behavior comes from the command/options, not merely the filename.

GNU `tar` can sometimes auto-detect compression during extraction, but for Linux Essentials preparation you should know the explicit associations:

```text
z → gzip
j → bzip2
J → xz
```

---

## 10. Symbolic links: `ln -s TARGET LINK_NAME`

A symbolic link is a small filesystem object that stores a path to another file or directory.

The syntax to memorize is:

```bash
ln -s TARGET LINK_NAME
```

The order matters:

```text
first argument     where the link points
second argument    the new link you are creating
```

For example, if this directory exists:

```text
releases/release-2/
```

you could create a link called `current` inside `releases/` that points to it.

The important mental model is:

```text
TARGET  ← LINK_NAME
```

`LINK_NAME` is the object you are creating. `TARGET` is what it refers to.

### Inspecting a symlink

`ls -l` makes the relationship visible. You will see something similar to:

```text
current -> release-2
```

The first character in the long listing is `l`, indicating a symbolic link.

### Deleting a symlink

Removing the symlink normally removes **only the link**, not its target.

If:

```text
current -> release-2
```

and you remove `current`, the `release-2` directory still exists.

If you delete the target but leave the link, the symlink becomes **dangling** or **broken** because its stored path no longer resolves to an existing object.

---

## 11. Relative symlinks have an important nuance

Suppose you have:

```text
releases/
  release-1/
  release-2/
  current -> release-1
```

The target text stored in `current` is simply:

```text
release-1
```

Because that is a **relative target**, it is interpreted relative to the directory containing the symlink, not relative to wherever your shell happens to be later.

That makes this structure portable: if the whole `releases/` directory is moved somewhere else, `current -> release-1` can still work because both objects moved together.

An absolute symlink could instead store something like:

```text
/srv/northstar/releases/release-1
```

which works only while the target remains at that absolute path.

For Lab 2, you will deliberately use a relative symlink to model a common deployment pattern.

---

## 12. Deployment pattern: versioned directories plus a `current` link

A common deployment layout is conceptually:

```text
releases/
  release-A/
  release-B/
  current -> release-A
```

Applications or web-server configuration can refer to `current` rather than hard-coding a particular release directory.

A deployment can then switch the link:

```text
before: current -> release-A
after:  current -> release-B
```

The old release remains on disk, making rollback conceptually straightforward.

The Lab 2 scenario uses this pattern because it gives symbolic links a realistic purpose rather than treating `ln -s` as an isolated syntax drill.

---

## 13. What carries forward from Lab 1

Lab 2 assumes familiarity with the core text-processing tools introduced in Lab 1:

```text
wc -l
head/tail -n
grep -i/-n/-c/-v/-r
cut -d/-f
> and >>
2>
pipes
```

Those tools may still appear naturally in later work, but Lab 2 does not spend dedicated time reteaching them.

The deliberate retrieval targets for this lab are instead:

```text
c    create
t    list
x    extract
f    archive filename
z    gzip
j    bzip2
J    xz
v    verbose

ln -s TARGET LINK_NAME
```

Before beginning the practical lab, make sure you can at least explain the difference between **creating**, **listing**, and **extracting** an archive and between **archiving** and **compressing**. The lab will supply the repeated syntax retrieval.
