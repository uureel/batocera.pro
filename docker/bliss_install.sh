
# Function to check if a port is in use
is_port_in_use() {
    if lsof -i:$1 > /dev/null; then
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

#Bliss Docker config

docker run -it \
    --privileged \
    --device /dev/kvm \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -e "DISPLAY=${DISPLAY:-:0.0}" \
    --net=host \
    --device=/dev/dri \
    --group-add video \
    -e EXTRA='-display gtk,gl=on -vga qxl -spice port=5930,disable-ticketing' \
    sickcodes/dock-droid:latest


  
  # Final dialog message with Portainer management info
MSG="Bliss OS Docker container has been set up.\n\nBliss-OS can be run from ports\n\nAdjust other settings in your clients as needed.\n\nThe container can be managed via Portainer web UI on port 9443."
dialog --title "Bliss OS Setup Complete" --msgbox "$MSG" 20 70

clear
