#!/bin/bash

set -o errexit

readonly REGISTRY_ADDRESS="${REGISTRY_ADDRESS:-registry-1.docker.io}"
readonly DOCKER_USERNAME="${DOCKER_USERNAME:-}"
readonly DOCKER_PASSWORD="${DOCKER_PASSWORD:-}"

main() {
  check_args "$@"

  local image=$1
  local tag=$2
  local token=$(get_token $image)
  local digest=$(get_digest $image $tag $token)

  echo $digest
}

get_token() {
  local image=$1

  echo "Retrieving Docker Hub token.
    IMAGE: $image
  " >&2

  curl \
    --silent \
    -u "$DOCKER_USERNAME:$DOCKER_PASSWORD" \
    "https://auth.docker.io/token?scope=repository:$image:pull&service=registry.docker.io" \
    | jq -r '.token'
}

check_args() {
  if (($# != 2)); then
    echo "Error:
    Two arguments must be provided - $# provided.

    Usage:
      ./get-image-config.sh <image> <tag>

Aborting."
    exit 1
  fi
}

get_digest() {
  local image=$1
  local tag=$2
  local token=$3

  echo "Retrieving image digest.
    IMAGE:  $image
    TAG:    $tag
  " >&2

  curl \
    --silent \
    --header "Accept: application/vnd.docker.distribution.manifest.v2+json" \
    --header "Authorization: Bearer $token" \
    "https://$REGISTRY_ADDRESS/v2/$image/manifests/$tag" \
    | openssl sha256  | awk '{print $NF}'
}

# Run the entry point with the CLI arguments
# as a list of words as supplied.
main "$@"
