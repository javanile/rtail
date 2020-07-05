#!/bin/bash

RTAIL=./rtail.sh
HOST=ubuntu@localhost
FILE=`pwd`/test.txt

expected=`cat $FILE`
out=`$RTAIL -p22222 $HOST $FILE`

if [[ "$expected" != "$out" ]]; then
  echo "fail"
  exit 1
fi

echo "pass"
exit 0
