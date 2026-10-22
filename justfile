image := "docker.io/library/archlinux:base-devel"

# List recipes.
default:
    @just --list

# Clean build of <pkg> in a throwaway Arch container, then namcap.
build pkg:
    test -f {{pkg}}/PKGBUILD
    mkdir -p out/{{pkg}}
    podman run --rm --pull=newer \
        -v "$PWD/{{pkg}}":/src:ro,Z \
        -v "$PWD/out/{{pkg}}":/out:Z \
        -v "$PWD/scripts":/scripts:ro,Z \
        -v aur-packages-cache:/cache \
        {{image}} bash /scripts/build.sh

# Regenerate .SRCINFO for <pkg>.
srcinfo pkg:
    test -f {{pkg}}/PKGBUILD
    podman run --rm \
        -v "$PWD/{{pkg}}":/src:Z \
        -v "$PWD/scripts":/scripts:ro,Z \
        {{image}} bash /scripts/srcinfo.sh
