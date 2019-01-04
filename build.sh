#!/usr/bin/env bash

set -x
set -e

echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin

wget https://bin.equinox.io/c/VdrWdbjqyF/cloudflared-stable-linux-amd64.tgz
tar -C ./cloudflared -zxf cloudflared-stable-linux-amd64.tgz

find ./ -maxdepth 1 \! -name ".git" \! -name "." -type d -printf "%P\\n" | \
while read -r dir
do
  echo "#############################################################"
  echo "Building $dir"
  echo "#############################################################"
  docker build -t "$DOCKER_USERNAME/$dir:latest" "$dir"
  docker push "$DOCKER_USERNAME/$dir:latest"
done

echo "#############################################################"
echo "Building caddy"
echo "#############################################################"
docker build -t "$DOCKER_USERNAME/caddy:latest" --build-arg     plugins=route53     github.com/abiosoft/caddy-docker.git
docker push "$DOCKER_USERNAME/caddy:latest"
