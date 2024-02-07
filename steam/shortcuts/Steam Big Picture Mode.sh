#!/bin/bash
mkdir -p ~/.local
chmod 777 ~/.local
chmod 777 ~/.local/*
chown -R root:audio /var/run/pulse
chmod -R g+rwX /var/run/pulse

unclutter-remote -s

dir1=/userdata/system/pro/steam/home
dir2=/userdata/system/.local/share/Conty
dir3=/userdata/system/.cache
mkdir -p $dir1 $dir2 $dir3 2>/dev/null
chown -R batocera:batocera $dir1 $dir2 $dir3 2>/dev/null

#su - batocera -c "dbus-launch --sh-syntax & DISPLAY=:0.0 HOME_DIR=/userdata/system/pro/steam/home ~/pro/steam/conty.sh dbus-run-session steam -gamepadui"
ALLOW_ROOT=1 DISPLAY=:0.0 /userdata/system/pro/steam/conty.sh dbus-run-session steam -gamepadui