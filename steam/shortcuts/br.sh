#!/bin/bash
mkdir -p ~/.local
chmod 777 ~/.local
chmod 777 ~/.local/*


unclutter-remote -s

ALLOW_ROOT=1  HOME_DIR="/userdata/system/pro/steam/home" DISPLAY=:0.0 ~/pro/steam/conty.sh  env QT_QPA_PLATFORM=xcb mcpelauncher --appimage-extract-and-run
