#!/bin/bash

# Display a dialog box and capture the user's choice
dialog --title "Warning" --yesno "This version of PortMaster has been modified to work with Batocera. It is experimental and not supported by Batocera PRO--no support will be offered for using this version. Proceed?" 10 60

# Check the exit status of dialog
response=$?
case $response in
    0) echo "Continuing with the script...";;
    1) echo "You chose to exit."; exit 1;;
    255) echo "Dialog box closed."; exit 1;;
esac

# Continue with the rest of the script if the user chose 'Yes'
echo "Fetching Install script..."
echo ""
sleep 3
curl -L https://github.com/garbagescow/PortMaster-Batocera/raw/main/PortMaster/install/install.sh | bash
