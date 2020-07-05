#!/bin/bash

RTAIL=./rtail.sh
HOST=ubuntu@localhost
FILE=`pwd`/test.txt

## Perform the first connection to fake-ssh-server to get know_hosts updated
ssh -p22222 -oStrictHostKeyChecking=no ${HOST} true

expected=`cat $FILE`
out=`$RTAIL -p22222 $HOST $FILE`

if [[ "$expected" != "$out" ]]; then
  echo "fail"
  exit 1
fi

echo "pass"
exit 0
