#!/bin/bash

cd /userdata/system/pro/sunshine/extras
yes "Y" | unzip -qq gdk-pixbuf-2.0.zip 2>/dev/null
cd /userdata/system 

mkdir -p /usr/lib/x86_64-linux-gnu 2>/dev/null
cp -r /userdata/system/pro/sunshine/extras/gdk-pixbuf-2.0 /usr/lib/x86_64-linux-gnu 2>/dev/null

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

