#! /bin/bash -e

region=$(curl -s http://169.254.169.254/latest/meta-data/placement/availability-zone | sed 's/.$//')

mkdir -p /efs/shared/jenkins
chown 1000:1000 /efs/shared/jenkins

mkdir -p /efs/shared/nginx

mkdir -p /efs/shared/pritunl/{mongodb,pritunl,etc}

touch /efs/shared/pritunl/etc/pritunl.conf

mkdir -p /efs/shared/build-kite
echo 'tags="queue=docker"' > /efs/shared/build-kite/buildkite-agent.cfg

mkdir -p /efs/shared/build-kite/buildkite-secrets/pxadmin/urbis_pro_support_infra
aws --region "$region" ssm get-parameter --name /pxadmin/urbis_pro_support_infra/access-key --output text --query 'Parameter.Value' --with-decryption | base64 -d > /efs/shared/build-kite/buildkite-secrets/pxadmin/urbis_pro_support_infra/access-key

chmod 600 /efs/shared/build-kite/buildkite-secrets/pxadmin/urbis_pro_support_infra/access-key

mkdir -p /efs/shared/build-kite/hooks
cat > /efs/shared/build-kite/hooks/environment <<EOF
#!/bin/bash

set -euo pipefail

eval "\$(ssh-agent -s)"
ssh-add -k /buildkite-secrets/pxadmin/urbis_pro_support_infra
EOF

chmod +x /efs/shared/build-kite/hooks/environment

while true; do sleep 10; done
