#!/bin/bash

github_url="https://github.com/uureel/batocera.pro/raw/main/steam/shortcuts/"
target_directory="/userdata/roms/conty/"

# List of .sh files to download
sh_files=(
  "Antimicrox.sh"
  "Balena-Etcher.sh"
  "Boilr.sh"
  "Firefox.sh"
  "GameHub.sh"
  "Geforce Now.sh"
  "Google-Chrome.sh"
  "Gparted.sh"
  "Greenlight.sh"
  "Heroic Game Launcher.sh"
  "Kodi.sh"
  "Libreoffice.sh"
  "Lutris.sh"
  "Microsoft-Edge.sh"
  "Minigalaxy.sh"
  "Moonlight.sh"
  "OBS Studio.sh"
  "PCManFM (File Manager).sh"
  "Peazip.sh"
  "Play on Linux 4.sh"
  "Protonup-Qt.sh"
  "Qbittorrent.sh"
  "Qdirstat.sh"
  "Smplayer.sh"
  "Steam Big Picture Mode.sh"
  "Steam.sh"
  "SteamTinker Launch (settings).sh"
  "Terminal-Root.sh"
  "Terminal.sh"
  "VLC.sh"
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
