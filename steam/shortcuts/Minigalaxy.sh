#!/bin/bash
#------------------------------------------------
conty=/userdata/system/pro/steam/conty.sh
#------------------------------------------------
batocera-mouse show
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
  bash -c 'prepare && source /opt/env && minigalaxy '"${@}"''
#------------------------------------------------
# batocera-mouse hide
#------------------------------------------------
