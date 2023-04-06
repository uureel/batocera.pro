#!/bin/bash

app=plexamp
prefix=/userdata/system/pro
chmod a+x $prefix/$app/$app.AppImage 2>/dev/null

unclutter-remote -s

if [[ "$1" != "" ]]; then
DISPLAY=:0.0 $prefix/$app/$app.AppImage "$@"
else 
DISPLAY=:0.0 $prefix/$app/$app.AppImage
fi

