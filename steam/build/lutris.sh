#!/bin/bash

ulimit -H -n 819200 && ulimit -S -n 819200 && sysctl -w fs.inotify.max_user_watches=8192000 vm.max_map_count=2147483642 fs.file-max=8192000 >/dev/null 2>&1

export XDG_CURRENT_DESKTOP=XFCE
export DESKTOP_SESSION=XFCE
export NO_AT_BRIDGE=1
export GTK_A11Y=none
export DISPLAY=:0.0
export GDK_SCALE=1
export USER=root

dbus-run-session /opt/lutris/bin/lutris "${@}"
