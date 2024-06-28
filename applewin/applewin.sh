#!/bin/bash

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to display title
function fancy_title() {
    clear
    echo -e "${RED}#####################################${NC}"
    echo -e "${GREEN}#                                   #${NC}"
    echo -e "${YELLOW}#  Batocera PRO AppleWin Installer  #${NC}"
    echo -e "${BLUE}#                                   #${NC}"
    echo -e "${RED}#####################################${NC}"
    sleep 2
}

# Function to display step with animation
function display_step() {
    local message=$1
    echo -e "${GREEN}>> ${message} ${NC}"
    sleep 1
}

fancy_title

# Step 1: Fetch the latest AppleWin build URL from GitHub
display_step "Fetching the latest AppleWin build URL from GitHub..."
latest_url=$(curl -s https://api.github.com/repos/AppleWin/AppleWin/releases/latest | grep "browser_download_url.*zip" | cut -d '"' -f 4)

if [[ -z "$latest_url" ]]; then
    echo -e "${RED}Failed to fetch the latest AppleWin build URL. Exiting...${NC}"
    exit 1
fi

# Step 2: Download the latest AppleWin build
display_step "Downloading the latest AppleWin build..."
wget -q --show-progress "$latest_url" -O /tmp/AppleWin.zip

# Step 3: Create the necessary directory
display_step "Creating directory /userdata/roms/windows/AppleWin.pc..."
mkdir -p /userdata/roms/windows/AppleWin.pc

# Step 4: Extract the downloaded file
display_step "Extracting AppleWin to /userdata/roms/windows/AppleWin.pc..."
unzip -o /tmp/AppleWin.zip -d /userdata/roms/windows/AppleWin.pc

# Step 5: Create autorun.cmd file
display_step "Creating autorun.cmd..."
echo "CMD=Applewin.exe" > /userdata/roms/windows/AppleWin.pc/autorun.cmd

# Cleanup
rm /tmp/AppleWin.zip

# Final message
display_step "Cleaning up..."
clear
echo -e "${YELLOW}###############################${NC}"
echo -e "${BLUE}#                             #${NC}"
echo -e "${GREEN}# AppleWIN has been installed #${NC}"
echo -e "${YELLOW}# to the Windows system.      #${NC}"
echo -e "${RED}#                             #${NC}"
echo -e "${YELLOW}###############################${NC}"


echo "REFRESH ES/UPDATE GAMELISTS TO SEE APP in WINDOWS"
echo""
echo""
echo "DONE"
sleep 5
