#!/bin/bash

# Define the options
OPTIONS=("1" "Install Steam/Lutris/Heroic Game Launcher Container"
         "2" "Uninstall Steam/Lutris/Heroic Game Launcher Container"
         "3" "Run Nvidia Container Driver Reset Tool")

# Display the dialog and get the user choice
CHOICE=$(dialog --clear --backtitle "Steam/Lutris/Heroic and Nvidia driver Container Management" \
                --title "Main Menu" \
                --menu "Choose an option:" 15 50 3 \
                "${OPTIONS[@]}" \
                2>&1 >/dev/tty)

clear

# Act based on the user choice
case $CHOICE in
    1)
        echo "Installing Steam Container..."
        curl -L https://github.com/uureel/batocera.pro/raw/main/steam/install.sh | bash
        ;;
    2)
        echo "Loading Uninstall script..."
        curl -L https://github.com/uureel/batocera.pro/raw/main/steam/uninstall.sh | bash
        ;;
    3)
        echo "Running Nvidia Container Driver Reset Tool script..."
        curl -L https://github.com/uureel/batocera.pro/raw/main/steam/nv_reset.sh | bash
        ;;
    *)
        echo "No valid option selected or cancelled. Exiting."
        ;;
esac
