#! /bin/bash -e

instance_id=$(curl -s http://169.254.169.254/latest/meta-data/instance-id)
region=$(curl -s http://169.254.169.254/latest/meta-data/placement/availability-zone | sed 's/.$//')

asg_cluster=$(aws --region "$region" autoscaling describe-auto-scaling-groups --query 'AutoScalingGroups[*].Tags[?Value==`amstaging-ecs`].ResourceId' --output text)

instance_ids=$(aws --region "$region" autoscaling describe-auto-scaling-groups --auto-scaling-group-names "$asg_cluster" --query 'AutoScalingGroups[0].Instances[*].InstanceId' --output text)

aws --region "$region" --output text ec2 delete-tags --resources $instance_ids --tags Key=CodeDeployAgent,Value=true

aws --region "$region" --output text ec2 create-tags --resources "$instance_id" --tags Key=CodeDeployAgent,Value=true
