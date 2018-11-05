#!/usr/bin/env bash

/usr/local/bin/tagswapper.sh

unset AWS_CONTAINER_CREDENTIALS_RELATIVE_URI
/opt/codedeploy-agent/bin/codedeploy-agent start
tail -F /var/log/aws/codedeploy-agent/codedeploy-agent.log &

while sleep 60; do
  ps -o pid,cmd | grep "codedeploy-agent: master" | grep -q -v grep
  ret_val=$?
  if [[ $ret_val -ne 0 ]]
  then
    exit 1
  fi
done
