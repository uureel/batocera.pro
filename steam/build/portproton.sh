#!/bin/bash
sed -i 's,(id -u),(fakeid -u),g' /usr/bin/properportproton 2>/dev/null
if [[ -e ~/.config/PortProton.conf ]]; then
	path=$(cat ~/.config/PortProton.conf | grep "/" | head -n1)
	sed -i 's,(id -u),(fakeid -u),g' "$path/data/scripts/runlib" 2>/dev/null
fi
ulimit -H -n 819200 && ulimit -S -n 819200 && sysctl -w fs.inotify.max_user_watches=8192000 vm.max_map_count=2147483642 fs.file-max=8192000 >/dev/null 2>&1
dbus-run-session /usr/bin/properportproton "${@}"
