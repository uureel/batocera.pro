#!/bin/bash

# Get the machine hardware name
architecture=$(uname -m)

# Check if the architecture is x86_64 (AMD/Intel)
if [ "$architecture" != "x86_64" ]; then
    echo "This script only runs on AMD or Intel (x86_64) CPUs, not on $architecture."
    exit 1
fi

# Define the options
OPTIONS=("1" "Install Arch Container with Steam, Lutris, Heroic and more Apps"
         "2" "Uninstall Arch Container"
         "3" "Update Launcher shortcuts for emulationstation Arch container"
         "4" "Re-download container"
         "5" "Rebuild and Update apps on container (experimental)"
         "6" "Addon: Add/Update Lutris Menu & Shortcuts to Emulationstation"
         "7" "Addon: Add/Update Heroic Menu & Shortcuts to Emulationstation"
         "8" "Addon: Emudeck (experimental)"
         "9" "Addon: Add/Update Webapps Web/Internet Menu to Emulationstation")

# Display the dialog and get the user choice
CHOICE=$(dialog --clear --backtitle "Steam/Lutris/Heroic Container Management" \
                --title "Main Menu" \
                --menu "Choose an option:" 20 75 3 \
                "${OPTIONS[@]}" \
                2>&1 >/dev/tty)

clear

# Act based on the user choice
case $CHOICE in
    1)
        echo "Installing Steam Container..."
        rm /tmp/runner 2>/dev/null
        wget -q --tries=30 --no-check-certificate --no-cache --no-cookies -O /tmp/runner https://raw.githubusercontent.com/uureel/batocera.pro/main/steam/install2.sh
        dos2unix /tmp/runner 2>/dev/null 
        chmod 777 /tmp/runner 2>/dev/null
        bash /tmp/runner
        ;;
    2)
        echo "Loading Uninstall script..."
        rm /tmp/runner 2>/dev/null
        wget -q --tries=30 --no-check-certificate --no-cache --no-cookies -O /tmp/runner https://raw.githubusercontent.com/uureel/batocera.pro/main/steam/uninstall.sh
        dos2unix /tmp/runner 2>/dev/null 
        chmod 777 /tmp/runner 2>/dev/null
        bash /tmp/runner
        ;;
    3)  
        echo "Update EmulationStation Arch Container Launcher Shortcuts..."
        rm /userdata/roms/conty/*.sh
        rm /tmp/runner 2>/dev/null
        wget -q --tries=30 --no-check-certificate --no-cache --no-cookies -O /tmp/runner https://raw.githubusercontent.com/uureel/batocera.pro/main/steam/update_shortcuts.sh
        dos2unix /tmp/runner 2>/dev/null 
        chmod 777 /tmp/runner 2>/dev/null
        bash /tmp/runner
        ;;    
    4)  
        echo "Update/Re-download Container..."
        rm /tmp/runner 2>/dev/null
        wget -q --tries=30 --no-check-certificate --no-cache --no-cookies -O /tmp/runner https://raw.githubusercontent.com/uureel/batocera.pro/main/steam/redownload.sh
        dos2unix /tmp/runner 2>/dev/null 
        chmod 777 /tmp/runner 2>/dev/null
        bash /tmp/runner
        ;;
    5)  
        echo "Update Conty Container..."
        rm /tmp/runner 2>/dev/null
        wget -q --tries=30 --no-check-certificate --no-cache --no-cookies -O /tmp/runner https://raw.githubusercontent.com/uureel/batocera.pro/main/steam/upgrade.sh
        dos2unix /tmp/runner 2>/dev/null 
        chmod 777 /tmp/runner 2>/dev/null
        bash /tmp/runner
        ;;
    6)  
        echo "Add/Update Lutris shortcuts to emulationstation..."
        rm /tmp/runner 2>/dev/null
        wget -q --tries=30 --no-check-certificate --no-cache --no-cookies -O /tmp/runner https://raw.githubusercontent.com/uureel/batocera.pro/main/steam/addon_lutris.sh
        dos2unix /tmp/runner 2>/dev/null 
        chmod 777 /tmp/runner 2>/dev/null
        bash /tmp/runner
        ;;
    7)  
        echo "Add/update Heroic shortcuts to emulationstation..."
        rm /tmp/runner 2>/dev/null
        wget -q --tries=30 --no-check-certificate --no-cache --no-cookies -O /tmp/runner https://raw.githubusercontent.com/uureel/batocera.pro/main/steam/addon_heroic.sh
        dos2unix /tmp/runner 2>/dev/null 
        chmod 777 /tmp/runner 2>/dev/null
        bash /tmp/runner
        ;;
    8)  
        echo "Emudeck Menu..."
        rm /tmp/runner 2>/dev/null
        wget -q --tries=30 --no-check-certificate --no-cache --no-cookies -O /tmp/runner https://github.com/uureel/batocera.pro/raw/main/emudeck/emudeck.sh
        dos2unix /tmp/runner 2>/dev/null 
        chmod 777 /tmp/runner 2>/dev/null
        bash /tmp/runner
        ;;
    9)  
        echo "Webapps Menu..."
        rm /tmp/runner 2>/dev/null
        wget -q --tries=30 --no-check-certificate --no-cache --no-cookies -O /tmp/runner https://github.com/uureel/batocera.pro/raw/main/webapps/install.sh
        dos2unix /tmp/runner 2>/dev/null 
        chmod 777 /tmp/runner 2>/dev/null
        bash /tmp/runner
        ;;   
    *)
        echo "No valid option selected or cancelled. Exiting."
        ;;
esac
