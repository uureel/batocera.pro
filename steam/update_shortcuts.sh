#!/bin/bash

github_url="https://github.com/uureel/batocera.pro/raw/main/steam/shortcuts/"
target_directory="/userdata/roms/conty/"
# List of .sh files to download
sh_files=(
"Antimicrox.sh"
"AppImage-Pool.sh"
"Audacity.sh"
"Balena-Etcher.sh"
"Blender.sh"
"Boilr.sh"
"Bottles.sh"
"Brave.sh"
"Chiaki.sh"
"FileManager-Dolphin.sh"
"FileManager-DoubleCmd.sh"
"FileManager-Krusader.sh"
"FileManager-Nemo.sh"
"FileManager-PCManFM.sh"
"FileManager-Thunar.sh"
"Filezilla.sh"
"Firefox.sh"
"Flatpak-Config.sh"
"FreeFileSync.sh"
"GameHub.sh"
"Geforce Now.sh"
"Gimp.sh"
"Google-Chrome.sh"
"Gparted.sh"
"Greenlight.sh"
"Gthumb.sh"
"Handbrake.sh"
"Heroic Game Launcher.sh"
"Hulu.sh"
"Inkscape.sh"
"Kdenlive.sh"
"Kodi.sh"
"Libreoffice.sh"
"Lutris.sh"
"Microsoft-Edge.sh"
"Minigalaxy.sh"
"Moonlight.sh"
"Netflix.sh"
"OBS Studio.sh"
"Peazip.sh"
"Play on Linux 4.sh"
"Protonup-Qt.sh"
"Qbittorrent.sh"
"Qdirstat.sh"
"Shotcut.sh"
"Smplayer.sh"
"Spotify.sh"
"Steam Big Picture Mode.sh"
"Steam Diagnostic.sh"
"Steam.sh"
"SteamTinker Launch (settings).sh"
"SublimeText.sh"
"Terminal-Kitty.sh"
"Terminal-Lxterminal.sh"
"Terminal-Tabby.sh"
"Terminal-Terminator.sh"
"Thunderbird.sh"
"TigerVNC.sh"
"VLC.sh"
"WineGUI.sh"
"Zoom.sh"
)
# List of .sh files to remove
old_sh_files=(
  "Antimicrox.sh"
  "Audacity.sh"
  "Balena-Etcher.sh"
  "Boilr.sh"
  "Brave.sh"
  "Firefox.sh"
  "GameHub.sh"
  "Geforce Now.sh"
  "Gimp.sh"
  "Google-Chrome.sh"
  "Gparted.sh"
  "Greenlight.sh"
  "Heroic Game Launcher.sh"
  "Inkscape.sh" 
  "Kdenlive.sh"
  "Kodi.sh"
  "Libreoffice.sh"
  "Lutris.sh"
  "Microsoft-Edge.sh"
  "Minigalaxy.sh"
  "Moonlight.sh"
  "OBS Studio.sh"
  "Opera.sh"
  "PCManFM (File Manager).sh"
  "Peazip.sh"
  "Play on Linux 4.sh"
  "Protonup-Qt.sh"
  "Qbittorrent.sh"
  "Qdirstat.sh"
  "Smplayer.sh"
  "Shotcut.sh"
  "Steam Big Picture Mode.sh"
  "Steam.sh"
  "SteamTinker Launch (settings).sh"
  "Terminal.sh"
  "Thunderbird.sh"
  "VLC.sh"
  "Zoom.sh"
)
mkdir -p "$target_directory"
  # Remove old version .sh files
  for file in "${old_sh_files[@]}"; do
    rm "${target_directory}${file}" 2>/dev/null
  done
    for file in "${sh_files[@]}"; do
      # Replace spaces with '%20' for URL encoding
      encoded_file=$(echo "$file" | sed 's/ /%20/g')
      echo "Downloading $file..."
        wget -q --tries=30 --no-check-certificate --no-cache --no-cookies -O "${target_directory}${file}" "${github_url}${encoded_file}" &
      sleep 0.05
    done
      wait
        dos2unix "${target_directory}"/*.sh 2>/dev/null
          chmod 777 "${target_directory}"/*.sh 2>/dev/null

echo "Downloaded shortcuts."
sleep 1

#hmm,why?# rm /userdata/roms/steam2/*.sh 2>/dev/null
rm /userdata/system/configs/emulationstation/es_features_steam2.cfg 2>/dev/null

echo "Downloading parsers and custom systems..."
  wget -q --tries=30 --no-check-certificate --no-cache --no-cookies -O /userdata/roms/steam2/+UPDATE-STEAM-SHORTCUTS.sh https://raw.githubusercontent.com/uureel/batocera.pro/main/steam/shortcuts/%2BUPDATE-STEAM-SHORTCUTS.sh
  dos2unix /userdata/roms/steam2/+UPDATE-STEAM-SHORTCUTS.sh 2>/dev/null
  chmod +x /userdata/roms/steam2/+UPDATE-STEAM-SHORTCUTS.sh

    wget -q --tries=30 --no-check-certificate --no-cache --no-cookies -O /userdata/system/configs/emulationstation/es_systems_arch.cfg https://github.com/uureel/batocera.pro/raw/main/steam/shortcuts/es_configs/es_systems_arch.cfg &
    wget -q --tries=30 --no-check-certificate --no-cache --no-cookies -O /userdata/system/configs/emulationstation/es_features_arch.cfg https://github.com/uureel/batocera.pro/raw/main/steam/shortcuts/es_configs/es_features_arch.cfg &
    wget -q --tries=30 --no-check-certificate --no-cache --no-cookies -O /userdata/system/configs/emulationstation/es_systems_steam2.cfg https://github.com/uureel/batocera.pro/raw/main/steam/shortcuts/es_configs/es_systems_steam2.cfg &
    wget -q --tries=30 --no-check-certificate --no-cache --no-cookies -O /userdata/system/configs/emulationstation/es_features_steam2.cfg https://github.com/uureel/batocera.pro/raw/main/steam/shortcuts/es_configs/es_features_steam2.cfg &
    #
    wget -q --tries=30 --no-check-certificate --no-cache --no-cookies -O /userdata/system/configs/evmapy/Arch.keys https://github.com/uureel/batocera.pro/raw/main/steam/shortcuts/es_configs/keys/Arch.keys &
    wget -q --tries=30 --no-check-certificate --no-cache --no-cookies -O /userdata/system/configs/evmapy/Lutris.keys https://github.com/uureel/batocera.pro/raw/main/steam/shortcuts/es_configs/keys/Lutris.keys &
    wget -q --tries=30 --no-check-certificate --no-cache --no-cookies -O /userdata/system/configs/evmapy/Lutris.keys https://github.com/uureel/batocera.pro/raw/main/steam/shortcuts/es_configs/keys/lutris.keys &
    wget -q --tries=30 --no-check-certificate --no-cache --no-cookies -O /userdata/system/configs/evmapy/Heroic2.keys https://github.com/uureel/batocera.pro/raw/main/steam/shortcuts/es_configs/keys/Heroic2.keys &
    wget -q --tries=30 --no-check-certificate --no-cache --no-cookies -O /userdata/system/configs/evmapy/Heroic2.keys https://github.com/uureel/batocera.pro/raw/main/steam/shortcuts/es_configs/keys/heroic2.keys &
    wget -q --tries=30 --no-check-certificate --no-cache --no-cookies -O /userdata/system/configs/evmapy/steam2.keys https://github.com/uureel/batocera.pro/raw/main/steam/shortcuts/es_configs/keys/steam2.keys &
    wget -q --tries=30 --no-check-certificate --no-cache --no-cookies -O /userdata/system/configs/evmapy/steam.keys https://github.com/uureel/batocera.pro/raw/main/steam/shortcuts/es_configs/keys/steam.keys &
    #
    wget -q --tries=30 --no-check-certificate --no-cache --no-cookies -O /userdata/system/pro/steam/batocera-conty-patcher.sh https://raw.githubusercontent.com/uureel/batocera.pro/main/steam/build/batocera-conty-patcher.sh &
        wait
            dos2unix /userdata/system/configs/evmapy/*.keys 2>/dev/null
            dos2unix /userdata/system/pro/steam/batocera-conty-patcher.sh 2>/dev/null
                chmod 777 /userdata/system/pro/steam/batocera-conty-patcher.sh 2>/dev/null

# lutris
if [[ -e /userdata/system/configs/emulationstation/es_systems_lutris.cfg ]]; then 
    wget -q --tries=30 --no-check-certificate --no-cache --no-cookies -O /userdata/system/configs/emulationstation/es_systems_lutris.cfg https://github.com/uureel/batocera.pro/raw/main/steam/shortcuts/es_configs/es_systems_lutris.cfg &
    wget -q --tries=30 --no-check-certificate --no-cache --no-cookies -O /userdata/system/configs/emulationstation/es_features_lutris.cfg https://github.com/uureel/batocera.pro/raw/main/steam/shortcuts/es_configs/es_features_lutris.cfg &
    wget -q --tries=30 --no-check-certificate --no-cache --no-cookies -O /userdata/system/configs/evmapy/Lutris.keys https://github.com/uureel/batocera.pro/raw/main/steam/shortcuts/es_configs/keys/Lutris.keys &
    wget -q --tries=30 --no-check-certificate --no-cache --no-cookies -O /userdata/system/configs/evmapy/Lutris.keys https://github.com/uureel/batocera.pro/raw/main/steam/shortcuts/es_configs/keys/lutris.keys &
        wait
            dos2unix /userdata/system/configs/evmapy/*.keys 2>/dev/null
fi

# heroic
if [[ -e /userdata/system/configs/emulationstation/es_systems_heroic2.cfg ]]; then 
    wget -q --tries=30 --no-check-certificate --no-cache --no-cookies -O /userdata/system/configs/emulationstation/es_systems_heroic2.cfg https://github.com/uureel/batocera.pro/raw/main/steam/shortcuts/es_configs/es_systems_heroic2.cfg &
    wget -q --tries=30 --no-check-certificate --no-cache --no-cookies -O /userdata/system/configs/emulationstation/es_features_heroic2.cfg https://github.com/uureel/batocera.pro/raw/main/steam/shortcuts/es_configs/es_features_heroic2.cfg &
    wget -q --tries=30 --no-check-certificate --no-cache --no-cookies -O /userdata/system/configs/evmapy/Heroic2.keys https://github.com/uureel/batocera.pro/raw/main/steam/shortcuts/es_configs/keys/Heroic2.keys &
    wget -q --tries=30 --no-check-certificate --no-cache --no-cookies -O /userdata/system/configs/evmapy/Heroic2.keys https://github.com/uureel/batocera.pro/raw/main/steam/shortcuts/es_configs/keys/heroic2.keys &
        wait
            dos2unix /userdata/system/configs/evmapy/*.keys 2>/dev/null
fi 

rm /userdata/system/pro/steam/prepare.sh 2>/dev/null

sleep 2

echo "Done."

# Reload emulationstation
curl http://127.0.0.1:1234/reloadgames
