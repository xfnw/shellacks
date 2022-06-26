#!/bin/zsh

export DEETS="$1"
export MYNICK="$2"
export JOIN="$3"
export USERNAME="${USER:-shellacks}"

onconnect(){
send "NICK $MYNICK"
}
send(){
echo "> $1"
printf "%b\r\n" "$1" >> sock
}

while [ 1 ]; do

	echo -e "USER $USERNAME 0 * :https://github.com/xfnw/shellacks\r\n" > sock
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
