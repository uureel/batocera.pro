#!/bin/bash
sleep 5
pids=$(ps -eLf | awk '/rpcs3/ { print $2,$4 }')
	for pid in $pids; do
		echo "boosting "$pid""
	    renice -15 $pid 2>/dev/null &
	done
wait
exit 0
