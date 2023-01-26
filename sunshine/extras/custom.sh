#!/bin/bash

mkdir -p /userdata/system/.config/$app
cp /userdata/system/pro/sunshine/extras/apps.json /userdata/system/.config/$app/
cp /userdata/system/pro/sunshine/extras/sunshine.conf /userdata/system/.config/sunshine/

dos2unix /userdata/system/pro/sunshine/extras/startup.sh 
chmod a+x /userdata/system/pro/sunshine/extras/startup.sh 
/userdata/system/pro/sunshine/extras/startup.sh 
