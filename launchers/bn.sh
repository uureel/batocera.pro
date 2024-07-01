#!/bin/bash

# Colors for fancy output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to display a fancy animation title
function fancy_title() {
    clear
    echo -e "${RED}#############################${NC}"
    echo -e "${GREEN}#                           #${NC}"
    echo -e "${YELLOW}#   Battle.net Installer    #${NC}"
    echo -e "${BLUE}#                           #${NC}"
    echo -e "${RED}#############################${NC}"
    sleep 2
}

# Function to display step with animation
function display_step() {
    local message=$1
    echo -e "${GREEN}>> ${message} ${NC}"
    sleep 1
}

fancy_title

# Step 1: Fetch the latest Battle.net installer URL
display_step "Fetching the latest Battle.net installer URL..."
latest_url="https://downloader.battle.net//download/getInstallerForGame?os=win&gameProgram=BATTLENET_APP&version=Live"

if [[ -z "$latest_url" ]]; then
    echo -e "${RED}Failed to fetch the latest Battle.net installer URL. Exiting...${NC}"
    exit 1
fi

# Step 2: Download the latest Battle.net installer
display_step "Downloading the latest Battle.net installer..."
wget -q --show-progress "$latest_url" -O /tmp/BattleNet-Setup.exe

# Step 3: Create the necessary directory
display_step "Creating directory /userdata/roms/windows/BattleNet.pc..."
mkdir -p /userdata/roms/windows/BattleNet.pc

# Step 4: Move the downloaded installer
display_step "Moving Battle.net installer to /userdata/roms/windows/BattleNet.pc..."
mv /tmp/BattleNet-Setup.exe /userdata/roms/windows/BattleNet.pc

# Step 5: Create autorun.cmd file
display_step "Creating autorun.cmd..."
echo "CMD=BattleNet-Setup.exe" > /userdata/roms/windows/BattleNet.pc/autorun.cmd

# Cleanup
rm -f /tmp/BattleNet-Setup.exe

# Final message
display_step "Cleaning up..."
clear
echo -e "${YELLOW}###############################${NC}"
echo -e "${GREEN}#                             #${NC}"
echo -e "${BLUE}# Battle.net has been installed#${NC}"
echo -e "${YELLOW}# to the Windows system.       #${NC}"
echo -e "${RED}#                             #${NC}"
echo -e "${YELLOW}###############################${NC}"

sleep 5
clear
echo "Don't forget to enable DXVK in advanced options in Battle.net/WINE settings"
sleep 10
exit

