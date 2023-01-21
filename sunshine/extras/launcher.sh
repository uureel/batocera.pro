#!/bin/bash 
if [[ "$(ls /usr/share/applications/ | grep "sunshined.desktop")" != "" ]]; then 
        rm /usr/share/applications/sunshined.desktop 2>/dev/null 
        rm /usr/share/applications/sunshine.desktop 2>/dev/null 
        cp /userdata/system/pro/sunshine/extra/sunshine.desktop /usr/share/applications/ 
elif [[ "$(ls /usr/share/applications/ | grep "sunshine.desktop")" != "" ]]; then 
        rm /usr/share/applications/sunshined.desktop 2>/dev/null 
        rm /usr/share/applications/sunshine.desktop 2>/dev/null 
        cp /userdata/system/pro/sunshine/extra/sunshined.desktop /usr/share/applications/ 
fi 
killall -9 sunshine 1>/dev/null 2>/dev/null & 
sleep 1 
/userdata/system/pro/sunshine/extras/boost.sh & 
/userdata/system/pro/sunshine/sunshine.AppImage 
 
