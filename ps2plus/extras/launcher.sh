#!/bin/bash

# get rom from generator: 
ROM="$1"

# check cpu features: 
rm /tmp/cpufeatures 2>/dev/null; cat /proc/cpuinfo | grep flags | head -n 1 | grep avx2 >> /tmp/cpufeatures

# prepare logs: 
log1=/userdata/system/logs/ps2plus-out.txt
log2=/userdata/system/logs/ps2plus-err.txt
rm $log1 2>/dev/null; rm $log2 2>/dev/null

# prepare *.ai: 
chmod a+x /userdata/system/pro/ps2plus/pcsx2/pcsx2.AppImage 2>/dev/null
chmod a+x /userdata/system/pro/ps2plus/pcsx2/pcsx2-AVX2.AppImage 2>/dev/null
chmod a+x /userdata/system/pro/ps2plus/pcsx2/pcsx2-SSE4.AppImage 2>/dev/null

# prepare booster:
/userdata/system/pro/ps2plus/extras/boost.sh 2>/dev/null & 

# add env
export XDG_MENU_PREFIX=batocera- 
export XDG_CONFIG_DIRS=/etc/xdg 
export XDG_CURRENT_DESKTOP=XFCE 
export DESKTOP_SESSION=XFCE 

# start appimage: 
if [[ "$(cat /tmp/cpufeatures | grep avx2)" != "" ]]; then 
	if [[ "$(echo "$ROM" | grep "CONFIG")" != "" ]] || [[ "$(echo "$ROM")" = "" ]]; then
		unclutter-remote -s;
			DISPLAY=:0.0 \
			QT_FONT_DPI=128 \
			QT_QPA_PLATFORM=xcb \
			XDG_CONFIG_HOME=/userdata/system/configs \
			XDG_CURRENT_DESKTOP=XFCE \
			DESKTOP_SESSION=XFCE \
				/userdata/system/pro/ps2plus/pcsx2/pcsx2.AppImage > >(tee "$log1") 2> >(tee "$log2" >&2)
	else 
			DISPLAY=:0.0 \
			QT_FONT_DPI=128 \
			QT_QPA_PLATFORM=xcb \
			XDG_CONFIG_HOME=/userdata/system/configs \
			XDG_CURRENT_DESKTOP=XFCE \
			DESKTOP_SESSION=XFCE \
				/userdata/system/pro/ps2plus/pcsx2/pcsx2.AppImage -fullscreen -nogui "$ROM" > >(tee "$log1") 2> >(tee "$log2" >&2)
	fi
else 
	if [[ "$(echo "$ROM" | grep "CONFIG")" != "" ]] || [[ "$(echo "$ROM")" = "" ]]; then
		unclutter-remote -s; 
			DISPLAY=:0.0 \
			QT_FONT_DPI=128 \
			QT_QPA_PLATFORM=xcb \
			XDG_CONFIG_HOME=/userdata/system/configs \
			XDG_CURRENT_DESKTOP=XFCE \
			DESKTOP_SESSION=XFCE \
				/userdata/system/pro/ps2plus/pcsx2/pcsx2.AppImage > >(tee "$log1") 2> >(tee "$log2" >&2)
	else 
			DISPLAY=:0.0 \
			QT_FONT_DPI=128 \
			QT_QPA_PLATFORM=xcb \
			XDG_CONFIG_HOME=/userdata/system/configs \
			XDG_CURRENT_DESKTOP=XFCE \
			DESKTOP_SESSION=XFCE \
				/userdata/system/pro/ps2plus/pcsx2/pcsx2.AppImage -fullscreen -nogui "$ROM" > >(tee "$log1") 2> >(tee "$log2" >&2)
	fi 
fi

