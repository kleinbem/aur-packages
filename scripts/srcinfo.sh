#!/usr/bin/env bash
# Runs inside archlinux:base-devel; writes /src/.SRCINFO.
set -euo pipefail
useradd -m builder
cp -r /src /build
chown -R builder /build
# Replace .SRCINFO only once makepkg succeeded.
tmp=$(mktemp /src/.SRCINFO.XXXXXX)
trap 'rm -f "$tmp"' EXIT
su builder -c 'cd /build && makepkg --printsrcinfo' >"$tmp"
chmod 644 "$tmp"
mv "$tmp" /src/.SRCINFO
