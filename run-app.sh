#!/usr/bin/env bash
set -eu

readonly DOCKER_COMPOSE_FILE=.docker-compose-artifacts/cook_run_app/docker-compose.yml

run_docker_compose() {
  docker-compose -f "${DOCKER_COMPOSE_FILE}" up
}

cleanup_docker_compose() {
  docker-compose -f "${DOCKER_COMPOSE_FILE}" down -v --rmi local
}

main() {
   ./build-docker-image.sh
   ./ansible/cook_run_app.yml

   # Ensure Docker Compose resources are cleaned up no matter how this script exits
   trap cleanup_docker_compose EXIT

   run_docker_compose
}

main
