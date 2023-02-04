#!/bin/bash

# get rom from generator: 
ROM="$1"

# check cpu features: 
rm /tmp/cpufeatures; cat /proc/cpuinfo | grep flags | head -n 1 | grep avx2 >> /tmp/cpufeatures

# prepare logs: 
log1=/userdata/system/pro/ps2plus/log1.txt
log2=/userdata/system/pro/ps2plus/log2.txt
rm $log1 2>/dev/null; rm $log2 2>/dev/null

# prepare *.ai: 
chmod a+x /userdata/system/pro/ps2plus/pcsx2/pcsx2.AppImage 2>/dev/null
chmod a+x /userdata/system/pro/ps2plus/pcsx2/pcsx2-AVX2.AppImage 2>/dev/null
chmod a+x /userdata/system/pro/ps2plus/pcsx2/pcsx2-SSE4.AppImage 2>/dev/null

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
if [[ "$(cat /tmp/cpufeatures | grep avx2)" != "" ]]; then 
	if [[ "$(echo "$ROM" | grep "CONFIG")" != "" ]] || [[ "$(echo "$ROM")" = "" ]]; then
	unclutter-remote -s; DISPLAY=:0.0 QT_FONT_DPI=128 QT_SCALE_FACTOR=$SCALE /userdata/system/pro/ps2plus/pcsx2/pcsx2.AppImage 1>$log1 2>$log2
	else 
	DISPLAY=:0.0 QT_FONT_DPI=128 QT_SCALE_FACTOR=$SCALE /userdata/system/pro/ps2plus/pcsx2/pcsx2.AppImage -fullscreen -nogui "$ROM" 1>$log1 2>$log2
	fi
else 
	if [[ "$(echo "$ROM" | grep "CONFIG")" != "" ]] || [[ "$(echo "$ROM")" = "" ]]; then
	unclutter-remote -s; DISPLAY=:0.0 QT_FONT_DPI=128 QT_SCALE_FACTOR=$SCALE /userdata/system/pro/ps2plus/pcsx2/pcsx2.AppImage 1>$log1 2>$log2
	else 
	DISPLAY=:0.0 QT_FONT_DPI=128 QT_SCALE_FACTOR=$SCALE /userdata/system/pro/ps2plus/pcsx2/pcsx2.AppImage -fullscreen -nogui "$ROM" 1>$log1 2>$log2
	fi 
fi

sleep 1
/userdata/system/pro/ps2plus/extras/boost.sh 2>/dev/null & 

