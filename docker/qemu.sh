#!/bin/bash

# Initial setup
BACKTITLE="Docker QEMU Virtual Machine Setup"
architecture=$(uname -m)
ISO_URL="https://boot.netboot.xyz/ipxe/netboot.xyz.iso"

# Check system architecture
if [ "$architecture" != "x86_64" ]; then
    dialog --title "Architecture Error" --msgbox "This script only runs on AMD or Intel (x86_64) CPUs, not on $architecture." 10 50
    clear
    exit 1
fi

# Check for Docker
if ! command -v docker &> /dev/null; then
    dialog --title "Docker Installation" --infobox "Docker could not be found. Installing Docker..." 10 50
    curl -L https://get.docker.com | bash
    if ! command -v docker &> /dev/null; then
        dialog --title "Docker Installation Error" --msgbox "Docker installation failed. Please install Docker manually." 10 50
        clear
        exit 1
    fi
fi

# Check if KVM device exists for acceleration
if [ ! -e /dev/kvm ]; then
    dialog --title "KVM Support Error" --msgbox "KVM acceleration not available. Ensure your system supports virtualization and KVM module is loaded." 10 50
    clear
    exit 1
fi

# Function to check if a port is in use
is_port_in_use() {
    netstat -tuln | grep ":$1 " > /dev/null
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

# Check and set the VM port
VM_PORT=8006
if is_port_in_use $VM_PORT; then
    VM_PORT=$(find_next_available_port $VM_PORT)
fi

# Allow user to change the default port if in use
VM_PORT=$(dialog --stdout --inputbox "Enter the VM access port [Default: $VM_PORT]:" 8 45 "$VM_PORT") || exit
clear

# Function to find the next available directory for QEMU VMs
find_next_available_directory() {
    local base_dir="$HOME/qemu_vms"
    if [[ ! -d $base_dir ]] || [[ -z "$(ls -A $base_dir)" ]]; then
        echo $base_dir
    else
        local i=2
        while [[ -d $base_dir$i ]] && [[ ! -z "$(ls -A $base_dir$i)" ]]; do
            i=$((i + 1))
        done
        echo $base_dir$i
    fi
}

# Determine and ensure the directory exists
vm_dir=$(find_next_available_directory)
mkdir -p "$vm_dir"

# User input for configuration
RAM_SIZE=$(dialog --stdout --inputbox "Enter RAM size (e.g., 4G):" 8 45) || exit
CPU_CORES=$(dialog --stdout --inputbox "Enter CPU cores (e.g., 2):" 8 45) || exit
DISK_SIZE=$(dialog --stdout --inputbox "Enter Disk size (e.g., 128G):" 8 45) || exit
clear

# Docker run command, adapted for QEMU with user inputs
docker run -d \
  --name qemu_vm \
  -e BOOT="$ISO_URL" \
  -e RAM_SIZE="$RAM_SIZE" \
  -e CPU_CORES="$CPU_CORES" \
  -e DISK_SIZE="$DISK_SIZE" \
  -p $VM_PORT:8006 \
  --device=/dev/kvm \
  --cap-add NET_ADMIN \
  -v "$vm_dir:/storage" \
  qemux/qemu-docker

# Final message to the user
MSG="Your QEMU Virtual Machine has been started with the following configurations:\n
- RAM Size: $RAM_SIZE\n
- CPU Cores: $CPU_CORES\n
- Disk Size: $DISK_SIZE\n
- Access the VM via your web browser via http:// on batoceras ip port $VM_PORT.\n
- The container can be manageed via cli or Portainer
\nVM files are stored in: $vm_dir\n\nRemember, initial setup and interactions with the VM should be done through the web browser interface."

# Use dialog to display the message
dialog --title "VM Setup Complete" --msgbox "$MSG" 20 70
clear

