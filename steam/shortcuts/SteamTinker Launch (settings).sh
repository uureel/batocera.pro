#!/bin/bash
mkdir -p ~/.local
chmod 777 ~/.local
chmod 777 ~/.local/*
chown -R root:audio /var/run/pulse
chmod -R g+rwX /var/run/pulse

unclutter-remote -s
ALLOW_ROOT=1 DISPLAY=:0.0 ~/pro/steam/conty.sh dbus-run-session steamtinkerlaunch settings "${@}"
#su - batocera -c "HOME_DIR=\"/userdata/system/pro/steam/home\" DISPLAY=:0.0 ~/pro/steam/conty.sh steamtinkerlaunch settings"
