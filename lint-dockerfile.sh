#!/usr/bin/env bash
set -eu

main() {
   docker run --rm -i hadolint/hadolint < ./Dockerfile
}

main
