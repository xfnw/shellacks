#!/bin/zsh

channel="$1"

while [ 1 ]; do
echo > qjs
tail -fn0 qjs | ./quickjs/qjscalc --memory-limit 100000000 --stack-size 100000000 | while IFS= read -r line
do
[ "$(echo $line | ./uncolor)" = "" ] ||
printf "PRIVMSG %s :%s\r\n" "$channel" "$line" | ./uncolor >> sock
done

done
