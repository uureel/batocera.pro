#!/bin/bash
# Get the machine hardware name
architecture=$(uname -m)

# Check if the architecture is x86_64 (AMD/Intel)
if [ "$architecture" != "x86_64" ]; then
    echo "This script only runs on AMD or Intel (x86_64) CPUs, not on $architecture."
    exit 1
fi



echo "Downloading Docker & Podman"
echo ""



#!/bin/bash

# Define the directory and the URL for the file
directory="$HOME/pocker"
url="https://batocera.pro/app/batocera-containers"
filename="batocera-containers" # Explicitly set the filename

# Create the directory if it doesn't exist
mkdir -p "$directory"

# Change to the directory
cd "$directory"

# Download the file with the specified filename
wget "$url" -O "$filename"

# Make the file executable
chmod +x "$filename"

echo "File '$filename' downloaded and made executable in '$directory/$filename'"

# Add the command to ~/custom.sh before starting Docker and Portainer
echo "bash /userdata/system/pocker/batocera-containers &" >> ~/custom.sh

cd ~/pocker

clear
echo "Starting Docker.."
~/pocker/batocera-containers

clear



# Step 5: Install Portainer
echo "Installing portainer"
docker volume create portainer_data
docker run -d -p 8000:8000 -p 9443:9443 --name portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce:latest

echo "Done." 
echo "Access portainer gui via https://<batoceraipaddress>:9443"
sleep 10
exit
