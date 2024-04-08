#!/bin/bash

# Ensure dialog is installed
if ! command -v dialog &> /dev/null; then
    echo "Dialog is not installed. Please install dialog first."
    exit 1
fi

# Check for Docker installation
if ! command -v docker &> /dev/null; then
    dialog --title "Docker Installation" --infobox "Docker could not be found. Installing Docker..." 10 50
    sleep 2 # Gives user time to read the message
    curl -L https://github.com/uureel/batocera.pro/raw/main/docker/install.sh | bash
    if ! command -v docker &> /dev/null; then
        dialog --title "Docker Installation Error" --msgbox "Docker installation failed. Please install Docker manually." 10 50
        clear
        exit 1
    fi
fi

# Function to check if port is in use
is_port_in_use() {
    netstat -tuln | grep ":$1 " > /dev/null
    return $?
}

# Function to find the next available port starting from 8080
find_next_available_port() {
    local port=8080
    while is_port_in_use $port; do
        port=$((port + 1))
    done
    echo $port
}

# Determine and set the port for SABnzbd
SABNZBD_PORT=$(find_next_available_port)

# Set up directories for SABnzbd
sabnzbd_base_dir="$HOME/sabnzbd"
mkdir -p "$sabnzbd_base_dir/config" "$sabnzbd_base_dir/downloads" "$sabnzbd_base_dir/incomplete-downloads"

# Run the SABnzbd Docker container
docker run -d \
  --name=sabnzbd \
  -e PUID=$(id -u) \
  -e PGID=$(id -g) \
  -e TZ=$(cat /etc/timezone) \
  -p $SABNZBD_PORT:8080 \
  -v "$sabnzbd_base_dir/config:/config" \
  -v "$sabnzbd_base_dir/downloads:/downloads" \
  -v "$sabnzbd_base_dir/incomplete-downloads:/incomplete-downloads" \
  --restart unless-stopped \
  lscr.io/linuxserver/sabnzbd:latest

# Final message with dialog
MSG="SABnzbd Docker container has been set up.\n\nAccess SABnzbd Web UI at http://<your-ip>:$SABNZBD_PORT\nSABnzbd data stored in: $sabnzbd_base_dir\nContainer can be managed in Portainer via port 9443"
dialog --title "SABnzbd Setup Complete" --msgbox "$MSG" 15 70

clear
