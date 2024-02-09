#!/bin/bash
home=/userdata/system/pro/steam/home
mkdir -p ~/.local /home $home 2>/dev/null
ln -s /userdata/system /home/root 2>/dev/null
chmod -R 777 /var/run/pulse
chmod 777 ~/.local/*
chmod 777 ~/.local

dir1=/userdata/system/pro/steam/home
dir2=/userdata/system/.local/share/Conty
dir3=/userdata/system/.cache
mkdir -p $dir1 $dir2 $dir3 2>/dev/null
chown -R batocera:batocera $dir1 $dir2 $dir3 2>/dev/null

eval $(dbus-launch --sh-syntax)

unclutter-remote -s

ALLOW_ROOT=1 DISPLAY=:0.0 HOME_DIR=$home ~/pro/steam/conty.sh dbus-run-session brave --no-sandbox --test-type "${@}"
