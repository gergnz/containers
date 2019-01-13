#!/usr/bin/env bash

set -x
set -e

echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin

echo "#############################################################"
echo "Building caddy"
echo "#############################################################"
docker build -t "$DOCKER_USERNAME/caddy:latest" --build-arg     plugins=route53     github.com/abiosoft/caddy-docker.git
docker push "$DOCKER_USERNAME/caddy:latest"
