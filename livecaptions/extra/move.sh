#!/bin/bash

# redundant check
if [[ "$(uname -m)" != "x86_64" ]] || [[ "$(which flatpak)" == *"not found"* ]]; then
  echo "this system is not supported." 
  exit 1
fi

# link xdotool
if [[ -e /userdata/system/pro/livecaptions/extra/xdotool ]]; then
  rm /usr/bin/xdotool 2>/dev/null
  ln -sf /userdata/system/pro/livecaptions/extra/xdotool /usr/bin/xdotool 2>/dev/null
fi

# link wmctrl
if [[ -e /userdata/system/pro/livecaptions/extra/wmctrl ]]; then
  rm /usr/bin/wmctrl 2>/dev/null
  ln -sf /userdata/system/pro/livecaptions/extra/wmctrl /usr/bin/wmctrl 2>/dev/null
fi

# wait until both livecaptions and es are (re)loaded
check() {
    local process_name="$1"
    pidof $process_name > /dev/null 2>&1
}

# move livecaptions to top of screen
move() {
    res=$(xrandr | grep '*' | awk '{print $1}' | head -1)
     sw=$(echo "$res" | cut -d "x" -f1)
     sh=$(echo "$res" | cut -d "x" -f2)

    c=$(wmctrl -lG | grep 'Live Captions')
     cw=$(echo "$c" | awk '{print $5}')
     ch=$(echo "$c" | awk '{print $6}')
     cx=$(echo "$c" | awk '{print $3}')
     cy=$(echo "$c" | awk '{print $4}')
     nx=$(( ($sw - $cw) / 2 ))
     #ny=$(( 0 + ($sh * 3 / 100) ))
     ny=0

    id=$(xdotool search --name "Live Captions" | head -n1)

    xdotool windowmove "$id" "$nx" "$ny"
}

# focus back on emulationstation
focus() {
    local window_name="${1}"
    local window_id=$(xdotool search --pid "$(pidof emulationstation)")
    if [ -n "$window_id" ]; then
        xdotool windowactivate $window_id
    fi
}

# wait for es and livecaptions
watcher() {
wait="${1}"
while true; do
    check "emulationstation"
    emulationStationActive=$?
    check "livecaptions"
    liveCaptionsActive=$?
    if [ $emulationStationActive -eq 0 ] && [ $liveCaptionsActive -eq 0 ]; then
        move
        focus "emulationstation"
        break
    fi
    sleep "$wait"
done
}

watcher "1"

exit 0
