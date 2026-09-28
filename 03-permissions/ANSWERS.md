# Lab 3 — Exact-Recall Answer Key

Use this **after** completing the exact-recall checkpoint in `INSTRUCTIONS.md`.

1. Owner read/write, group read-only, others none:

   ```text
   640
   ```

2. Add owner execute permission:

   ```bash
   chmod u+x deploy.sh
   ```

3. Remove group write permission:

   ```bash
   chmod g-w portal.conf
   ```

4. Numeric permission values:

   ```text
   r = 4
   w = 2
   x = 1
   ```

5. In `-rwxr-x---`, the three triplets are:

   ```text
   rwx    owner
   r-x    group
   ---    others
   ```

6. A final `t` on a shared writable directory indicates the **sticky bit**. It restricts removal/renaming so users cannot ordinarily delete or rename other users' entries merely because the directory itself is writable.

7. Session commands:

   ```text
   who    currently logged-in sessions
   w      logged-in users plus what they are doing
   last   recent login/session history
   ```

8. `whoami` reports the effective username. `id` additionally reports numeric UID, GID, and group memberships.

9. Account files:

   ```text
   /etc/passwd    account identity/basic account information
   /etc/shadow    protected password/password-related information
   /etc/group     group definitions
   ```

10. Basic account commands:

   ```bash
   useradd lpi_alice
   groupadd lpi_staff
   passwd lpi_alice
   ```

11. Set owner and group:

   ```bash
   chown lpi_alice:lpi_staff example.txt
   ```

12. `su lpi_alice` switches to that user without requesting a full login environment. `su - lpi_alice` requests a login shell/environment for the target user.

13. `sudo COMMAND` runs an authorized command as another user—root by default in ordinary use—according to sudo policy. `su - USER` switches into a login shell/session as the target user.

14. Broadly, `/tmp` is intended for shorter-lived temporary data and may be cleared more aggressively; `/var/tmp` is intended for temporary data that persists longer. Exact cleanup policy is system-dependent.
