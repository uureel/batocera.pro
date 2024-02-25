#!/bin/bash


# Confirmation dialog
if dialog --title "Confirm" --yesno "CAUTION: Only run this AFTER you run the uninstall oprion in the Emudeck GUI. Procced?" 10 60; then
    rm -rf ~/pro/steam/emudeck   
    rm -f ~/userdata/roms/Emudeck*.sh
    clear   
    echo "Files/Folders deleted."
    echo ""
    echo "" 
    sleep 5
    killall -9 emulationstation
else
    echo "Operation canceled. No folders were deleted."
fi
