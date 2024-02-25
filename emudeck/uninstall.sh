#!/bin/bash


# Confirmation dialog
if dialog --title "Confirm" --yesno "CAUTION: Only run this AFTER you run the uninstall option in the Emudeck GUI. Proceed?" 10 60; then
    rm -rf ~/pro/steam/emudeck   
    rm /userdata/roms/conty/Emudeck-EmulationStation-DE.sh /userdata/roms/conty/Emudeck.sh /userdata/roms/conty/Emudeck-Steam-Rom-Manager.sh
    clear   
    echo "Files/Folders deleted."
    echo ""
    echo "" 
    sleep 5
    killall -9 emulationstation
else
    echo "Operation canceled. No folders were deleted."
fi
