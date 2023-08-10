#!/bin/bash
ps -eLf | awk '/PCSX2/ { print $2,$4 }' | while read pid; do kill $pid 1>/dev/null 2>/dev/null; done
exit 0
