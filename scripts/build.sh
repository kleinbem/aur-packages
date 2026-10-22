#!/usr/bin/env bash
# Runs inside a fresh archlinux:base-devel container.
# /src = package dir (read-only), /out = results, /cache = cargo/pnpm/source cache volume.
set -euo pipefail

pacman -Syu --noconfirm --needed git namcap >/dev/null

# makepkg refuses to run as root; build as an unprivileged user with
# passwordless sudo so `makepkg -s` can install dependencies.
useradd -m builder
echo 'builder ALL=(ALL) NOPASSWD: ALL' >/etc/sudoers.d/builder

mkdir -p /cache/cargo /cache/pnpm /cache/sources /build
cp -r /src/. /build/
chown -R builder /build /cache

echo '==> namcap PKGBUILD'
namcap /build/PKGBUILD || true

su builder -c '
    export CARGO_HOME=/cache/cargo
    export npm_config_store_dir=/cache/pnpm
    export SRCDEST=/cache/sources
    export PKGDEST=/build/pkgs
    cd /build && makepkg --syncdeps --cleanbuild --noconfirm
'

echo '==> namcap packages'
for p in /build/pkgs/*.pkg.tar.*; do
    namcap "$p" || true
    cp "$p" /out/
done
echo "==> done: $(ls /out)"
