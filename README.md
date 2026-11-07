# aur-packages

Arch Linux PKGBUILDs I maintain on the [AUR](https://aur.archlinux.org/), built and checked in clean containers.

Each directory is one AUR package and mirrors its AUR git repo
(`ssh://aur@aur.archlinux.org/<pkg>.git`). The AUR stays the place users install from.

## Build

Needs rootless podman and `just`.

```sh
just build <pkg>    # clean build in a throwaway archlinux:base-devel container, then namcap
just srcinfo <pkg>  # regenerate .SRCINFO after editing a PKGBUILD
```

Packages land in `out/<pkg>/`. On GitHub, `.github/workflows/build.yml` runs the same build for every
package directory a push or PR changes (or `gh workflow run build -f pkg=<pkg>`), checks that
`.SRCINFO` is current and uploads the packages as an artifact. Each build starts from a fresh container, so a missing
`makedepends` fails here instead of on a user's machine.

For running and testing the result, use an Arch distrobox (`os dx::create-arch` in
[nix-config](https://github.com/kleinbem/nix-config)).

## License

PKGBUILDs and helper files are under [0BSD](LICENSE), the AUR default.
The packaged software keeps its own license.
