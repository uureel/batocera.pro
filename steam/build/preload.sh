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
			    # Export if line matches the pattern var=value
			    if [[ "$line" =~ ^[a-zA-Z_]+[a-zA-Z0-9_]*=.*$ ]]; then
			        export "$line"
			    fi
			done < "$file"

##
# remaining env
export DISPLAY=:0.0
eval $(dbus-launch --sh-syntax)
