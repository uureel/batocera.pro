#!/bin/bash

# Check if conty.sh exists
if [[ ! -f "$conty_path" ]]; then
    # Ask user if they want to install conty.sh
    install_option=$(dialog --title "Arch Container Missing" --yesno "Arch Container appears to be not installed. Do you want to install it now?" 10 60 3>&1 1>&2 2>&3)
    response=$?
    if [[ $response -eq 0 ]]; then
        # User chose to install
        if curl -L steam.batocera.pro | bash; then
            # Check if the installation was successful
            if [[ ! -f "$conty_path" ]]; then
                dialog --msgbox "Installation failed. conty.sh still not found. Exiting script." 5 50
                exit 1
            else
                dialog --msgbox "Arch Container Installation appears completed successfully." 5 50
            fi
        else
            dialog --msgbox "Installation command failed. Exiting script." 5 50
            exit 1
        fi
    else
        # User chose not to install
        dialog --msgbox "User opted not to install. Exiting script." 5 50
        exit 1
    fi
fi



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
