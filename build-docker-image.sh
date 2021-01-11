#!/usr/bin/env bash
set -eu

readonly DOCKER_IMAGE='dfmedia/random-star-trek-episode-generator'
readonly DOCKER_CONTEXT_DIR="${PWD}"
readonly DOCKER_TAG="${1:-latest}"

main() {
  docker build -t "${DOCKER_IMAGE}:${DOCKER_TAG}" "${DOCKER_CONTEXT_DIR}"
}

main
