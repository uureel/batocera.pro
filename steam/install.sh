#!/bin/bash

# Get the machine hardware name
architecture=$(uname -m)

# Check if the architecture is x86_64 (AMD/Intel)
if [ "$architecture" != "x86_64" ]; then
    echo "This script only runs on AMD or Intel (x86_64) CPUs, not on $architecture."
    exit 1
fi

echo "Preparing Steam Installer...Please Wait"

cvlc --quiet --play-and-exit --no-osd https://github.com/trashbus99/batocera-addon-scripts/raw/main/media/steam.mp4 >/dev/null 2>&1 &

# Wait for cvlc to finish
wait $!

killall -9 vlc

Clear 

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
    echo "" 
    echo "PLEASE NOTE NVIDIA users and SLOW STORAGE DEVICES CAN TAKE A WHILE TO START UP FIRST TIME"
    echo ""
    echo "ATTENTION - NVIDIA USERS - STEAM MUST BE STARTED IN BIG PICTURE MODE FIRST TIME LAUNCH OR" 
    echo "IT CAN HANG AFTER NVIDIA DRIVERS DOWNLOAD"
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

cvlc https://github.com/trashbus99/batocera-addon-scripts/raw/main/media/wait.mp3 --repeat >/dev/null 2>&1 &


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
wget batocera.pro/app/conty.sh -O ~/pro/steam/conty.sh 


# Step 4: Make conty.sh executable
chmod +x "$DOWNLOAD_FILE"

# Step 5: Change ownership of home folder to user "batocera"
chown -R batocera:batocera "$HOME_DIR"

# Step 6: Download scripts to new /userdata/roms/conty folder


github_url="https://github.com/uureel/batocera.pro/tree/main/steam/shortcuts/"
target_directory="/userdata/roms/conty/"

# List of .sh files to download
sh_files=(
  "Antimicrox.sh"
  "Balena-Etcher.sh"
  "Boilr.sh"
  "Chiaki.sh"
  "Firefox.sh"
  "GameHub.sh"
  "Geforce-Now.sh"
  "Google-Chrome.sh"
  "Gparted.sh"
  "Greenlight.sh"
  "Heroic-Game-Launcher.sh"
  "Kodi.sh"
  "Libreoffice.sh"
  "Microsoft-Edge.sh"
  "Minecraft-Bedrock.sh"
  "Minigalaxy.sh"
  "Moonlight.sh"
  "OBS Studio.sh"
  "PCManFM-(File-Manager).sh"
  "Plan on Linux 4.sh"
  "Protonup-Qt.sh"
  "Qbittorrent.sh"
  "Spotify.sh"
  "Qdirstat.sh"
  "Spotify.sh"
  "Steam-Big-Picture-Mode.sh"
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
  echo "Downloading $file..."
  curl -sSL "${github_url}$file" -o "$target_directory$file"
  chmod +x "$target_directory$file"
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
FILE_URL="https://github.com/trashbus99/batocera-addon-scripts/raw/main/__REFRESH_ES_STEAM_GAMES__.sh"
DOWNLOAD_DIR="/userdata/roms/steam2"
SCRIPT_NAME="__REFRESH_ES_STEAM_GAMES__.sh"

# Create directory if it doesn't exist
mkdir -p "$DOWNLOAD_DIR"

# Download the file
wget "$FILE_URL" -P "$DOWNLOAD_DIR"



# Make the script executable
chmod +x "$DOWNLOAD_DIR/$SCRIPT_NAME"

# Step 8: Download ES custom Steam2 & conty/Arch system .cfgs to ~/configs/emulationstation

wget https://github.com/trashbus99/batocera-addon-scripts/raw/main/es_systems_arch.cfg -P ~/configs/emulationstation
wget https://github.com/trashbus99/batocera-addon-scripts/raw/main/es_systems_steam2.cfg -P ~/configs/emulationstation



killall -9 vlc

clear


echo "Preparing to launch Steam..."
sleep 2

# 5-second countdown with simple animation
for i in {5..1}
do
   clear
   echo "Launching Steam in... $i seconds"
   echo -ne '##########\r'
   sleep 0.2
   echo -ne '######### \r'
   sleep 0.2
   echo -ne '########  \r'
   sleep 0.2
   echo -ne '#######   \r'
   sleep 0.2
   echo -ne '######    \r'
   sleep 0.2
   echo -ne '#####     \r'
   sleep 0.2
   echo -ne '####      \r'
   sleep 0.2
   echo -ne '###       \r'
   sleep 0.2
   echo -ne '##        \r'
   sleep 0.2
   echo -ne '#         \r'
   sleep 0.2
   echo -ne '          \r'
done

echo "Steam is now starting"

/userdata/roms/conty/"Steam Big Picture Mode.sh"




echo "Install Done.  You should see a new system called Linux or Arch Container depending on theme"
sleep 5
killall -9 emulationstation
