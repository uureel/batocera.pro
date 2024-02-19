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
        echo "Loading AMD/INTEL SCRIPT"
        curl -L https://github.com/uureel/batocera.pro/raw/main/steam/nv_warning.sh | bash
        ;;
    2)
        echo "Loading NVIDIA script..."
        curl -L https://github.com/uureel/batocera.pro/raw/main/steam/nv_menu.sh | bash
        ;;
    *)
        echo "No valid option selected or cancelled. Exiting."
        ;;
esac
