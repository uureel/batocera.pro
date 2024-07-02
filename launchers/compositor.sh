NU nano 7.2                                                                               co.sh                                                                                          #!/bin/bash

# Prompt user with a dialog box
dialog --title "Install Compositor" --yesno "Would you like to Install a compositor to prevent window artifacting?" 7 60

# Check the exit status of the dialog box
response=$?
case $response in
   0)
      echo "Downloading and installing the compositor..."

      # Create the folder for the compositor
      mkdir -p ~/batocera-compositor

      # Download the compositor script into the folder
      wget -O ~/batocera-compositor/batocera-compositor https://github.com/uureel/batocera.pro/raw/main/launchers/compositor/batocera-compositor
      chmod +x ~/batocera-compositor/batocera-compositor

      # Add line to launch it in the background in ~/custom.sh for next boot
         echo "/userdata/system/batocera-compositor/batocera-compositor start " >> /userdata/system/custom.sh

      # Launch the compositor in the background
      ~/batocera-compositor/batocera-compositor start
      ;;
   1)
      echo "Compositor installation canceled."
      ;;
   255)
      echo "Esc pressed. Compositor installation canceled."
      ;;
esac



