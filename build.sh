#!/usr/bin/env bash

set -x
set -e

echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin

find ./ -maxdepth 1 \! -name ".git" \! -name "." -type d -printf "%P\\n" | \
while read -r dir
do
  docker build -t "$DOCKER_USERNAME/$dir:latest"
  docker push "$DOCKER_USERNAME/$dir:latest"
done

