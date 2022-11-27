#!/bin/bash
###################
WINDOWSCALE="1.25"
###################
unclutter-remote -s
function rpcs3-config() {
XDG_CONFIG_HOME=/userdata/system/configs \
XDG_CACHE_HOME=/userdata/saves \
XDG_RUNTIME_DIR=/userdata \
QT_QPA_PLATFORM=xcb \
SCALE=$1 QT_SCALE_FACTOR=${SCALE} GDK_SCALE=${SCALE} DISPLAY=:0.0 \
/usr/bin/rpcs3 -platform xcb
}
rpcs3-config "$WINDOWSCALE"