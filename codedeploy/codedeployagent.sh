#!/usr/bin/env bash

/usr/local/bin/tagswapper.sh

/opt/codedeploy-agent/bin/codedeploy-agent start

while sleep 60; do
  ps -o pid,cmd | grep "codedeploy-agent: master" | grep -q -v grep
  ret_val=$?
  if [[ $ret_val -ne 0 ]]
  then
    exit 1
  fi
done
