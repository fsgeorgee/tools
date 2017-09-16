#!/bin/bash

PROC=$1

function findKillZombies () {
	ps -U $USER | egrep "$PROC" | awk '{print $1}' | (
	while read -r pid
	do
	if kill -15 $pid; then
		echo "$pid killed successfully."
	else
		echo "kill -15 to $pid failed. Sleeping 5 seconds before retry."
		if kill -15 $pid; then
			echo "$pid killed successfully."
		else
			echo "kill -15 to $pid failed for the second time. Trying kill -9"
			if kill -9 $pid; then
				echo "$pid killed successfully."	
			fi
		fi
	fi
	done
	)
}

SERVERS=(
	"0.0.0.0"
	"0.0.0.0"
)

for ((i = 0; i < ${#SERVERS[@]}; i++)); do
	ssh autoengine@${SERVERS[i]} "$(typeset -f); findKillZombies"
done
