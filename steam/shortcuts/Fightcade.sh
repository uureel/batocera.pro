#!/bin/bash
#------------------------------------------------
function update_launcher() {
  tmp=/tmp/.fc && rm $tmp 2>/dev/null
  launcher="/userdata/system/pro/steam/batocera-fightcade.sh"
  link="https://raw.githubusercontent.com/uureel/batocera.pro/main/steam/shortcuts/batocera-fightcade.sh"
    wget -q --tries=30 --no-check-certificate --no-cache --no-cookies -O "$tmp" "$link"
      if [[ -s "$tmp" ]]; then cp "$tmp" "$launcher" && rm "$tmp"; else exit 1; fi
        chmod 777 "$launcher" 2>/dev/null && dos2unix "$launcher" 2>/dev/null
}
update_launcher
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
  bash -c 'prepare && source /opt/env && cp /userdata/system/pro/steam/batocera-fightcade.sh /opt/fightcade2/batocera-fightcade.sh && dbus-run-session /opt/fightcade2/batocera-fightcade.sh'
#------------------------------------------------
# batocera-mouse hide
#------------------------------------------------
