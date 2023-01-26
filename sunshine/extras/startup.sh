#!/bin/bash 

export DISPLAY=:0.0 

cp /userdata/system/pro/sunshine/extras/lib* /lib/ 2>/dev/null

log1=/userdata/system/pro/sunshine/log1.txt
log2=/userdata/system/pro/sunshine/log2.txt
rm $log1 2>/dev/null ; rm $log2 2>/dev/null 

cp /userdata/system/pro/sunshine/extras/sunshine.desktop /usr/share/applications/ 2>/dev/null ; sleep 10 

su -c "DISPLAY=:0.0 /bin/bash /userdata/system/pro/sunshine/launcher.sh &" & 

sleep 5 

if [[ "$(cat /usr/share/applications/sunshine.desktop | grep sunshined.png)" != "" ]]; then 
cp /userdata/system/pro/sunshine/extras/sunshine.desktop /usr/share/applications/sunshine.desktop 
fi 

