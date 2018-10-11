#!/bin/sh

# copy from s3
aws s3 cp s3://bastionauthorisedusers/githubusers.txt authorisedusers.txt

# Read usernames from file
file="authorisedusers.txt"
while IFS= read line
# for every username curl https://github.com/<username>.keys to get their ssh keys
do
  curl -s https://github.com/${line}.keys >> /home/bastion/.ssh/authorized_keys
done <"$file"

ssh-keygen -A

exec "$@"
