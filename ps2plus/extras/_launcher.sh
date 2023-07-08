#!/bin/bash

# get rom from generator: 
ROM="$1"

# check cpu features: 
rm /tmp/cpufeatures 2>/dev/null; cat /proc/cpuinfo | grep flags | head -n 1 | grep avx2 >> /tmp/cpufeatures

# prepare logs: 
log1=/userdata/system/pro/ps2plus/log1.txt
log2=/userdata/system/pro/ps2plus/log2.txt
rm $log1 2>/dev/null; rm $log2 2>/dev/null

# prepare *.ai: 
chmod a+x /userdata/system/pro/ps2plus/pcsx2/pcsx2.AppImage 2>/dev/null
chmod a+x /userdata/system/pro/ps2plus/pcsx2/pcsx2-AVX2.AppImage 2>/dev/null
chmod a+x /userdata/system/pro/ps2plus/pcsx2/pcsx2-SSE4.AppImage 2>/dev/null

# start appimage: 
if [[ "$(cat /tmp/cpufeatures | grep avx2)" != "" ]]; then 
	if [[ "$(echo "$ROM" | grep "CONFIG")" != "" ]] || [[ "$(echo "$ROM")" = "" ]]; then
		unclutter-remote -s;
			DISPLAY=:0.0 \
			QT_FONT_DPI=128 \
			QT_QPA_PLATFORM=xcb \
			XDG_CONFIG_HOME=/userdata/system/configs \
				/userdata/system/pro/ps2plus/pcsx2/pcsx2.AppImage 1>$log1 2>$log2
	else 
			DISPLAY=:0.0 \
			QT_FONT_DPI=128 \
			QT_QPA_PLATFORM=xcb \
			XDG_CONFIG_HOME=/userdata/system/configs \
				/userdata/system/pro/ps2plus/pcsx2/pcsx2.AppImage -fullscreen -nogui "$ROM" 1>$log1 2>$log2
	fi
else 
	if [[ "$(echo "$ROM" | grep "CONFIG")" != "" ]] || [[ "$(echo "$ROM")" = "" ]]; then
		unclutter-remote -s; 
			DISPLAY=:0.0 \
			QT_FONT_DPI=128 \
			QT_QPA_PLATFORM=xcb \
			XDG_CONFIG_HOME=/userdata/system/configs \
				/userdata/system/pro/ps2plus/pcsx2/pcsx2.AppImage 1>$log1 2>$log2
	else 
			DISPLAY=:0.0 \
			QT_FONT_DPI=128 \
			QT_QPA_PLATFORM=xcb \
			XDG_CONFIG_HOME=/userdata/system/configs \
				/userdata/system/pro/ps2plus/pcsx2/pcsx2.AppImage -fullscreen -nogui "$ROM" 1>$log1 2>$log2
	fi 
fi

sleep 1
/userdata/system/pro/ps2plus/extras/boost.sh 2>/dev/null & 

