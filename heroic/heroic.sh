#!/bin/bash

# Get the machine hardware name
architecture=$(uname -m)

# Check if the architecture is x86_64 (AMD/Intel)
if [ "$architecture" != "x86_64" ]; then
    echo "This script only runs on AMD or Intel (x86_64) CPUs, not on $architecture."
    exit 1
fi



# Define the options
OPTIONS=("1" "Install via Arch Container (Recommended)"
         "2" "Install via AppImage")

# Display the dialog and get the user choice
CHOICE=$(dialog --clear --backtitle "Heroic Game Launcher Installer Options" \
                --title "Main Menu" \
                --menu "Choose an option:" 20 90 3 \
                "${OPTIONS[@]}" \
                2>&1 >/dev/tty)

clear

# Act based on the user choice
case $CHOICE in
    1)
        curl -Ls arch.batocera.pro | bash
    2)
        echo "Heroic installer via AppImage..."
        rm /tmp/runner 2>/dev/null
        wget -q --tries=30 --no-check-certificate --no-cache --no-cookies -O /tmp/runner https://raw.githubusercontent.com/uureel/batocera.pro/main/heroic/install.sh
        dos2unix /tmp/runner 2>/dev/null 
        chmod 777 /tmp/runner 2>/dev/null
        bash /tmp/runner
        ;;
    
    *)
        echo "No valid option selected or cancelled. Exiting."
        ;;
esac
