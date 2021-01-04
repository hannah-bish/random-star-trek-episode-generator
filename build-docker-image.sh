#!/usr/bin/env bash
set -eu

# TODO: Set the desired docker image name here!
readonly DOCKER_IMAGE='dfmedia/sample-docker-image'
readonly DOCKER_CONTEXT_DIR="${PWD}"
readonly DOCKER_TAG="${1:-latest}"

main() {
  docker build -t "${DOCKER_IMAGE}:${DOCKER_TAG}" "${DOCKER_CONTEXT_DIR}"
}

main
