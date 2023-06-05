#!/bin/bash
DISPLAY=:0.0 XDG_CONFIG_HOME=/userdata/system/configs XDG_CACHE_HOME=/userdata/saves QT_QPA_PLATFORM=xcb XDG_RUNTIME_DIR=/userdata $(cat /userdata/system/pro/rpcs3/extra/whichrpcs3.cfg) -platform xcb "$1" "$2" "$3" "$4" "$5" "$6" "$7" "$8" "$9"
