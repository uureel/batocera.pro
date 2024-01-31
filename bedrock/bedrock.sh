#!/bin/bash

# Define the dialog box with increased dimensions
dialog --title "WARNING!" \
       --yesno "1. This game is unstable in Batocera. Using the Keyboard in the game world may cause crashes.\
                \n  Limited testing with a gamepad seems to work. The Keyboard functions for menus.\
                \n2. This game requires you to own Minecraft Bedrock Edition for Android on your Google account.\
                \n\nCONTINUE INSTALLING?" 15 70

# Save the exit status
response=$?

# Clear the dialog
clear

# Act based on the exit status
if [ $response -eq 0 ]; then
    echo "Agreed. Downloading and executing script..."
    curl -L -o br.sh https://raw.githubusercontent.com/uureel/batocera.pro/main/bedrock/br.sh
    if [ $? -eq 0 ]; then
        bash br.sh || echo "Failed to execute the script."
    else
        echo "Failed to download the script."
    fi
elif [ $response -eq 1 ]; then
    echo "Declined. Exiting..."
    exit 0
else
    echo "Exited unexpectedly with status $response"
    exit $response
fi
