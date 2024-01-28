#!/bin/bash

# Introductory message using dialog
dialog --title "Warning" --msgbox "This script will uninstall the arch container and delete data in the following:\n\n1. ~/.local/share/Conty \n2. ~/pro/steam \n\nThere may be saves.  You can back those up first if you desire." 15 60

# Confirmation dialog
if dialog --title "Confirm" --yesno "Do you want to proceed the uninstall and delete the folders? Select 'yes' to continue." 10 60; then
    rm -rf ~/pro/steam   
    rm -rf ~/.local/share/Conty
    rm -rf ~/userdata/roms/conty
    rm -rf ~/userdata/roms/steam2
    rm ~/configs/emulationstation/es_systems_arch.cfg*
    rm ~/configs/emulationstation/es_systems_steam2.cfg*
    clear   
    echo "Files/Folders deleted."
    echo ""
    echo "" 
    sleep 5
    killall -9 emulationstation
else
    echo "Operation canceled. No folders were deleted."
fi
