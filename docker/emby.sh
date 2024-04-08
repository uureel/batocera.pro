#!/bin/bash

# Function to check if a port is in use
is_port_in_use() {
    if lsof -i:$1 > /dev/null; then
        return 0 # True, port is in use
    else
        return 1 # False, port is not in use
    fi
}

# Ensure dialog and lsof are installed
if ! command -v dialog &> /dev/null; then
    echo "Dialog is not installed. Please install dialog first."
    exit 1
fi

if ! command -v lsof &> /dev/null; then
    echo "lsof is not installed. Please install lsof first."
    exit 1
fi

# Check for Docker
if ! command -v docker &> /dev/null; then
    dialog --title "Docker Installation" --infobox "Docker could not be found. Installing Docker..." 10 50
    sleep 2
    curl -L https://github.com/uureel/batocera.pro/raw/main/docker/install.sh | bash
    if ! command -v docker &> /dev/null; then
        dialog --title "Docker Installation Error" --msgbox "Docker installation failed. Please install Docker manually." 10 50
        clear
        exit 1
    fi
fi

# Check if port 8096 is in use
if is_port_in_use 8096; then
    dialog --title "Port Conflict" --msgbox "Port 8096 is already in use. Please ensure it is available before installing Emby." 10 50
    clear
    exit 1
fi

# Setup directories for Emby
emby_base_dir="$HOME/emby"
mkdir -p "$emby_base_dir/config" "$emby_base_dir/data/tvshows" "$emby_base_dir/data/movies"

# Run the Emby Docker container with device mapping for hardware acceleration
docker run -d \
  --name=emby \
  -e PUID=$(id -u) \
  -e PGID=$(id -g) \
  -e TZ=$(cat /etc/timezone) \
  -p 8096:8096 \
  -p 8920:8920 \
  -v "$emby_base_dir/config:/config" \
  -v "$emby_base_dir/data/tvshows:/data/tvshows" \
  -v "$emby_base_dir/data/movies:/data/movies" \
  --device=/dev/dri:/dev/dri \
  --restart unless-stopped \
  lscr.io/linuxserver/emby:latest

# Final dialog message
MSG="Emby Docker container has been set up.\n\nAccess Emby Web UI at http://<your-ip>:8096\nEmby data stored in: $emby_base_dir\n\nAdjust other settings in your clients as needed.\nThe container can be managed via Portainer web UI on port 9443."
dialog --title "Emby Setup Complete" --msgbox "$MSG" 20 70

clear
