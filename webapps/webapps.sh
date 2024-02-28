#!/bin/bash

# Ensure the script continuously runs until the user chooses to exit
while true; do

    # Use `dialog` to present the options to the user
    dialog --clear --backtitle "App Launcher" \
    --title "Select an Application" \
    --menu "Choose one of the following options:" 15 50 4 \
    "1" "Google Chrome Shortcut" \
    "2" "Create Electron app (~250MB)" \
    "Exit" "Exit the script" 2>tempfile

    # Status of dialog command
    if [ $? -eq 1 ]; then
        # User pressed cancel or closed the dialog window
        clear
        exit
    fi

    # Get the user's choice from the tempfile
    choice=$(cat tempfile)

    # Act based on the user's choice
    case $choice in
        1)
            ~/webapps/chrome.sh
            ;;
        2)
            ~/webapps/nlaunch.sh
            ;;
        Exit)
            clear
            exit
            ;;
    esac

    # Ask the user if they want to perform another operation
    dialog --clear --backtitle "App Launcher" \
    --yesno "Do you want to do another task?" 7 50

    # Check the user's decision
    response=$?
    case $response in
       0) 
           # User wants to perform another operation, continue the loop
           continue
           ;;
       1) 
           # User is done, exit the script
           clear
           exit
           ;;
    esac
done

# Clean up
rm -f tempfile

