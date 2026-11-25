# Build configuration

The package selection for the live image is in `packages.list.chroot`.

The build script currently uses Debian live-build defaults for the bootloader and live system. It generates the live-build `config/` directory at build time. Review generated settings before changing boot or installer behavior.

Do not commit generated caches, chroot files, binary output, or ISO artifacts.
