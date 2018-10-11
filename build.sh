#!/usr/bin/env bash

set -x
set -e

docker login -u "$DOCKER_USERNAME" -p "$DOCKER_PASSWORD"

find ./ -maxdepth 1 \! -name ".git" \! -name "." -type d -printf "%P\\n" | \
while read -r dir
do
  docker build -t "$DOCKER_USERNAME/$dir:latest"
  docker push "$DOCKER_USERNAME/$dir:latest"
done

