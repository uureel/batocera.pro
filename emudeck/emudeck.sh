#!/bin/bash





# Define the options
OPTIONS=("1" "Install Emudeck"
         "2" "Uninstall Emudeck"
         "3" "(Re)Download Steam Rom Manager Parser fix")
         
# Display the dialog and get the user choice
CHOICE=$(dialog --clear --backtitle "Emudeck Manager" \
                --title "Main Menu" \
                --menu "Choose an option:" 15 75 3 \
                "${OPTIONS[@]}" \
                2>&1 >/dev/tty)

clear

# Act based on the user choice
case $CHOICE in
    1)
        echo "Installing emudeck..."
        rm /tmp/runner 2>/dev/null
        wget -q --tries=30 --no-check-certificate --no-cache --no-cookies -O /tmp/runner https://github.com/uureel/batocera.pro/raw/main/emudeck/download.sh
        dos2unix /tmp/runner 2>/dev/null 
        chmod 777 /tmp/runner 2>/dev/null
        bash /tmp/runner
        ;;
      2)
        echo "Uninstall Emudeck..."
        rm /tmp/runner 2>/dev/null
        wget -q --tries=30 --no-check-certificate --no-cache --no-cookies -O /tmp/runner https://github.com/uureel/batocera.pro/raw/main/emudeck/uninstall.sh
        dos2unix /tmp/runner 2>/dev/null 
        chmod 777 /tmp/runner 2>/dev/null
        bash /tmp/runner
        ;;
    3)
        echo "Parser Fix..."
        rm /tmp/runner 2>/dev/null
        wget -q --tries=30 --no-check-certificate --no-cache --no-cookies -O /tmp/runner https://github.com/uureel/batocera.pro/raw/main/emudeck/srmparser.sh
        dos2unix /tmp/runner 2>/dev/null 
        chmod 777 /tmp/runner 2>/dev/null
        bash /tmp/runner
        ;;
    *)
        echo "No valid option selected or cancelled. Exiting."
        ;;
esac
