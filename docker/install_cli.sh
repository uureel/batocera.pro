#!/bin/bash
# Get the machine hardware name
architecture=$(uname -m)

# Check if the architecture is x86_64 (AMD/Intel)
if [ "$architecture" != "x86_64" ]; then
    echo "This script only runs on AMD or Intel (x86_64) CPUs, not on $architecture."
    exit 1
fi



# Define variables
FILE_ID="1ZGLOM7KeAHg1ZbJXRsotLXHw2ZlGjz4u"
DESTINATION_DIR="$HOME/cli"
FILENAME="cli2.tar.gz"
DOWNLOAD_URL="https://drive.usercontent.google.com/download?id=${FILE_ID}&confirm=t"

# Create the destination directory if it doesn't exist
mkdir -p "$DESTINATION_DIR"

# Download the file using curl
curl -L "${DOWNLOAD_URL}" -o "${FILENAME}"

# Extract the contents to the destination directory
tar -xzvf "${FILENAME}" -C "${DESTINATION_DIR}"


# Modify the run script: change enter_zsh=1 to enter_zsh=0
sed -i 's/enter_zsh=1/enter_zsh=0/' "${DESTINATION_DIR}/run"

#wget https://github.com/garbagescow/batocera.pro/raw/main/docker/docker -O /userdata/system/services/docker
#chmod +x /userdata/system/services/docker

# Add the command to ~/custom.sh before starting Docker and Portainer
echo "bash /userdata/system/cli/run &" >> ~/custom.sh

cd ~/cli
chmod +x run

clear
echo "Starting Docker.."
~/cli/run

clear



# Step 5: Install Portainer
echo "Installing portainer"
docker volume create portainer_data
docker run -d -p 8000:8000 -p 9443:9443 --name portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce:latest

echo "Done." 
echo "Access portainer gui via https://<batoceraipaddress>:9443"
sleep 10
exit
