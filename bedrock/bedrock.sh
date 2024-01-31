#!/bin/bash

# Define the dialog box with increased dimensions
dialog --title "WARNING!" \
       --yesno "1. This game is unstable in Batocera. Using the Keyboard except to sign in causes crashs.\
                \n  ONLY USE a GAMEPAD!--Limited Testing with a gamepad seems to work. \
                \n2. This game requires you to own Minecraft Bedrock Edition for Android on your Google account.\
                \n\nCONTINUE INSTALLING?" 15 70

# Capture the exit status of dialog command
response=$?

# Check the response
if [ $response -eq 0 ]; then
    # User selected Yes, execute the curl command
    curl -L https://raw.githubusercontent.com/uureel/batocera.pro/main/bedrock/br.sh | bash
else
    # User selected No, exit the script
    exit
fi
