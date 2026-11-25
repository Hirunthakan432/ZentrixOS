#!/usr/bin/env bash
set -Eeuo pipefail

PROJECT_ROOT="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
BUILD_DIR="$(mktemp -d "${TMPDIR:-/tmp}/zentrixos-build.XXXXXX")"
OUTPUT_DIR="$PROJECT_ROOT/artifacts"

cleanup() {
  rm -rf -- "$BUILD_DIR"
}
trap cleanup EXIT

if [[ "$(id -u)" -ne 0 ]]; then
  echo "Please run with sudo: sudo bash ./scripts/build-iso.sh" >&2
  exit 1
fi

for tool in lb xorriso sha256sum; do
  if ! command -v "$tool" >/dev/null 2>&1; then
    echo "Missing required tool: $tool" >&2
    echo "Install build dependencies as described in README.md." >&2
    exit 1
  fi
done

mkdir -p "$BUILD_DIR/config/package-lists" "$OUTPUT_DIR"
cp "$PROJECT_ROOT/config/packages.list.chroot" \
  "$BUILD_DIR/config/package-lists/zentrixos.list.chroot"

cd "$BUILD_DIR"

echo "Configuring ZentrixOS for Debian 13 (Trixie), AMD64..."
lb config \
  --distribution trixie \
  --architectures amd64 \
  --binary-images iso-hybrid \
  --debian-installer live \
  --archive-areas "main contrib non-free non-free-firmware" \
  --bootappend-live "boot=live components quiet"

echo "Building the live image. The first build downloads Debian packages..."
lb build

ISO_SOURCE="$(find "$BUILD_DIR" -maxdepth 1 -type f -name '*.iso' -print -quit)"
if [[ -z "$ISO_SOURCE" ]]; then
  echo "Build completed but no ISO was found." >&2
  exit 1
fi

install -m 0644 "$ISO_SOURCE" "$OUTPUT_DIR/zentrixos-amd64.iso"
sha256sum "$OUTPUT_DIR/zentrixos-amd64.iso" \
  > "$OUTPUT_DIR/zentrixos-amd64.iso.sha256"

echo "ZentrixOS ISO created:"
echo "  $OUTPUT_DIR/zentrixos-amd64.iso"
cat "$OUTPUT_DIR/zentrixos-amd64.iso.sha256"
