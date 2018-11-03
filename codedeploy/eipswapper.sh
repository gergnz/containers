#! /bin/bash -e

instance_id=$(curl -s http://169.254.169.254/latest/meta-data/instance-id)
region=$(curl -s http://169.254.169.254/latest/meta-data/placement/availability-zone | sed 's/.$//')

aws --region "$region" --output text ec2 associate-address --allow-reassociation --allocation-id "$EIPALLOCATION" --instance-id "$instance_id"

IFS=$'\t'
existing_groups=($(aws --region "$region" --output text ec2 describe-instances --instance-id "$instance_id" --query 'Reservations[*].Instances[*].SecurityGroups[*].GroupId'))
echo '{ "Groups": [' > /tmp/groups.json
for ((i=0; i<${#existing_groups[@]}; i++)); do echo -n "\"${existing_groups[$i]}\","; done >> /tmp/groups.json
echo "\"$SECURITYGROUP\"" >> /tmp/groups.json
echo ']}' >> /tmp/groups.json
aws --region "$region" --output text ec2 modify-instance-attribute --instance-id "$instance_id" --cli-input-json "$(cat /tmp/groups.json)"

while true; do sleep 10; done
