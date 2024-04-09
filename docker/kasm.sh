#!/bin/bash


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

# Function to check if port 443 is in use
is_port_in_use() {
    netstat -tuln | grep ":$1 " > /dev/null
    return $?
}

# Check if port 443 is in use and suggest an alternative if it is
WEB_PORT=443
if is_port_in_use $WEB_PORT; then
    dialog --title "Port Conflict" --inputbox "Port 443 is in use. Please enter an alternative port:" 8 40 4443 2>tempfile
    WEB_PORT=$(<tempfile)
    rm tempfile
fi

# Set up directories for Kasm Workspaces
kasm_base_dir="$HOME/kasm"
mkdir -p "$kasm_base_dir/data" "$kasm_base_dir/profiles"

# Run the Kasm Workspaces Docker container
docker run -d \
  --name=kasm \
  --privileged \
  -e KASM_PORT=$-e DOCKER_HUB_USERNAME=batocera `#optional` \
  -e DOCKER_HUB_PASSWORD=linux `#optional` \
  -e DOCKER_MTU=1500 `#optional` \WEB_PORT \ 
  -p 3000:3000 \
  -p $WEB_PORT:$WEB_PORT \
  -v "$kasm_base_dir/data:/opt" \
  -v "$kasm_base_dir/profiles:/profiles" \
  --restart unless-stopped \
  lscr.io/linuxserver/kasm:latest

# Final message with dialog
MSG="Kasm Workspaces Docker container has been set up.\n\nAccess the installation wizard at https://<your-ip>:3000\nOnce setup is complete, access Kasm Workspaces at https://<your-ip>:$WEB_PORT\nData stored in: $kasm_base_dir"
dialog --title "Kasm Workspaces Setup Complete" --msgbox "$MSG" 15 70

clear
