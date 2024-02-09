#!/bin/bash
home=/userdata/system/pro/steam/home
mkdir -p ~/.local /home $home 2>/dev/null
ln -s /userdata/system /home/root 2>/dev/null
chmod -R 777 /var/run/pulse
chmod 777 ~/.local/*
chmod 777 ~/.local
chown root:root $home 2>/dev/null
chown root:root /home 2>/dev/null
chown root:root /home/root 2>/dev/null
chown root:root /home/root/.config 2>/dev/null

unclutter-remote -s

ALLOW_ROOT=1 DISPLAY=:0.0 HOME_DIR=$home ~/pro/steam/conty.sh dbus-run-session /usr/lib/firefox/firefox "${@}"
