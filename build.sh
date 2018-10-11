#!/usr/bin/env bash

set -x

echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin

find . \! -name ".git" -type d -depth 1 -printf "%P\\n" | \
while read -r dir
do
  docker build -t "$DOCKER_USERNAME/$dir:latest"
  docker push "$DOCKER_USERNAME/$dir:latest"
done

