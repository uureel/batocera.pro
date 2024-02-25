#!/bin/bash
# batocera.pro mousemove.sh = show mouse but move to corner
###########################################################
# show mouse
  unclutter-remote -s
# get screen resolution 
  r=$(xrandr | grep "+" | awk '{print $1}' | tail -n1)
  w=$(echo "$r" | cut -d "x" -f1)
  h=$(echo "$r" | cut -d "x" -f2)
# move mouse cursor to bottom right corner
if [[ "$w" =~ ^[1-9][0-9]{2,}$ ]] && [[ "$h" =~ ^[1-9][0-9]{2,}$ ]]; then
  ~/pro/.dep/xdotool mousemove --sync $w $h 2>/dev/null
else 
  ~/pro/.dep/xdotool mousemove --sync 0 0 2>/dev/null
fi
