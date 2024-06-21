#!/bin/bash

# Get the machine hardware name
architecture=$(uname -m)

# Check if the architecture is x86_64 (AMD/Intel)
if [ "$architecture" != "x86_64" ]; then
    echo "This script only runs on AMD or Intel (x86_64) CPUs, not on $architecture."
    exit 1
fi

MESSAGE="Since Version 39 of Batocera, apparently due to kernel and/or SDL changes, xinput over bluetooth does not work on steam in the Arch container. Xbox One/S/X controllers are verified working via wired USB or Xbox wireless adapter only. 8bitDO controller users can switch their input mode to d-input or switch input.  Continue?"

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

###############

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

###############

# Step 1: Create base folder if not exists
mkdir -p "$BASE_DIR"
if [ ! -d "$BASE_DIR" ]; then
  # Handle error or exit if necessary
  echo "Error creating BASE_DIR."
  exit 1
fi

###############

# Step 2: Create home folder if not exists
if [ ! -d "$HOME_DIR" ]; then
  mkdir -p "$HOME_DIR"
fi

########
#make steam2 folder for steam shortcuts
mkdir -p /userdata/roms/steam2
###############

# Step 3: Download conty.sh with download percentage indicator
rm /userdata/system/pro/steam/prepare.sh 2>/dev/null
rm /userdata/system/pro/steam/conty.s* 2>/dev/null
curl -L aria2c.batocera.pro | bash && ./aria2c -x 5 -d /userdata/system/pro/steam http://batocera.pro/app/conty.sh && rm aria2c
chmod 777 /userdata/system/pro/steam/conty.sh 2>/dev/null

###############

# Step 4: Make conty.sh executable
chmod +x "$DOWNLOAD_FILE"

###############

echo "Conty files have been downloaded a to $target_directory"

###############

# Update shortcuts
wget -q --tries=30 --no-check-certificate --no-cache --no-cookies --tries=50 -O /tmp/update_shortcuts.sh https://raw.githubusercontent.com/uureel/batocera.pro/main/steam/update_shortcuts.sh
dos2unix /tmp/update_shortcuts.sh 2>/dev/null
chmod 777 /tmp/update_shortcuts.sh 2>/dev/null
bash /tmp/update_shortcuts.sh 
sleep 1

###############

#echo "Launching Steam"
#dos2unix "/userdata/roms/conty/Steam Big Picture Mode.sh" 2>/dev/null
#chmod 777 "/userdata/roms/conty/Steam Big Picture Mode.sh" 2>/dev/null
#bash "/userdata/roms/conty/Steam Big Picture Mode.sh"

###############

MSG="Install Done.  You should see a new system  in EmulatiationStation called Linux or Arch Container depending on theme\nNVIDIA Users: Drivers will download in the background on First app start-up & can take a while."
dialog --title "Arch Container Setup Complete" --msgbox "$MSG" 20 70

###############

curl http://127.0.0.1:1234/reloadgames
