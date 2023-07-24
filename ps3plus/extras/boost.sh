#!/bin/bash
sleep 7
for pid in $(pgrep rpcs3); do
    renice -14 $pid
done
