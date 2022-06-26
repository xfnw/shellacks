#!/bin/zsh

export DEETS="$1"
export NICK="$2"
export JOIN="$3"

onconnect(){
send "NICK $NICK"
}
send(){
echo "> $1"
printf "%b\r\n" "$1" >> sock
}

while [ 1 ]; do

	echo -e "USER $NICK 0 * :shell bot\r\n" > sock
	onconnect

	tail -f sock | openssl s_client "$DEETS" | while read -r raw
	do
		line=$(printf %b "$raw" | tr -d $'\r')

		echo "< $line"
		source tokenize.sh "$line"

		if [ -d "hooks/$CMD/" ]; then
			for hook in hooks/"$CMD"/*; do
				source "$hook"
			done
		fi
	done
	sleep 5
done
