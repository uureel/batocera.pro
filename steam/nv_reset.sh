#!/bin/bash


echo "WARNING: This script will delete data in the following folders to reset nvidia container driver install"
echo "1. ~/.local"
echo "2. ~/pro/steam/home"
echo "There may be saves from other AppImages, apps in ~/.local You can back those up first if you desire"
echo ""
echo "Do you want to proceed? Type 'yes' to continue."

read -t 30 -p "Type 'yes' to confirm: " confirmation

if [ "$confirmation" = "yes" ]; then
    rm -rf ~/pro/steam/home
    rm -rf ~/.local    
    echo "Folders deleted."
    echo ""
    echo "" 
    echo "Attempting to start Steam"
    /userdata/roms/conty/"Steam Big Picture Mode.sh"
else
    echo "Operation canceled. No folders were deleted."
fi
