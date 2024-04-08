#!/bin/bash

# Ensure dialog is available
if ! command -v dialog &> /dev/null; then
    echo "Dialog is not installed. Please install dialog first."
    exit 1
fi

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

# Directories for Jellyfin
jellyfin_base_dir="$HOME/jellyfin"
mkdir -p "$jellyfin_base_dir/config" "$jellyfin_base_dir/data/tvshows" "$jellyfin_base_dir/data/movies"

# Run the Jellyfin Docker container with device mapping for hardware acceleration
docker run -d \
  --name=jellyfin \
  -e PUID=$(id -u) \
  -e PGID=$(id -g) \
  -e TZ=$(cat /etc/timezone) \
  -p 8096:8096 \
  -p 8920:8920 \
  -p 7359:7359/udp \
  -p 1900:1900/udp \
  -v "$jellyfin_base_dir/config:/config" \
  -v "$jellyfin_base_dir/data/tvshows:/data/tvshows" \
  -v "$jellyfin_base_dir/data/movies:/data/movies" \
  --device=/dev/dri:/dev/dri \
  --restart unless-stopped \
  lscr.io/linuxserver/jellyfin:latest
  
  # Final dialog message with Portainer management info
MSG="Jellyfin Docker container has been set up.\n\nAccess Jellyfin Web UI at http://<your-ip>:8096\nJellyfin data stored in: $jellyfin_base_dir\n\nAdjust other settings in your clients as needed.\n\nThe container can be managed via Portainer web UI on port 9443."
dialog --title "Jellyfin Setup Complete" --msgbox "$MSG" 20 70

clear
