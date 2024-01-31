
#!/bin/bash

# Define the dialog box with increased dimensions
dialog --title "WARNING!" \
       --yesno "1. This game is unstable in Batocera. Using the Keyboard in the game world causes it to crash.\
                \n  Limited testing using only the gamepad seems to work OK. The Keyboard works ok for menus.\
                \n2.This game requires you own  Minecraft Bedrock Edition for Android on your google account.
                \n CONTINUE INSTALLING?" 15 70

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


