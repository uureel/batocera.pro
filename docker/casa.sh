#!/bin/bash

echo "Batocera.PRO CasaOS installer.."
echo "This can take a while...please wait"

sleep 5

# Define the home directory
HOME_DIR=/userdata/system

# Define URLs for the files
TAR_GZ_URL="batocera.pro/app/batocera-casaos.tar.gz"
EXECUTABLE_URL="batocera.pro/app/batocera-casaos"

# Change to home directory
cd "${HOME_DIR}"
if [ $? -ne 0 ]; then
    echo "Failed to change to home directory. Exiting."
    exit 1
fi

# Download the tar.gz file
echo "Downloading tar.gz file..."
wget "${TAR_GZ_URL}" -O "batocera-casaos.tar.gz"
if [ $? -ne 0 ]; then
    echo "Failed to download tar.gz file. Exiting."
    exit 1
fi

# Unpack the tar.gz file
echo "Unpacking tar.gz file..."
tar -xzvf "batocera-casaos.tar.gz"
if [ $? -ne 0 ]; then
    echo "Failed to unpack tar.gz file. Exiting."
    exit 1
fi

# Remove the tar.gz file after unpacking
rm "batocera-casaos.tar.gz"

# Download the executable
echo "Downloading the executable file..."
wget "${EXECUTABLE_URL}" -O "${HOME_DIR}/casaos/batocera-casaos"
if [ $? -ne 0 ]; then
    echo "Failed to download executable. Exiting."
    exit 1
fi

# Make the executable runnable
chmod +x "${HOME_DIR}/casaos/batocera-casaos"
if [ $? -ne 0 ]; then
    echo "Failed to make the file executable. Exiting."
    exit 1
fi


# Add casa to custom.sh for autostart
echo "/userdata/system/casaos/batocera-casaos &" >> ~/custom.sh

# Run the executable
echo "Running the executable..."
"${HOME_DIR}/casaos/batocera-casaos"
if [ $? -ne 0 ]; then
    echo "Failed to run the executable. Exiting."
    exit 1
fi

# Final dialog message with casaos management info
MSG="Casaos container has been set up.\n\nAccess casa Web UI at http://<your-batocera-ip>:80 nCasaos data stored in: ~/casaos\n\nDefault username/password is batocera/batoceralinux.."
dialog --title "Casaos Setup Complete" --msgbox "$MSG" 20 70
 

echo "Process completed successfully."

echo "1) to stop the container, run:  podman stop casaos"
echo "2) to enter zsh session, run:  podman exec -it casaos zsh"

