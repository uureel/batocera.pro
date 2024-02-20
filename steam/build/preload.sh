#!/bin/bash

##
# reload ld
ldconfig 1>/dev/null 2>/dev/null
  mkdir -p /userdata/system/.local/share/Conty/ld/ 2>/dev/null
    cp -r /etc/ld.so* /userdata/system/.local/share/Conty/ld/ 2>/dev/null

##
# check env
p=/userdata/system/.local/share/Conty/.conty-prime
	if [[ -s "$p" ]]; then
		dos2unix "$p" 2>/dev/null
			while IFS= read -r "$p"; do
				export "$line"
			done < "$file"

##
# remaining env
export DISPLAY=:0.0
eval $(dbus-launch --sh-syntax)
