#!/bin/bash

github_url="https://github.com/uureel/batocera.pro/raw/main/steam/shortcuts/"
target_directory="/userdata/roms/conty/"

# List of .sh files to download
sh_files=(
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

# Create the target directory if it doesn't exist
mkdir -p "$target_directory"

# Download the specified .sh files and make them executable
for file in "${sh_files[@]}"; do
  # Replace spaces with '%20' for URL encoding
  encoded_file=$(echo "$file" | sed 's/ /%20/g')
  echo "Downloading $file..."
  #curl -sSL "${github_url}${encoded_file}" -o "${target_directory}${file}"
  wget -q --tries=10 --no-check-certificate --no-cache --no-cookies -O "${target_directory}${file}" "${github_url}${encoded_file}"
  chmod +x "${target_directory}${file}"
done


# Target directory
DIRECTORY="/userdata/roms/steam2"

# Find and delete all .sh files within the specified directory
find "$DIRECTORY" -type f -name "*.sh" -exec rm -f {} +

echo "All .sh files in $DIRECTORY have been deleted."


# Download the file
curl -L "$FILE_URL" -o "$TARGET_FILE"

# Make the downloaded file executable
chmod +x "$TARGET_FILE"

echo "Downloaded and made executable: $TARGET_FILE"
sleep2

rm -rf /userdata/roms/steam2/*.sh
wget https://github.com/uureel/batocera.pro/raw/main/steam/shortcuts/es_configs/es_features_steam2.cfg -P ~/configs/emulationstation
echo "Downloading Parser and es_systems"

wget https://raw.githubusercontent.com/uureel/batocera.pro/main/steam/shortcuts/%2BUPDATE-STEAM-SHORTCUTS.sh -P /userdata/roms/steam2/
chmod +x /userdata/roms/steam2/+UPDATE-STEAM-SHORTCUTS.sh
sleep 2
echo "Done"

# Reload ES after installations
killall -9 emulationstation
