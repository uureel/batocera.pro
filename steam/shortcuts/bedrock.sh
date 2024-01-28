#!/bin/bash
mkdir -p ~/.local
chmod 777 ~/.local
chmod 777 ~/.local/*
chown -R root:audio /var/run/pulse
chmod -R g+rwX /var/run/pulse

unclutter-remote -s


eval $(dbus-launch --sh-syntax)
su - batocera -c "HOME_DIR="/userdata/system/pro/bedrock/home" DISPLAY=:0.0 ~/pro/bedrock/conty.sh mcpelauncher --appimage-extract-and-run"
