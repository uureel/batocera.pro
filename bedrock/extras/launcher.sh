#!/bin/bash

# prepare logs: 
log1=/userdata/system/pro/ps3plus/log1.txt
log2=/userdata/system/pro/ps3plus/log2.txt
rm $log1 2>/dev/null; rm $log2 2>/dev/null

# prepare *.ai: 
chmod a+x /userdata/system/pro/bedrock/bedrock.AppImage

# get scale/resolution: 
SCALE=1
res=$(xrandr | grep " connected" | awk '{print $3}' | cut -d "x" -f1)
if [[ "$res" -le "3840" ]] && [[ "$res" -ge "2560" ]]; then
SCALE=1.25
fi 
if [[ "$res" -lt "2560" ]] && [[ "$res" -ge "1920" ]]; then
SCALE=1.0
fi 
if [[ "$res" -lt "1920" ]] && [[ "$res" -ge "1280" ]]; then
SCALE=0.75
fi 
if [[ "$res" -lt "1280" ]]; then
SCALE=0.5
fi 

# start appimage: 
DISPLAY=:0.0 \
QT_FONT_DPI=128 \
QT_SCALE_FACTOR=$SCALE \
/userdata/system/pro/bedrock/bedrock.AppImage 1>$log1 2>$log2
