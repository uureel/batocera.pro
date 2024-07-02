#!/bin/bash
#------------------------------------------------
conty=/userdata/system/pro/steam/conty.sh
#------------------------------------------------
batocera-mouse show
killall -9 steam steamfix steamfixer 2>/dev/null
#------------------------------------------------
  "$conty" \
          --bind /userdata/system/containers/storage /var/lib/containers/storage \
          --bind /userdata/system/flatpak /var/lib/flatpak \
          --bind /userdata/system/etc/passwd /etc/passwd \
          --bind /userdata/system/etc/group /etc/group \
          --bind /var/run/nvidia /var/run/nvidia \
          --bind /userdata/system /home/batocera \
          --bind /sys/fs/cgroup /sys/fs/cgroup \
          --bind /userdata/system /home/root \
          --bind /etc/fonts /etc/fonts \
          --bind /userdata /userdata \
          --bind /newroot /newroot \
          --bind / /batocera \
  xterm -fs 12 -maximized -fg white -bg black -fa "DejaVuSansMono" -en UTF-8 -e bash -c 'prepare && source /opt/env && ulimit -H -n 819200 && ulimit -S -n 819200 && sysctl -w fs.inotify.max_user_watches=8192000 vm.max_map_count=2147483642 fs.file-max=8192000 >/dev/null 2>&1 && DISPLAY=:0.0 dbus-run-session portproton '"${@}"''
#------------------------------------------------
# batocera-mouse hide
#------------------------------------------------
