# Lab 4 — System & Network Inspection

## Scenario

The fictional **Northstar Learning Portal** has been reported as intermittently unreachable. Before changing anything, you have been asked to collect a compact **read-only system-inspection packet** from Prometheus: process state, memory state, interface addressing, routes, sockets, and resolver configuration.

The purpose of this lab is not to diagnose a real Prometheus outage. It is to practice choosing the correct Linux inspection command and interpreting the kind of information it returns.

Lab 3 showed that ordinary permission arithmetic, symbolic `chmod`, account-file mapping, and `id` are now comfortable. Sticky-bit semantics, `who`/`w`/`last`, and login-shell distinctions were clarified and will recur only incidentally. Lab 4 now shifts deliberate practice to system and networking inspection.

## Primary practice targets

- `ps` versus `top`
- `free` for memory usage
- `dmesg` for kernel messages
- `/etc`, `/var/log`, `/boot`, `/proc`, `/dev`, and `/sys`
- `ip addr show`
- `ip route show`
- IPv4 versus IPv6 recognition
- `ping -c`
- `host` for DNS lookup
- `ss` as the modern socket-inspection command
- `/etc/hosts` versus `/etc/resolv.conf`
- recognition of legacy `ifconfig`, `route`, and `netstat`

## Before you begin — pre-reading

Read **[Lab 4 Pre-Reading — System and Network Inspection](READING.md)** before starting the practical work.

## Setup

From the repository root:

```bash
bash setup.sh 4
```

Then work from:

```text
04-system-network/work/
```

This lab intentionally reads real Prometheus state. The generated work directory is primarily a place to store your results.

No task in this lab asks you to change network configuration, terminate processes, mount filesystems, or modify system files.

---

## Part A — Processes and memory

### 1. Process snapshot

Run the basic process snapshot command and save its output as:

```text
results/processes.txt
```

Then inspect the saved result and identify the PID and command columns.

### 2. Live process view — unscored

Open the live interactive process viewer.

Observe the display for a few refreshes, then quit with:

```text
q
```

Be able to explain how this differs from the snapshot command.

### 3. Memory state

Save the ordinary output of the Linux memory-reporting command as:

```text
results/memory.txt
```

Identify the `Mem:` and `Swap:` rows if present.

Do not substitute a disk/filesystem-space command; this task is specifically about memory.

---

## Part B — Kernel and system paths

### 4. Kernel messages — unscored

Inspect only the first several kernel-message lines rather than flooding the terminal.

If the kernel message buffer is restricted for your user, note the permission error. If you have appropriate sudo access, you may repeat the same read-only inspection with `sudo`.

Do not change any kernel settings.

### 5. Inspect the high-value filesystem locations

Use ordinary listing/viewing commands to inspect:

```text
/etc
/var/log
/boot
/proc
/dev
/sys
```

You do not need to explore every file.

Create:

```text
results/path-map.txt
```

containing exactly:

```text
config=/etc
logs=/var/log
boot=/boot
process-kernel=/proc
devices=/dev
kernel-devices=/sys
```

### 6. Look inside `/proc` — unscored

Inspect:

```text
/proc/1
```

and at least one human-readable file under `/proc`, such as:

```text
/proc/meminfo
```

Connect what you see back to the idea that `/proc` is a virtual filesystem generated from runtime kernel/process state.

---

## Part C — Interface addresses and routing

### 7. Interface addressing

Save the output of the modern Linux command that shows interface addresses as:

```text
results/ip-addresses.txt
```

In the output, identify:

- the loopback interface
- at least one `inet` IPv4 line
- any `inet6` IPv6 lines that are present
- the interface Prometheus appears to use for normal network connectivity

Do not use Windows `ipconfig` syntax.

### 8. Routing table

Save the Linux routing table as:

```text
results/routes.txt
```

If a default route is present, identify:

- the word `default`
- the next-hop address after `via`, if shown
- the interface after `dev`

Be able to explain why "what address does this machine have?" and "where does this machine send traffic?" are different questions.

---

## Part D — Basic connectivity and DNS

### 9. Limited ping — unscored

Send exactly four ping requests to the IPv4 loopback address:

```text
127.0.0.1
```

The purpose is exact `ping -c` recall, not external-network testing.

### 10. DNS lookup with `host` — environment-dependent

First check whether the command exists:

```bash
command -v host
```

If it is available, use it to look up:

```text
example.com
```

If Prometheus does not have `host`, do **not** install packages solely for this lab. Practice the exact command from memory instead. You may also try it in **WebTerm Free Play** if that sandbox exposes the command.

This task is not scored because availability depends on the environment.

---

## Part E — Sockets and resolver files

### 11. Socket inspection

Save the ordinary output of the modern Linux socket-inspection command as:

```text
results/sockets.txt
```

Look at the column headings and any current connections.

The point is to associate the modern command with sockets/connections, not to memorize a large set of flags.

### 12. Local host mappings

Copy the current contents of:

```text
/etc/hosts
```

into:

```text
results/hosts.txt
```

Inspect the result and find the loopback mapping if present.

### 13. Resolver configuration

Copy the current contents of:

```text
/etc/resolv.conf
```

into:

```text
results/resolv.conf.txt
```

Look for resolver directives such as `nameserver` or `search` if present.

Do not edit either system file.

---

## Part F — Modern/legacy command recognition

Legacy networking utilities may not be installed on Prometheus. Do not install them solely for this lab.

Run these only to see whether the executable exists:

```bash
command -v ifconfig
command -v route
command -v netstat
```

Regardless of whether they are installed, create:

```text
results/tool-map.txt
```

containing exactly:

```text
process-snapshot=ps
process-live=top
memory=free
kernel-messages=dmesg
address=ip addr show
routing=ip route show
dns=host
sockets=ss
hosts-file=/etc/hosts
resolver-file=/etc/resolv.conf
legacy-ifconfig=ip addr show
legacy-route=ip route show
legacy-netstat=ss
```

This is the compact recognition map you should be able to reconstruct on the exam.

---

## Check your work

From the repository root:

```bash
bash check.sh 4
```

The checker validates the output packet and recognition files using broad patterns rather than expecting Prometheus to have a specific IP address, UID, route, or socket state.

If you want to rebuild the generated workspace:

```bash
bash reset.sh 4
```

---

## Exact-recall checkpoint

Do this after the practical work without looking back at the reading if possible.

1. What command shows a snapshot of processes?
2. What command provides a live, interactive process view?
3. What command shows memory usage?
4. What command displays kernel messages?
5. Match these paths to their primary purpose: `/etc`, `/var/log`, `/boot`, `/proc`, `/dev`, `/sys`.
6. What is the modern Linux command to show interface addresses?
7. What is the modern Linux command to show the routing table/default gateway?
8. In `ip addr show` output, what do `inet` and `inet6` indicate?
9. Write a command that sends exactly four ping requests to `127.0.0.1`.
10. What command should you associate with a basic DNS lookup for `example.com`?
11. What modern command should you associate with socket inspection?
12. Which file contains local static hostname mappings?
13. Which file contains resolver/DNS configuration?
14. Give the modern equivalents for legacy `ifconfig`, `route`, and `netstat`.
15. Why are `ip addr show` and `ip route show` answering different networking questions?
16. Briefly distinguish `free` from `df`.

## Stop point

When the practical work and recall checkpoint are complete, review what was automatic and what required a lookup. Lab 5 will use that evidence and shift deliberate practice toward the Linux Essentials v1.6 Bash scripting core.
