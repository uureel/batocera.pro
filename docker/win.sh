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

# Function to check if a port is in use
is_port_in_use() {
    netstat -an | grep ":$1 " > /dev/null
    return $?
}

# Function to find the next available port starting from a given port
find_next_available_port() {
    local port=$1
    while is_port_in_use $port; do
        port=$((port + 1))
    done
    echo $port
}

# Function to find the next available directory for windows
find_next_available_directory() {
    local base_dir="$HOME/windows"
    if [[ ! -d $base_dir ]] || [[ -z "$(ls -A $base_dir)" ]]; then
        # If the directory doesn't exist or is empty
        echo $base_dir
    else
        # Find the next available directory by incrementing a suffix
        local i=2
        while [[ -d $base_dir$i ]] && [[ ! -z "$(ls -A $base_dir$i)" ]]; do
            i=$((i + 1))
        done
        echo $base_dir$i
    fi
}

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
    clear
fi

# Check and set VNC port
VNC_PORT=8006
if is_port_in_use $VNC_PORT; then
    VNC_PORT=$(find_next_available_port $VNC_PORT)
    VNC_PORT=$(dialog --stdout --inputbox "Port 8006 is in use. Enter a different VNC port:" 8 40 $VNC_PORT)
    clear
fi

# Dialogs for configuration
# Select Windows version
VERSION=$(dialog --stdout --backtitle "$BACKTITLE" --title "Windows Version" --menu "Choose a version:" 40 70 4 \
"win11" "Windows 11 Pro" \
"win10" "Windows 10 Pro" \
"ltsc10" "Windows 10 LTSC" \
"win81" "Windows 8.1 Pro" \
"win7" "Windows 7 SP1" \
"vista" "Windows Vista SP2" \
"winxp" "Windows XP SP3" \
"2022" "Windows Server 2022" \
"2019" "Windows Server 2019" \
"2016" "Windows Server 2016" \
"2012" "Windows Server 2012 R2" \
"2008" "Windows Server 2008 R2" \
"core11" "Tiny 11 Core -- archive.org = slow download" \
"tiny11" "Tiny 11 -- archive.org = slow download" \
"tiny10" "Tiny 10 -- archive.org = slow download")
clear

# RAM size
RAM_SIZE=$(dialog --stdout --backtitle "$BACKTITLE" --title "RAM Size" --menu "Select RAM size:" 10 30 3 \
"4G" "4 GB" \
"8G" "8 GB" \
"16G" "16 GB" \
"32G" "32 GB")
clear

# Disk size
DISK_SIZE=$(dialog --stdout --backtitle "$BACKTITLE" --title "Disk Size" --menu "Select Disk size:" 10 40 3 \
"32G" "32 GB" \
"64G" "64 GB" \
"128G" "128 GB" \
"256G" "256 GB" \
"512G" "512 GB" \
"1024G" "1 TB")
clear

# CPU Cores
CPU_CORES=$(dialog --stdout --backtitle "$BACKTITLE" --title "CPU Cores" --menu "Select CPU cores:" 10 30 4 \
"2" "2 Cores" \
"4" "4 Cores" \
"6" "6 Cores" \
"8" "8 Cores")
clear

# Summary and confirmation, including ports in the message
dialog --stdout --backtitle "$BACKTITLE" --yesno "You have configured the Docker container with the following settings:\n\nDirectory: $windows_dir\nWindows Version: $VERSION\nRAM Size: $RAM_SIZE\nDisk Size: $DISK_SIZE\nCPU Cores: $CPU_CORES\nRDP Port: $RDP_PORT\nVNC Port: $VNC_PORT\n\nDo you want to proceed?" 22 76
response=$?

if [ $response -eq 0 ]; then
    echo "Setting up your Docker Windows container..."
    # Docker run command, including port mappings and volume
    docker run -d \
      --name windows_$VERSION \
      -e VERSION="$VERSION" \
      -e RAM_SIZE="$RAM_SIZE" \
      -e DISK_SIZE="$DISK_SIZE" \
      -e CPU_CORES="$CPU_CORES" \
      --device /dev/kvm \
      --cap-add NET_ADMIN \
      -p $RDP_PORT:3389/tcp \
      -p $RDP_PORT:3389/udp \
      -p $VNC_PORT:8006/tcp \
      --stop-timeout 120 \
      --restart on-failure \
      -v "$windows_dir:/storage" \
      dockurr/windows
clear
    # Success message for both RDP and VNC
    if [ $? -eq 0 ]; then
        echo "Access http://batoceraipaddress>:VNC_PORT via your web browser"
        echo "Your Docker Windows container has been started successfully."
        echo "Access the Windows device via RDP on port $RDP_PORT or via VNC on port $VNC_PORT."
        echo "For RDP, in Remmina, create a new connection with Protocol: RDP and Server: localhost:$RDP_PORT."
        echo "Windows files are stored in /userdata/system/windows"
    else
        echo "There was an error starting the Docker Windows container."
    fi
else
    echo "Configuration canceled by user."
fi

# Final message to the user, reminding how to access both RDP and VNC

echo "To access your Windows environment:"
echo "- Via RDP: Connect to localhost:$RDP_PORT with your RDP client."
echo "- Via VNC: Connect to localhost:$VNC_PORT with your brower."
echo "-Remember, inital setup must be done via VNC via web browser - http://batoceraipaddress>:$VNC_PORT"
echo "-Windows files are stored in $windows_dir"
echo "-Adjust other settings in your clients as needed."
echo "-You can manage the container settings in portainer after installation"
echo "-Default rdp username is docker.  Password is blank."

Sleep 20
exit
