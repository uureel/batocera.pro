#!/bin/bash
sleep 5
pids=$(ps -eLf | awk '/PCSX2/ { print $2,$4 }')
	for pid in $pids; do
		echo "boosting "$pid""
	    renice -11 $pid 2>/dev/null &
	done
wait
exit 0
