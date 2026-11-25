#!/usr/bin/env bash
set -Eeuo pipefail

PROJECT_ROOT="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$PROJECT_ROOT"

if [[ "$(id -u)" -ne 0 ]]; then
  echo "Please run this script with sudo: sudo ./scripts/build-iso.sh" >&2
  exit 1
fi

if ! command -v lb >/dev/null 2>&1; then
  echo "live-build is missing. Install it with: sudo apt install live-build" >&2
  exit 1
fi

if ! command -v xorriso >/dev/null 2>&1; then
  echo "xorriso is missing. Install it with: sudo apt install xorriso" >&2
  exit 1
fi

if [[ -e config ]]; then
  echo "A live-build config directory already exists."
  echo "This script will preserve it and stop rather than overwrite configuration."
  exit 1
fi

mkdir -p artifacts

echo "Configuring ZentrixOS for Debian 13 (Trixie), AMD64..."
lb config \
  --distribution trixie \
  --architectures amd64 \
  --binary-images iso-hybrid \
  --debian-installer live \
  --archive-areas "main contrib non-free non-free-firmware" \
  --bootappend-live "boot=live components quiet splash"

echo "Starting live-build. This downloads packages and can take a while..."
lb build

ISO_SOURCE="$(find . -maxdepth 1 -type f -name '*.iso' -print -quit)"
if [[ -z "$ISO_SOURCE" ]]; then
  echo "Build finished but no ISO was found in the project root." >&2
  exit 1
fi

mv -- "$ISO_SOURCE" "artifacts/zentrixos-amd64.iso"
sha256sum "artifacts/zentrixos-amd64.iso" > "artifacts/zentrixos-amd64.iso.sha256"

echo "ZentrixOS ISO created:"
echo "  $PROJECT_ROOT/artifacts/zentrixos-amd64.iso"
echo "SHA256:"
cat "artifacts/zentrixos-amd64.iso.sha256"
