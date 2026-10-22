#!/usr/bin/env bash
# Runs inside archlinux:base-devel; writes /src/.SRCINFO.
set -euo pipefail
useradd -m builder
cp -r /src /build
chown -R builder /build
su builder -c 'cd /build && makepkg --printsrcinfo' >/src/.SRCINFO
