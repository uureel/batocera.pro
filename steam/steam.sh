#!/bin/bash

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

# Function to display controls
display_controls() {
    echo 
    echo "  This Will Steam, Heroic-Games Launcher, Lutris
    echo "  and more apps in an Arch container with"
    echo "  a new system appearing in ES called Arch Container or 
    echo "  Linux depending on your theme" 
    sleep 5  # Delay for 5 seconds
}

clear

# Main script execution
clear
animate_title
display_controls
# Define variables
BASE_DIR="/userdata/system/pro/steam"
HOME_DIR="$BASE_DIR/home"
DOWNLOAD_URL="https://docs.google.com/uc?export=download&id=1Y03VO-VVMdZM8rEAZJhXxNNm9IcAt7tt"
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
wget --no-check-certificate --load-cookies /tmp/cookies.txt "https://docs.google.com/uc?export=download&confirm=$(wget --quiet --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate 'https://docs.google.com/uc?export=download&id=1Y03VO-VVMdZM8rEAZJhXxNNm9IcAt7tt' -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')&id=1Y03VO-VVMdZM8rEAZJhXxNNm9IcAt7tt" -O ~/pro/steam/conty.sh && rm -rf /tmp/cookies.txt

# Step 4: Make conty.sh executable
chmod +x "$DOWNLOAD_FILE"

# Step 5: Change ownership of home folder to user "batocera"
chown -R batocera:batocera "$HOME_DIR"

# Step 6: Download scripts to new /userdata/roms/conty folder

# Define URLs and paths
download_url="https://github.com/trashbus99/batocera-addon-scripts/raw/main/contyapps/conty.tar.gz"
download_location="$HOME/pro/steam/conty.tar.gz"
extract_location="/userdata/roms/"

# Create directories if they don't exist
mkdir -p "$HOME/pro/steam"
mkdir -p "$extract_location"

# Download the compressed file
curl -L -o "$download_location" "$download_url"

# Extract the contents to the desired location
tar -xzvf "$download_location" -C "$extract_location"

# Make all .sh files executable
find "$extract_location" -type f -name "*.sh" -exec chmod +x {} \;

# Clean up: remove the downloaded file
rm "$download_location"

echo "Conty files have been downloaded and extracted to $extract_location"
echo "Executable permission set for all .sh files"


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


killall -9 emulationstation


echo "Install Done.  You should see a new system called Linux or Arch Container depending on theme"
