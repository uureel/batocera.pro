#!/bin/bash

# Define the options
OPTIONS=("1" "AMD/INTEL"
         "2" "NVIDIA")

         
# Display the dialog and get the user choice
CHOICE=$(dialog --clear --backtitle "Select your GPU" \
                --title "Main Menu" \
                --menu "Choose an option:" 15 75 3 \
                "${OPTIONS[@]}" \
                2>&1 >/dev/tty)

clear

# Act based on the user choice
case $CHOICE in
    1)
        echo "Installing Steam Container..."
        curl -L https://github.com/uureel/batocera.pro/raw/main/steam/nv_warning.sh | bash
        ;;
    2)
        echo "Loading Uninstall script..."
        curl -L https://github.com/uureel/batocera.pro/raw/main/steam/uninstall.sh | bash
        ;;
    3)
        echo "Update EmulationStation Arch Container Launcher Shortcuts..."
        rm /userdata/roms/conty/*.sh
        curl -L https://github.com/uureel/batocera.pro/raw/main/steam/update_shortcuts.sh | bash
        ;;    
    4)  echo "Update/Re-download Container..."
        curl -L https://github.com/uureel/batocera.pro/raw/main/steam/redownload.sh  | bash
        ;;
    5)  echo "Update Conty Container..."
        curl -L https://github.com/uureel/batocera.pro/raw/main/steam/upgrade.sh  | bash
        ;;
    6) echo "Add Lutris shortcuts to emulationstation..."
       curl -L https://github.com/uureel/batocera.pro/raw/main/steam/addon_lutris.sh | bash
       ;;
    7) echo "Add Heroic shortcuts to emulationstation..."
       curl -L https://github.com/uureel/batocera.pro/raw/main/steam/addon_heroic.sh | bash
       ;;
    *)
        echo "No valid option selected or cancelled. Exiting."
        ;;
esac
