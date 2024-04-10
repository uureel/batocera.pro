#!/bin/bash

# Get the machine hardware name
architecture=$(uname -m)

# Check if the architecture is x86_64 (AMD/Intel)
if [ "$architecture" != "x86_64" ]; then
    echo "This script only runs on AMD or Intel (x86_64) CPUs, not on $architecture."
    exit 1
fi


if ! command -v docker &> /dev/null; then
    echo "Docker could not be found, installing Docker..."
    curl -L https://github.com/uureel/batocera.pro/raw/main/docker/install.sh | bash
    # Check if Docker was successfully installed
    if ! command -v docker &> /dev/null; then
        echo "Docker installation failed. Please install Docker manually."
        exit 1
    fi
fi

# Function definitions omitted for brevity...

# Determine the directory to use
windows_dir=$(find_next_available_directory)

# Ensure the directory exists
mkdir -p "$windows_dir"

echo "Using directory: $windows_dir"

# Initial setup for dialog
BACKTITLE="Docker Windows Container Setup"

# Check and set RDP port
RDP_PORT=3389
if is_port_in_use $RDP_PORT; then
    RDP_PORT=$(find_next_available_port $RDP_PORT)
    RDP_PORT=$(dialog --stdout --inputbox "Port 3389 is in use. Enter a different RDP port:" 8 40 $RDP_PORT)
    [ $? -ne 0 ] && { echo "Configuration canceled by user."; exit 1; }
    clear
fi

# Dialog examples with exit status checks
VERSION=$(dialog --stdout --backtitle "$BACKTITLE" --title "Windows Version" --menu "Choose a version:" 40 70 4 ... )
[ $? -ne 0 ] && { echo "Configuration canceled by user."; exit 1; }
clear

# Other dialog commands with checks after each...

# If the user confirms the final settings
dialog --stdout --backtitle "$BACKTITLE" --yesno "You have configured the Docker container with the following settings:..." 22 76
response=$?

if [ $response -eq 0 ]; then
    # Proceed with Docker container setup...
else
    echo "Configuration canceled by user."
    exit 1
fi

# Final message to the user, reminding how to access both RDP and VNC

# Compile message content
MSG="To access your Windows environment:\n
- Via RDP: Connect to localhost:$RDP_PORT with your RDP client.\n
- Via VNC: Connect to localhost:$VNC_PORT with your browser.\n
- Remember, initial setup must be done via VNC via web browser - http://<batocera_ip_address>:$VNC_PORT\n
- Windows files are stored in $windows_dir\n
- Adjust other settings in your clients as needed.\n
- You can manage the container settings in Portainer after installation.\n
- Default RDP username is docker. Password is blank.\n
- RDP won't be running until windows is finished installing."

# Use dialog to display the message
dialog --title "Access and Configuration Information" --msgbox "$MSG" 20 70

# Clear the screen after displaying the message
clear
exit
