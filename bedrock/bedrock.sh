#!/bin/bash

# Define the dialog box
dialog --title "WARNING!" \
       --yesno "1. This game is unstable in batocera. Using the Keyboard in the game world causes it to crash. 
                Limited testing using only the gamepad seems to work OK. The Keyboard works ok for menus.
                \n2. This game requires Minecraft Bedrock Edition for Android." 10 50

# Check the exit status
response=$?
case $response in
   0) echo "Agreed. Executing curl command...";
      # Replace the following line with your actual curl command
      curl [YOUR-CURL-COMMAND-HERE];;
   1) echo "Declined.";;
   255) echo "[ESC] key pressed.";;
esac

# Clear the dialog
clear
