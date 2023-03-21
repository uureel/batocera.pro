#!/bin/bash

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
chmod -R a+rwx /userdata/saves/flatpak
chown -R batocera:batocera /userdata/saves/flatpak/data
chmod -R a+rX /userdata/saves/flatpak/binaries
chmod a+rx /userdata /userdata/saves /userdata/saves/flatpak

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
flatpak run org.citra_emu.citra 1>$log1 2>$log2
else 
DISPLAY=:0.0 \
QT_FONT_DPI=128 \
QT_SCALE_FACTOR=$SCALE \
XDG_CONFIG_HOME=/userdata/system/configs \
XDG_CACHE_HOME=/userdata/saves \
XDG_RUNTIME_DIR=/userdata \
QT_QPA_PLATFORM=xcb \
flatpak run org.citra_emu.citra "$ROM" 1>$log1 2>$log2
fi

sleep 1

#-----------------------
#citra-dual@bato-openbox
#-----------------------
#
#prepare xdotool 
cp /userdata/system/pro/3dsplus/xdotool /usr/bin/ 
cp /userdata/system/pro/3dsplus/libxdo.so.3 /lib/
#
#get screen size
res=$(xrandr | grep " connected" | awk '{print $3}' | cut -d "+" -f1)
w=$(echo "$res" | cut -d "x" -f1)
h=$(echo "$res" | cut -d "x" -f2)
#
#get citra windows ids 
main=$(xdotool search --classname citra-qt | sort | head -n1)
aux=$(xdotool search --classname citra-qt | sort | tail -n1) 
#
#position windows / main 
xdotool windowsize "$main" $(($w-550)) $(($h+80))
xdotool windowmove "$main" 0 -40
#
#position windows / aux 
xdotool windowsize "$aux" 550 $h
xdotool windowmove "$aux" $(($w-550)) 0
#
#(citra top&bottom toolbar height = 40px)


/userdata/system/pro/ps3plus/extras/boost.sh 2>/dev/null & 

