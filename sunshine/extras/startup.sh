#!/bin/bash 
cp /userdata/system/fi/sunshine/extras/sunshine.desktop /usr/share/applications/ 2>/dev/null ; sleep 10 
su -c "DISPLAY=:0.0 /bin/bash /userdata/system/fi/sunshine/launcher.sh 1>/dev/null 2>/dev/null &" & 
sleep 5 
if [[ "$(cat /usr/share/applications/sunshine.desktop | grep sunshined.png)" != "" ]]; then 
cp /userdata/system/fi/sunshine/extras/sunshine.desktop /usr/share/applications/sunshine.desktop 
fi 
 
