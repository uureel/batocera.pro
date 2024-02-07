#!/bin/bash

# Get the machine hardware name
architecture=$(uname -m)

# Check if the architecture is x86_64 (AMD/Intel)
if [ "$architecture" != "x86_64" ]; then
    echo "This script only runs on AMD or Intel (x86_64) CPUs, not on $architecture."
    exit 1
fi




# Function to display animated title
animate_title() {
    local text="JELOS Steam/Heroic/Lutris container installer"
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
    echo "and more apps in an immutable Arch container with"
    echo "the apps appearing in Ports"
    echo "Many apps require mouse/keyboard and desktop mode is recommended for some of them"  
    echo "NOTE: SLOW STORAGE DEVICES CAN TAKE A WHILE TO START UP FIRST TIME"
    sleep 5  # Delay for 5 seconds
}


clear

# Main script execution
clear
animate_title
display_controls
# Define variables
BASE_DIR="/storage/roms/ports/conty"
DOWNLOAD_URL="batocera.pro/app/conty.sh"
DOWNLOAD_FILE="$BASE_DIR/conty.sh"
ROMS_DIR="/stoage/roms/ports"

# Step 1: Create base folder if not exists
mkdir -p "$BASE_DIR"
if [ ! -d "$BASE_DIR" ]; then
  # Handle error or exit if necessary
  echo "Error creating BASE_DIR."
  exit 1
fi

   
# Step 2: Download conty.sh with download percentage indicator
wget batocera.pro/app/conty.sh -O ~/roms/ports/conty/conty.sh 

# Step 3: Make conty.sh executable
chmod +x  ~/roms/ports/conty/conty.sh 

# Step 4: Download scripts to ports folder

# GitHub URL of the folder containing .sh files
REPO_URL="https://github.com/trashbus99/batocera-addon-scripts/tree/main/jelos/shortcuts"

# The directory where you want to download the files
DESTINATION_DIR="/storage/roms/ports"

# Use GitHub API to get the list of .sh files in the repository's specific folder
FILES=$(curl -s "https://api.github.com/repos/trashbus99/batocera-addon-scripts/contents/jelos/shortcuts" | jq -r '.[] | select(.name | endswith(".sh")) | .download_url')


# Download each file
for file in $FILES; do
    echo "Downloading $(basename "$file")..."
    curl -L "$file" -o "$DESTINATION_DIR/$(basename "$file")"
done

echo "All files downloaded to $DESTINATION_DIR"

# Make all .sh files in the directory executable
echo "Making all scripts executable..."
chmod +x "$DESTINATION_DIR"/*.sh

echo "All scripts are now executable."



killall -9 emulationstation


echo "Install Done.  You should see new Apps in PORTS"
