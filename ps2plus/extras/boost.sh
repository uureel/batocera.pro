#!/bin/bash
sleep 7
for pid in $(pgrep pcsx2-qt); do
    renice -14 $pid
done
