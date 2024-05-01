#!/bin/bash

# Get the machine hardware name
architecture=$(uname -m)

# Check if the architecture is x86_64 (AMD/Intel)
if [ "$architecture" != "x86_64" ]; then
    echo "This script only runs on AMD or Intel (x86_64) CPUs, not on $architecture."
    exit 1
fi

MESSAGE="Since Version 39 of Batocera, apparently due to SDL changes, xinput over bluetooth does not work on steam in the Arch container. Xbox One/S/X controllers are verified working via wired USB or Xbox wireless adapter only. 8bitDO controller users can switch their input mode to d-input or switch input.  Continue?"

# Use dialog to create a yes/no box
if dialog --title "Compatibility Warning" --yesno "$MESSAGE" 10 70; then
    # If the user chooses 'Yes', continue the installation
    echo "Continuing installation..."
    # Add your installation commands here
else
    # If the user chooses 'No', exit the script
    echo "Installation aborted by user."
    exit 1
fi

# Clear the screen after the dialog is closed
clear

echo "Starting Steam Installer Script..."

sleep 2

clear 

# Function to display animated title
animate_title() {
    local text="Steam/Heroic/Lutris container installer"
    local delay=0.1
    local length=${#text}

    for (( i=0; i<length; i++ )); do
        echo -n "${text:i:1}"
        sleep $delay
    done
    echo
}

display_controls() {
    echo 
    echo "This Will install Steam, Heroic-Games Launcher, Lutris,"
    echo "and more apps in an Arch container with"
    echo "a new system appearing in ES called Arch Container or"
    echo "Linux depending on your theme in ~/pro/steam"  
    echo 
    sleep 10  # Delay for 10 seconds
}

clear

# Main script execution
clear
animate_title
display_controls
# Define variables
BASE_DIR="/userdata/system/pro/steam"
HOME_DIR="$BASE_DIR/home"
DOWNLOAD_URL="batocera.pro/app/conty.sh"
DOWNLOAD_FILE="$BASE_DIR/conty.sh"
ROMS_DIR="/userdata/roms/ports"



# Step 1: Create base folder if not exists
mkdir -p "$BASE_DIR"
if [ ! -d "$BASE_DIR" ]; then
  # Handle error or exit if necessary
  echo "Error creating BASE_DIR."
  exit 1
fi

# Step 2: Create home folder if not exists
if [ ! -d "$HOME_DIR" ]; then
  mkdir -p "$HOME_DIR"
fi
   
# Step 3: Download conty.sh with download percentage indicator
rm /userdata/system/pro/steam/prepare.sh 2>/dev/null
rm /userdata/system/pro/steam/conty.s* 2>/dev/null
curl -L aria2c.batocera.pro | bash && ./aria2c -x 5 -d  /userdata/system/pro/steam http://batocera.pro/app/conty.sh && rm aria2c
chmod 777 /userdata/system/pro/steam/conty.sh 2>/dev/null

# Step 4: Make conty.sh executable
chmod +x "$DOWNLOAD_FILE"

# Step 5: Change ownership of home folder to user "batocera"
# chown -R batocera:batocera "$HOME_DIR"

# Step 6: Download scripts to new /userdata/roms/conty folder
github_url="https://github.com/uureel/batocera.pro/raw/main/steam/shortcuts/"
target_directory="/userdata/roms/conty/"

# List of .sh files to download
sh_files=(
"Antimicrox.sh"
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

# Create the target directory if it doesn't exist
mkdir -p "$target_directory"

# Remove old .sh files
for file in "${old_sh_files[@]}"; do
  rm "${target_directory}${file}" 2>/dev/null
done

# Download the specified .sh files and make them executable
for file in "${sh_files[@]}"; do
  # Replace spaces with '%20' for URL encoding
  encoded_file=$(echo "$file" | sed 's/ /%20/g')
  echo "Downloading $file..."
  #curl -sSL "${github_url}${encoded_file}" -o "${target_directory}${file}"
  wget -q --tries=30 --no-check-certificate --no-cache --no-cookies -O "${target_directory}${file}" "${github_url}${encoded_file}"
  dos2unix "${target_directory}${file}" 2>/dev/null
  chmod +x "${target_directory}${file}" 2>/dev/null
done

######OLD SHORTCUT ROUTINE######
# Define URLs and paths
# download_url="https://github.com/trashbus99/batocera-addon-scripts/raw/main/contyapps/conty.tar.gz"
#download_url="https://github.com/trashbus99/batocera-addon-scripts/raw/main/contyapps/conty.tar.gz"
#download_location="$HOME/pro/steam/conty.tar.gz"
#extract_location="/userdata/roms/"

# Create directories if they don't exist
#mkdir -p "$HOME/pro/steam"
#mkdir -p "$extract_location"

# Download the compressed file
#curl -L -o "$download_location" "$download_url"

# Extract the contents to the desired location
#tar -xzvf "$download_location" -C "$extract_location"

# Make all .sh files executable
#find "$extract_location" -type f -name "*.sh" -exec chmod +x {} \;

# Clean up: remove the downloaded file
#rm "$download_location"
###############

echo "Conty files have been downloaded a to $target_directory"
echo "Executable permission set for all .sh files"

sleep 3

# Step 7: Make /userdata/roms/steam2 folder if it doesn't exist and download parser

# Define variables
FILE_URL="https://github.com/uureel/batocera.pro/raw/main/steam/shortcuts/%23%23UPDATE-STEAM-SHORTCUTS%23%23"
DOWNLOAD_DIR="/userdata/roms/steam2"
SCRIPT_NAME="##UPDATE-STEAM-SHORTCUTS##"

# Create directory if it doesn't exist
mkdir -p "$DOWNLOAD_DIR"

# Download the file
clear
echo "Downloading Parser"
rm /userdata/roms/steam2/+UPDATE-STEAM-SHORTCUTS.* 2>/dev/null
wget -q --tries=30 --no-check-certificate --no-cache --no-cookies -O "/userdata/roms/steam2/+UPDATE-STEAM-SHORTCUTS.sh" https://raw.githubusercontent.com/uureel/batocera.pro/main/steam/shortcuts/%2BUPDATE-STEAM-SHORTCUTS.sh
chmod +x /userdata/roms/steam2/+UPDATE-STEAM-SHORTCUTS.sh

# Make the script executable
chmod +x "$DOWNLOAD_DIR/$SCRIPT_NAME"

# Step 8: Download ES custom Steam2 & conty/Arch system .cfgs to ~/configs/emulationstation
clear
echo "Downloading ES Systems"
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

clear

#echo "Preparing to launch Steam..."
#sleep 2

# 5-second countdown with simple animation
#for i in {5..1}
#do
#   clear
#   echo "Launching Steam in... $i seconds"
#   echo -ne '##########\r'
#   sleep 0.2
#   echo -ne '######### \r'
#   sleep 0.2
#   echo -ne '########  \r'
#   sleep 0.2
#   echo -ne '#######   \r'
#   sleep 0.2
#   echo -ne '######    \r'
#   sleep 0.2
#   echo -ne '#####     \r'
#   sleep 0.2
#   echo -ne '####      \r'
#   sleep 0.2
#   echo -ne '###       \r'
#   sleep 0.2
#   echo -ne '##        \r'
#   sleep 0.2
#   echo -ne '#         \r'
#   sleep 0.2
#   echo -ne '          \r'
#done

#echo "Launching Steam"

#dos2unix "/userdata/roms/conty/Steam Big Picture Mode.sh" 2>/dev/null
#chmod 777 "/userdata/roms/conty/Steam Big Picture Mode.sh" 2>/dev/null
#bash "/userdata/roms/conty/Steam Big Picture Mode.sh"

MSG="Install Done.  You should see a new system  in EmulatiationStation called Linux or Arch Container depending on theme\nNVIDIA Users: Drivers will download on First app start-up & can take a while."
dialog --title "Arch Container Setup Complete" --msgbox "$MSG" 20 70


curl http://127.0.0.1:1234/reloadgames
