#! /bin/bash -e

mkdir -p /efs/shared/jenkins
chown 1000:1000 /efs/shared/jenkins

mkdir -p /efs/shared/nginx

mkdir -p /efs/shared/pritunl/{mongodb,pritunl,etc}

touch /efs/shared/pritunl/etc/pritunl.conf

mkdir -p /efs/shared/build-kite
echo 'tags="queue=docker"' > /efs/shared/build-kite/buildkite-agent.cfg

while true; do sleep 10; done
