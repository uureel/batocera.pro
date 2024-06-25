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
          --bind /userdata/roms/snes "/opt/fightcade2/SNES9x ROMs" \
          --bind /userdata/roms/fbneo "/opt/fightcade2/FBNeo ROMs" \
          --bind /userdata/roms/dreamcast "/opt/fightcade2/Flycast ROMs" \
          --bind /userdata/roms/snes /opt/fightcade2/emulator/snes9x/ROMs \
          --bind /userdata/roms/fbneo /opt/fightcade2/emulator/fbneo/ROMs \
          --bind /userdata/roms/dreamcast /opt/fightcade2/emulator/flycast/ROMs \
  bash -c 'prepare && dbus-run-session /opt/fightcade2/fc2-electron/fc2-electron --no-sandbox'
#------------------------------------------------
# batocera-mouse hide
#------------------------------------------------
