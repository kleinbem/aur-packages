# Sync with nixpkgs

Changes land in nixpkgs first (`kleinbem/nixpkgs`, branch `mesh-llm-next`), then
here. This file records the nixpkgs commit each package last caught up with, so
the next sync starts from a diff. It stays in this repo; the AUR repos only get
the package directories.

| Package | nixpkgs commit | Date |
|---|---|---|
| mesh-llm-git | `mesh-llm-next` 5e86254a86bb1ca0b4097a69deac78b6f3f56865 | 2026-10-22 |

What changed in nixpkgs since then:

```sh
git -C ~/Develop/github.com/NixOS/nixpkgs.wt-079-prep fetch origin mesh-llm-next
git -C ~/Develop/github.com/NixOS/nixpkgs.wt-079-prep diff 5e86254a86bb FETCH_HEAD -- \
  pkgs/by-name/me/mesh-llm pkgs/by-name/sk/skippy pkgs/by-name/sk/skippy-native-runtime \
  nixos/modules/services/misc/mesh-llm.nix nixos/tests/mesh-llm.nix
```

After a sync, update the commit above in the same commit as the PKGBUILD change.
