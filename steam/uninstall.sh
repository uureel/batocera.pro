#!/bin/bash

# Introductory message using dialog
dialog --title "Warning" --msgbox "This script will uninstall the arch container and delete data ONLY in the following:\n\n1. ~/.local/share/Conty \n2. ~/pro/steam
\n3. /userdata/roms/conty \n4. /userdata/roms/lutris \n5. /userdata/roms/heroic2 \n6. /userdata/roms/steam2   \n\nThere may be saves. Data Stored in other locations will NOT be deleted." 20 60

# Confirmation dialog
if dialog --title "Confirm" --yesno "Do you want to proceed the uninstall and delete the folders? For Older Installs that used ~/pro/steam/home as home folder: The container's data in ~/pro/steam/home, if exists, will be deleted!!!  Select 'yes' to continue." 10 60; then
    rm -rf ~/pro/steam   
    rm -rf ~/.local/share/Conty
    rm -rf /userdata/roms/conty
    rm -rf /userdata/roms/steam2
    rm -rf /userdata/roms/heroic2
    rm -rf /userdata/roms/lutris
    rm ~/configs/emulationstation/es_systems_heroic2.cfg
    rm ~/configs/emulationstation/es_systems_lutris.cfg
    rm ~/configs/emulationstation/es_systems_arch.cfg*
    rm ~/configs/emulationstation/es_systems_steam2.cfg*
    rm ~/configs/emulationstation/es_features_steam2.cfg*
    
    clear   
    echo "Listed Files/Folders deleted."  
    echo "Steam in ~/.local/share/Steam, if exists, and other app data in ~/ were not deleted."
    echo ""
    echo "" 
    sleep 5
    killall -9 emulationstation
else
    echo "Operation canceled. No folders were deleted."
fi
