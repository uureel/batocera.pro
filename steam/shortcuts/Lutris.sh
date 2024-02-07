#!/bin/bash
mkdir -p ~/.local
chmod 777 ~/.local
chmod 777 ~/.local/*
chown -R root:audio /var/run/pulse
chmod -R g+rwX /var/run/pulse

dir1=/userdata/system/pro/steam/home
dir2=/userdata/system/.local/share/Conty
dir3=/userdata/system/.cache
mkdir -p $dir1 $dir2 $dir3 2>/dev/null
chown -R batocera:batocera $dir1 $dir2 $dir3 2>/dev/null

eval $(dbus-launch --sh-syntax)

unclutter-remote -s

#su - batocera -c "HOME_DIR=\"/userdata/system/pro/steam/home\" DISPLAY=:0.0 ~/pro/steam/conty.sh dbus-run-session lutris"
ALLOW_ROOT=1 HOME_DIR=/userdata/system/pro/steam/home DISPLAY=:0.0 ~/pro/steam/conty.sh dbus-run-session lutris "${@}"