#!/bin/bash
home=/userdata/system/pro/steam/home
mkdir -p ~/.local /home $home 2>/dev/null
ln -s /userdata/system /home/root 2>/dev/null
chmod -R 777 /var/run/pulse
chmod 777 ~/.local/*
chmod 777 ~/.local

echo -e "\nstarting steam...\n"
export DISPLAY=:0.0
killall -9 steam steamfix steamfixer 2>/dev/null
sleep 0.5

dir1=/userdata/system/pro/steam/home
dir2=/userdata/system/.local/share/Conty
  mkdir -p $dir1 $dir2 2>/dev/null
  chmod 777 $dir1 $dir2 2>/dev/null

# Fix ctrl+click bug in openbox
f=/userdata/system/.xbindkeysrc
  rm $f 2>/dev/null
  echo '# .xbindkeysrc' >> $f
  echo '"xdotool keydown ctrl click 1 keyup ctrl"' >> $f
  echo '  b:1 + Release' >> $f
  chmod 777 $f 2>/dev/null

eval $(dbus-launch --sh-syntax)
sysctl -w vm.max_map_count=2147483642
ulimit -H -n 819200
ulimit -S -n 819200

unclutter-remote -s
ALLOW_ROOT=1 DISPLAY=:0.0 /userdata/system/pro/steam/conty.sh dbus-run-session steam -gamepadui "${@}"
unclutter-remote -h
