#!/bin/bash
FILENAME='users.txt'

COUNTER=1
while read line || [ -n "$line" ];do
  USR=$(echo $line | awk '{print $1}')
  PD=$(echo $line | awk '{print $2}')
  GRP=$(echo $line | awk '{print $3}')
  for i in $line;  do
    let COUNTER++
  done
  for (( i = 4; i < $COUNTER; i++ )); do
    TMP=$(echo $line | awk "{print \$$i}")
    OTHER="$OTHER $TMP"
  done
  useradd -d /home/$USR -G $GRP -p "$PD" -s /bin/bash -c "$OTHER" $USR
  OTHER=
  COUNTER=1;
done < $FILENAME
