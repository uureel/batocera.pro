#!/bin/bash

# Function to check if a port is in use
is_port_in_use() {
    if lsof -i:$1 > /dev/null 2>&1; then
        return 0 # True, port is in use
    else
        return 1 # False, port is not in use
    fi
}

# Check for Docker
if ! command -v docker &> /dev/null; then
    dialog --title "Docker Installation" --infobox "Docker could not be found. Installing Docker..." 10 50
    sleep 2 # Gives user time to read the message
    curl -L https://github.com/uureel/batocera.pro/raw/main/docker/install.sh | bash
    # Check if Docker was successfully installed
    if ! command -v docker &> /dev/null; then
        dialog --title "Docker Installation Error" --msgbox "Docker installation failed. Please install Docker manually." 10 50
        clear
        exit 1
    fi
fi

# Create directories and download necessary scripts
mkdir -p ~/pro/bliss
curl -L https://github.com/uureel/batocera.pro/raw/main/docker/bliss.sh -o ~/pro/bliss/bliss.sh
chmod +x ~/pro/bliss/bliss.sh

mkdir -p /userdata/roms/ports
curl -L https://github.com/uureel/batocera.pro/raw/main/docker/Bliss-OS.sh -o /userdata/roms/ports/Bliss-OS.sh
chmod +x /userdata/roms/ports/Bliss-OS.sh

# Check if port 5930 is in use
if is_port_in_use 5930; then
    dialog --title "Port in Use" --msgbox "Port 5930 is already in use. Please free the port and try again." 10 50
    clear
    exit 1
fi


# Final dialog message with Portainer management info
MSG="Bliss OS Docker container has been set up.\n\nBliss-OS can be run from ports--startup takes a while...\n\nAdjust other settings in your clients as needed.\n\nThe container can be managed via Portainer web UI on port 9443."
dialog --title "Bliss OS Setup Complete" --msgbox "$MSG" 20 70

clear
