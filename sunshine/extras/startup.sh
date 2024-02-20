#!/bin/bash

#####################################################################################

export DISPLAY=:0.0

#####################################################################################

if [[ -e /userdata/system/pro/sunshine/batocera-sunshine ]]; then
  ln -sf /userdata/system/pro/sunshine/batocera-sunshine /usr/bin/batocera-sunshine
  chmod 777 /usr/bin/batocera-sunshine 2>/dev/null
fi

#####################################################################################

display_available() {
    DISPLAY=:0.0 xset q >/dev/null 2>&1
    return $?
}

# Main loop to wait for X server
while true; do
    if display_available; then
        break
    fi
    sleep 1
done

#####################################################################################

sleep 3

DISPLAY=:0.0 su - root -c "/userdata/system/pro/sunshine/batocera-sunshine start"

exit 0
