# ZentrixOS Architecture

## Overview

ZentrixOS is a Debian-based distribution, not a new kernel. Debian supplies the Linux kernel, hardware enablement, package infrastructure, and core user-space components. ZentrixOS will add distribution configuration, branding, selected applications, and project-specific utilities.

## Layer model

1. **Hardware:** x86_64 CPU, memory, storage, graphics, networking, and peripherals.
2. **Linux kernel:** process scheduling, virtual memory, device drivers, and system calls.
3. **Base operating system:** Debian user space, systemd, APT, networking services, and core utilities.
4. **Desktop environment:** KDE Plasma, SDDM, KDE applications, and desktop settings.
5. **ZentrixOS layer:** branding, default configuration, documentation, setup tools, and future original applications.

## Initial platform

- Debian 13 (Trixie)
- AMD64 (x86_64)
- Linux kernel supplied by Debian
- systemd
- KDE Plasma desktop
- SDDM display manager
- APT / DEB packages
- Debian live-build for ISO production

## Design principles

- Prefer reliable upstream components over maintaining a custom kernel.
- Keep build steps reproducible and documented.
- Test ISO images in QEMU before any physical installation.
- Avoid including proprietary or redistributable assets without checking their licenses.
- Keep user data and installation workflows safe.

## Future decisions

The project may later define its own theme, default applications, installer experience, update policy, release process, and original system utilities.
