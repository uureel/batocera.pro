#!/bin/bash

# Display a dialog message box
dialog --title "Webapps Installer" --msgbox "This script will install a New system called webapps and ES Menu in Batocera that lets you create Google Shortcuts and Electron." 10 50

# Proceed with the rest of the script

# Define base URL for downloads
BASE_URL="https://github.com/uureel/batocera.pro/raw/main/webapps"

# Create the ~/webapps directory
mkdir -p ~/webapps

# Download the specified scripts into ~/webapps
curl -L https://github.com/uureel/batocera.pro/raw/main/webapps/native.sh -o ~/webapps/native.sh
curl -L https://github.com/uureel/batocera.pro/raw/main/webapps/native.sh -o ~/webapps/nlaunch.sh
curl -L https://github.com/uureel/batocera.pro/raw/main/webapps/native.sh -o ~/webapps/chrome.sh


# Make downloaded scripts executable
chmod +x ~/webapps/native.sh
chmod +x ~/webapps/nlaunch.sh
chmod +x ~/webapps/chrome.sh

# Create the /userdata/roms/webapps directory
mkdir -p /userdata/roms/webapps

# Download the Add-WebApp.sh script into /userdata/roms/webapps
curl https://github.com/uureel/batocera.pro/raw/main/webapps/%2BAdd-WebbApp.sh -o /userdata/roms/webapps/+Add-WebbApp.sh


# Make the downloaded Add-WebApp.sh script executable
chmod +x /userdata/roms/webapps/+Add-WebbApp.sh

# Create the ~/configs/emulationstation directory
mkdir -p ~/configs/emulationstation

# Download the es_systems_webapps.cfg file into ~/configs/emulationstation
curl -L https://github.com/uureel/batocera.pro/raw/main/webapps/es_systems_webapps.cfg -o ~/configs/emulationstation/es_systems_webapps.cfg

echo "All files have been downloaded and placed in their respective directories. Scripts have been made executable."
sleep 5
curl http://127.0.0.1:1234/reloadgames
