# ZentrixOS Roadmap

This roadmap is a living plan. Features are not complete until they are implemented and tested.

## Milestone 1 — Repository and build foundation

- [x] Create the GitHub repository
- [x] Add initial project documentation
- [x] Define the initial Debian-based architecture
- [ ] Prepare a Debian 13 build environment
- [ ] Generate the first live ISO
- [ ] Boot-test the ISO in QEMU

## Milestone 2 — Desktop experience

- [ ] Configure KDE Plasma defaults
- [ ] Add initial ZentrixOS wallpaper and branding
- [ ] Select a small, useful default application set
- [ ] Configure networking and audio defaults
- [ ] Verify display scaling and keyboard layouts

## Milestone 3 — System identity and utilities

- [ ] Add ZentrixOS release metadata
- [ ] Create a system information utility
- [ ] Add first-boot welcome experience
- [ ] Document update and package-management behavior

## Milestone 4 — Installation and quality

- [ ] Decide and test the installation workflow
- [ ] Test UEFI boot in a virtual machine
- [ ] Test common virtual hardware configurations
- [ ] Document known limitations
- [ ] Produce checksums for release images

## Milestone 5 — Release engineering

- [ ] Automate ISO builds
- [ ] Establish version numbers and release notes
- [ ] Publish reproducible build instructions
- [ ] Create a public issue and contribution process

## Safety rule

All early development and installation testing should happen in virtual machines with disposable virtual disks. Back up important data before any later physical-device testing.
