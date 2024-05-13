#!/bin/bash

# Function to check if a port is in use
is_port_in_use() {
    if lsof -i:$1 > /dev/null; then
        return 0 # True, port is in use
    else
        return 1 # False, port is not in use
    fi
}

# Check if port 3000 is in use
if is_port_in_use 3000; then
    dialog --title "Port Conflict" --msgbox "Port 3000 is already in use. Please ensure it is available before installing Open Web UI." 10 50
    clear
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

# Directories for Open Web UI
ollama_dir="/root/.ollama"
open_webui_data_dir="/app/backend/data"
docker_volume_ollama="ollama"
docker_volume_open_webui="open-webui"

# Create Docker volumes if they do not exist
docker volume create $docker_volume_ollama > /dev/null
docker volume create $docker_volume_open_webui > /dev/null

# Run the Open Web UI Docker container
docker run -d \
  -p 3000:8080 \
  --device=/dev/dri:/dev/dri \
  -v "$docker_volume_ollama:$ollama_dir" \
  -v "$docker_volume_open_webui:$open_webui_data_dir" \
  --name open-webui \
  --restart always \
  ghcr.io/open-webui/open-webui:ollama

# Final dialog message with Open Web UI management info
MSG="Open Web UI Docker container has been set up.\n\nAccess Open Web UI at http://<your-ip>:3000\n\nAdjust other settings in your clients as needed."
dialog --title "Open Web UI Setup Complete" --msgbox "$MSG" 20 70

