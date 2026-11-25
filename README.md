# ZentrixOS

**ZentrixOS** is an experimental, Debian-based desktop Linux distribution for x86_64 (AMD64) computers.

The project aims to provide a polished, approachable desktop experience with custom branding, carefully selected applications, and useful system tools.

> **Development status:** Early development. No installable ISO has been published yet. Do not use this project on production machines.

## Initial design

| Area | Initial choice |
|---|---|
| Base | Debian 13 (Trixie) |
| Architecture | AMD64 / x86_64 |
| Kernel | Debian Linux kernel |
| Init system | systemd |
| Desktop | KDE Plasma |
| Display manager | SDDM |
| Bootloader | GRUB (provided by Debian live-build) |
| Package format | DEB / APT |
| ISO tooling | Debian live-build |
| Test environment | QEMU |

These choices are a starting point and may change as the project develops.

## Build environment

Use a Debian 13 (Trixie) or compatible Debian-based build machine. Building an ISO requires administrator privileges and several gigabytes of free disk space.

Install the build tools:

```bash
sudo apt update
sudo apt install --yes live-build debootstrap xorriso \
  squashfs-tools dosfstools grub-pc-bin grub-efi-amd64-bin \
  qemu-system-x86 git
```

## Build the live ISO

Clone the repository and enter its directory:

```bash
git clone https://github.com/Hirunthakan432/ZentrixOS.git
cd ZentrixOS
```

Run the build script:

```bash
sudo ./scripts/build-iso.sh
```

The generated ISO will be placed in the repository's `artifacts/` directory. The first build downloads Debian packages and may take some time.

## Test with QEMU

After a successful build, launch the ISO with:

```bash
qemu-system-x86_64 -m 4096 -smp 2 -cdrom artifacts/zentrixos-amd64.iso -boot d
```

For safety, test in a virtual machine first. Do not install an experimental image on your everyday computer.

## Repository layout

- `config/` — live-build configuration and package selection
- `docs/` — architecture and development roadmap
- `scripts/` — build and validation helpers
- `branding/` — future logos, wallpapers, and visual assets
- `artifacts/` — generated ISO images (not committed)

## Contributing

This is currently a learning and experimentation project. See [docs/ROADMAP.md](docs/ROADMAP.md) for planned milestones.

## License

The project license has not yet been selected. Individual upstream components retain their own licenses.
