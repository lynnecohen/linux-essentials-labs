# Lab 2 — Exact-Recall Answer Key

Use this **after** completing the exact-recall checkpoint in `INSTRUCTIONS.md`.

Equivalent valid command spellings are acceptable.

1. Create a gzip-compressed tar archive:

   ```bash
   tar -czf backup.tar.gz website/
   ```

2. List it without extracting:

   ```bash
   tar -tzf backup.tar.gz
   ```

3. Extract it into the current directory:

   ```bash
   tar -xzf backup.tar.gz
   ```

4. Tar flags:

   ```text
   c    create
   x    extract
   t    list
   f    archive filename follows
   z    gzip compression
   j    bzip2 compression
   J    xz compression
   v    verbose
   ```

5. bzip2 uses `j`; xz uses uppercase `J`.

6. `-f` tells `tar` that the archive filename is supplied as an argument. In:

   ```bash
   tar -czf archive.tar.gz project/
   ```

   the archive filename is `archive.tar.gz`; `project/` is the input being archived.

7. A `.tar` file is an uncompressed tar archive. A `.tar.gz` file is a tar archive compressed with gzip.

8. Standalone gzip:

   ```text
   gzip     compress
   gunzip   decompress
   ```

   ZIP:

   ```bash
   zip archive.zip file1 file2
   unzip archive.zip
   ```

9. Create `current` pointing to `release-2`:

   ```bash
   ln -s release-2 current
   ```

10. A relative symbolic-link target is resolved relative to the directory **containing the link**. Deleting only `current` removes the symbolic link; it does not delete the `release-2` target.
