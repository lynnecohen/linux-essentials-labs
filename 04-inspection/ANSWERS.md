# Lab 4 — Exact-Recall Answer Key

Use this **after** completing the exact-recall checkpoint in `INSTRUCTIONS.md`.

1. Process snapshot:

   ```bash
   ps
   ```

2. Live interactive process view:

   ```bash
   top
   ```

3. Memory usage:

   ```bash
   free
   ```

4. Kernel messages:

   ```bash
   dmesg
   ```

5. System paths:

   ```text
   /etc       system configuration
   /var/log   logs
   /boot      boot-related files
   /proc      process and kernel runtime information
   /dev       device nodes
   /sys       structured kernel/device information
   ```

6. Interface addresses:

   ```bash
   ip addr show
   ```

7. Routing table/default gateway:

   ```bash
   ip route show
   ```

8. In `ip addr show`, `inet` introduces an IPv4 address and `inet6` introduces an IPv6 address.

9. Four IPv4-loopback ping requests:

   ```bash
   ping -c 4 127.0.0.1
   ```

10. Basic DNS lookup:

   ```bash
   host example.com
   ```

11. Modern socket inspection:

   ```bash
   ss
   ```

12. Local static hostname mappings:

   ```text
   /etc/hosts
   ```

13. Resolver/DNS configuration:

   ```text
   /etc/resolv.conf
   ```

14. Modern equivalents:

   ```text
   ifconfig    -> ip addr show
   route       -> ip route show
   netstat     -> ss
   ```

15. `ip addr show` answers **what addresses are configured on interfaces**. `ip route show` answers **where traffic should be sent for destination networks**, including the default route when present.

16. `free` reports memory usage. `df` reports filesystem/disk-space usage.
