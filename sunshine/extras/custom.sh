#!/bin/bash

mkdir -p /userdata/system/.config/sunshine

if [[ ! -f /userdata/system/.config/sunshine/apps.json ]]; then
cp /userdata/system/pro/sunshine/extras/apps.json /userdata/system/.config/sunshine/
fi

if [[ ! -f /userdata/system/.config/sunshine/sunshine.conf ]]; then
cp /userdata/system/pro/sunshine/extras/sunshine.conf /userdata/system/.config/sunshine/
fi

dos2unix /userdata/system/pro/sunshine/extras/startup.sh 
chmod a+x /userdata/system/pro/sunshine/extras/startup.sh 

/userdata/system/pro/sunshine/extras/startup.sh 

