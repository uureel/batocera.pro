#!/bin/bash
sed -i 's,(id -u),(fakeid -u),g' /usr/bin/properportproton 2>/dev/null
if [[ -e ~/.config/PortProton.conf ]]; then
	path=$(cat ~/.config/PortProton.conf | grep "/" | head -n1)
	sed -i 's,(id -u),(fakeid -u),g' "$path/data/scripts/runlib" 2>/dev/null
fi
dbus-run-session /usr/bin/properportproton "${@}"
