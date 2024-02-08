#!/bin/bash
mkdir -p ~/.local
chmod 777 ~/.local
chmod 777 ~/.local/*

echo "starting steam..."
export DISPLAY=:0.0
killall -9 steam steamfix steamfixer 2>/dev/null
sleep 1

# Fix audio permissions 
chown -R root:audio /var/run/pulse
chmod -R g+rwX /var/run/pulse

# Fix directories permissions 
dir1=/userdata/system/pro/steam/home
dir2=/userdata/system/.local/share/Conty
  mkdir -p $dir1 $dir2 2>/dev/null
  chown -R batocera:batocera $dir1 $dir2 2>/dev/null

# Fix ctrl+click bug in openbox 
xbind=/userdata/system/.xbindkeysrc
  rm $xbind 2>/dev/null
  echo '# .xbindkeysrc' >> $xbind
  echo '"xdotool keydown ctrl click 1 keyup ctrl"' >> $xbind
  echo '  b:1 + Release' >> $xbind
  chown -R batocera:batocera "$xbind" 2>/dev/null

eval $(dbus-launch --sh-syntax)
sysctl -w vm.max_map_count=2147483642
ulimit -H -n 819200
ulimit -S -n 819200

unclutter-remote -s

ALLOW_ROOT=1 DISPLAY=:0.0 /userdata/system/pro/steam/conty.sh dbus-run-session steamlauncher "${@}"

unclutter-remote -h
