#!/bin/bash

# Initial setup
BACKTITLE="Docker Netboot.xyz Setup"
architecture=$(uname -m)

# Check system architecture
if [ "$architecture" != "x86_64" ]; then
    dialog --title "Architecture Error" --msgbox "This script only runs on AMD or Intel (x86_64) CPUs, not on $architecture." 10 50
    clear
    exit 1
fi

# Check for Docker
if ! command -v docker &> /dev/null; then
    dialog --title "Docker Installation" --infobox "Docker could not be found. Installing Docker..." 10 50
    curl -L https://github.com/uureel/batocera.pro/raw/main/docker/install.sh | bash
    if ! command -v docker &> /dev/null; then
        dialog --title "Docker Installation Error" --msgbox "Docker installation failed. Please install Docker manually." 10 50
        clear
        exit 1
    fi
fi

# Get network interface
INTERFACE=$(dialog --stdout --inputbox "Enter the network interface (e.g., eth0, wlan0):" 8 45 "$(ip route | awk '/default/ { print $5 }')") || exit
clear

# Get DHCP range start
DHCP_RANGE_START=$(dialog --stdout --inputbox "Enter the DHCP range start IP (e.g., 192.168.0.1):" 8 45 "192.168.0.10") || exit
clear

# Get container IP
CONTAINER_IP=$(dialog --stdout --inputbox "Enter the container IP (e.g., 192.168.0.250):" 8 45 "192.168.0.250") || exit
clear

# Get gateway IP
GATEWAY=$(dialog --stdout --inputbox "Enter the gateway IP (e.g., 192.168.0.1):" 8 45 "$(ip route | awk '/default/ { print $3 }')") || exit
clear

# Get subnet (CIDR notation)
SUBNET=$(dialog --stdout --inputbox "Enter the subnet in CIDR format (e.g., 192.168.0.0/24):" 8 45 "192.168.0.0/24") || exit
clear

# Run Docker Container
docker run -d \
  --name=netbootxyz \
  --net=host \
  --cap-add=NET_ADMIN \
  -e INTERFACE=$INTERFACE \
  -e DHCP_RANGE_START=$DHCP_RANGE_START \
  -e GATEWAY=$GATEWAY \
  -e SUBNET=$SUBNET \
  -e CONTAINER_IP=$CONTAINER_IP \
  samdbmg/dhcp-netboot.xyz

# Setup Firewall Rules
dialog --title "Setting up Firewall" --infobox "Configuring firewall rules to allow PXE boot traffic..." 10 50
sudo ufw allow proto udp from any to any port 67
sudo ufw allow proto udp from any to any port 69
sudo ufw allow proto udp from any to any port 4011
sudo ufw allow proto tcp from any to any port 80

# Final message to the user
MSG="Your Netboot.xyz docker container has been started with the following configurations:\n
- Network Interface: $INTERFACE\n
- DHCP Range Start: $DHCP_RANGE_START\n
- Gateway IP: $GATEWAY\n
- Subnet: $SUBNET\n
- Container IP: $CONTAINER_IP\n
- Ports opened: 67 (DHCP), 69 (TFTP), 4011 (PXE), 80 (HTTP)\n
\nYou can now boot clients via PXE and access installers and utilities through netboot.xyz.\n
\nRemember to remove the firewall rules and shutdown the container when you're done."

# Use dialog to display the message
dialog --title "Netboot Setup Complete" --msgbox "$MSG" 20 70
clear

