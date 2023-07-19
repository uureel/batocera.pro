#!/bin/bash 

export DISPLAY=:0.0 

if [[ "$(uname -a | awk '{print $3}')" > "6.1" ]]; then 
/etc/init.d/S50avahi-daemon start 2>/dev/null
fi

if [[ "$(ls /usr/share/applications/ | grep "sunshined.desktop")" != "" ]]; then 
        rm /usr/share/applications/sunshined.desktop 2>/dev/null 
        rm /usr/share/applications/sunshine.desktop 2>/dev/null 
                cp /userdata/system/pro/sunshine/extras/sunshine.desktop /usr/share/applications/ 
elif [[ "$(ls /usr/share/applications/ | grep "sunshine.desktop")" != "" ]]; then 
        rm /usr/share/applications/sunshined.desktop 2>/dev/null 
        rm /usr/share/applications/sunshine.desktop 2>/dev/null 
                cp /userdata/system/pro/sunshine/extras/sunshined.desktop /usr/share/applications/ 
fi 

DISPLAY=:0.0 /userdata/system/pro/sunshine/batocera-sunshine restart & 
