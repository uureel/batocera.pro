#!/bin/bash 

export DISPLAY=:0.0 

if [[ "$(uname -a | awk '{print $3}')" > "6.1" ]]; then 
/etc/init.d/S50avahi-daemon start 2>/dev/null
fi

mkdir -p /usr/lib/x86_64-linux-gnu 2>/dev/null
cp -r /userdata/system/pro/sunshine/extras/gdk-pixbuf-2.0 /usr/lib/x86_64-linux-gnu 2>/dev/null

log1=/userdata/system/pro/sunshine/log1.txt
log2=/userdata/system/pro/sunshine/log2.txt
rm $log1 2>/dev/null ; rm $log2 2>/dev/null 

if [[ "$(ls /usr/share/applications/ | grep "sunshined.desktop")" != "" ]]; then 
        rm /usr/share/applications/sunshined.desktop 2>/dev/null 
        rm /usr/share/applications/sunshine.desktop 2>/dev/null 
        cp /userdata/system/pro/sunshine/extras/sunshine.desktop /usr/share/applications/ 
elif [[ "$(ls /usr/share/applications/ | grep "sunshine.desktop")" != "" ]]; then 
        rm /usr/share/applications/sunshined.desktop 2>/dev/null 
        rm /usr/share/applications/sunshine.desktop 2>/dev/null 
        cp /userdata/system/pro/sunshine/extras/sunshined.desktop /usr/share/applications/ 
fi 

killall -9 sunshine 1>/dev/null 2>/dev/null & sleep 1 
/userdata/system/pro/sunshine/extras/boost.sh 1>/dev/null 2>/dev/null & 
DISPLAY=:0.0 LD_LIBRARY_PATH="/userdata/system/pro/sunshine/extras:${LD_LIBRARY_PATH}" /userdata/system/pro/sunshine/sunshine.AppImage 1>$log1 2>$log2 & 


