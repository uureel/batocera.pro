#!/bin/bash

export DISPLAY=:0.0 

xterm -fullscreen -fg black -bg black -fa Monospace -en UTF-8 -e bash -c "read ENTER && sleep 10" 2>/dev/null
su -c "su -c "su -c "DISPLAY=:0.0 ~/pro/3dsplus/extras/citra-dual-openbox.sh""" root & 

# get rom from generator: 
ROM="$@"

# prepare logs: 
log1=/userdata/system/pro/3dsplus/log1.txt
log2=/userdata/system/pro/3dsplus/log2.txt
rm $log1 2>/dev/null; rm $log2 2>/dev/null

# prepare exec
#chmod a+x /userdata/system/pro/3dsplus/citra/citra-room 2>/dev/null
#chmod a+x /userdata/system/pro/3dsplus/citra/citra-qt 2>/dev/null
#chmod a+x /userdata/system/pro/3dsplus/citra/citra 2>/dev/null
#ln -sf /userdata/system/pro/3dsplus/citra/citra /usr/bin/citra 2>/dev/null
#ln -sf /userdata/system/pro/3dsplus/citra/citra-qt /usr/bin/citra-qt 2>/dev/null
#ln -sf /userdata/system/pro/3dsplus/citra/citra-room /usr/bin/citra-room 2>/dev/null

# prepare flatpak
#chmod -R a+rwx /userdata/saves/flatpak
#chown -R batocera:batocera /userdata/saves/flatpak/data
#chmod -R a+rX /userdata/saves/flatpak/binaries
#chmod a+rx /userdata /userdata/saves /userdata/saves/flatpak

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

# start: 
if [[ "$(echo "$ROM" | grep "CONFIG")" != "" ]] || [[ "$(echo "$ROM")" = "" ]]; then
	unclutter-remote -s; 
	DISPLAY=:0.0 \
	QT_FONT_DPI=128 \
	QT_SCALE_FACTOR=$SCALE \
	XDG_CONFIG_HOME=/userdata/system/configs \
	XDG_CACHE_HOME=/userdata/saves \
	XDG_RUNTIME_DIR=/userdata \
	QT_QPA_PLATFORM=xcb \
	flatpak run org.citra_emu.citra 1>$log1 2>$log2 &
else 
	DISPLAY=:0.0 \
	QT_FONT_DPI=128 \
	QT_SCALE_FACTOR=$SCALE \
	XDG_CONFIG_HOME=/userdata/system/configs \
	XDG_CACHE_HOME=/userdata/saves \
	XDG_RUNTIME_DIR=/userdata \
	QT_QPA_PLATFORM=xcb \
	flatpak run org.citra_emu.citra "$ROM" 1>$log1 2>$log2 & 
	~/pro/3dsplus/extras/citra-dual-openbox.sh & 

fi

/userdata/system/pro/3dsplus/extras/boost.sh 2>/dev/null & 

