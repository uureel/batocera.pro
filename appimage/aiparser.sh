#!/bin/bash

# Define script paths
aip_script="/userdata/system/AppImage/aip.sh"
caip_script="/userdata/system/AppImage/caip.sh"

# Ensure scripts are executable
chmod +x "$aip_script"
chmod +x "$caip_script"

# Use dialog to ask the user which script to run
script_choice=$(dialog --title "Script Selection" --menu "Choose which script to run:" 12 90 2 \
1 "Run Regular AppImage Parser(Batocera (Lower Compatibilty/fewer dependencies)" \
2 "Run Arch Container AppImage Parser (Higher compatibility)" 3>&1 1>&2 2>&3)

# Check user's choice and run the selected script
case $script_choice in
    1)
        "$aip_script"
        ;;
    2)
        "$caip_script"
        ;;
    *)
        dialog --msgbox "No valid option selected, exiting." 5 40
        exit 1
        ;;
esac

# Clear dialog when done
dialog --clear
clear
