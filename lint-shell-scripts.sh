#!/usr/bin/env bash
set -eu

main() {
   find . -type f -name '*.sh' -print0 | xargs -0 docker run --rm -v "${PWD}:/mnt:ro" koalaman/shellcheck:stable -xs bash
}

main
