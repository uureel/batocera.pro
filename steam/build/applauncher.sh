#!/bin/bash
#------------------------------------------------
conty=/userdata/system/pro/steam/conty.sh
#------------------------------------------------
# show mouse
  unclutter-remote -s
#------------------------------------------------
# run
"$conty" \
--bind /userdata/system/containers/storage /var/lib/containers/storage \
--bind /userdata/system/flatpak /var/lib/flatpak \
--bind /userdata/system/etc/passwd /etc/passwd \
--bind /userdata/system/etc/group /etc/group \
--bind /var/run/nvidia /var/run/nvidia \
--bind /sys/fs/cgroup /sys/fs/cgroup \
--bind /etc/fonts /etc/fonts \
--bind /userdata /userdata \
--bind /newroot /newroot \
--bind / /batocera \
bash -c "prepare && fish ${@}"
#------------------------------------------------
# hide mouse
  unclutter-remote -h
#------------------------------------------------