#!/bin/bash

# Exit immediately if a command exits with a non-zero status.
set -e

# Define the file path
filePath="$HOME/pro/steam/conty.sh"

# Check if the file exists
if [ -f "$filePath" ]; then
    echo "File exists, continuing the script..."
else
    echo "It appears the container is not installed. Please install the Arch Steam/lutris/heroic container first, then retry."
    sleep 10
    exit 1
fi

# Create necessary directories
mkdir -p /userdata/desktop ~/service ~/services
mkdir -p ~/service/dir_ob

# Download files to dir_ob and make batocera-compositor executable

# Change curl to wget commands
wget -O ~/service/dir_ob/batocera-compositor https://github.com/uureel/batocera.pro/raw/main/steam/desktop/service/dir_ob/batocera-compositor
wget -O ~/service/dir_ob/full.xml https://github.com/uureel/batocera.pro/raw/main/steam/desktop/service/dir_ob/full.xml
wget -O ~/service/dir_ob/window.xml https://github.com/uureel/batocera.pro/raw/main/steam/desktop/service/dir_ob/window.xml


# Convert downloaded XML files to Unix format
dos2unix ~/service/dir_ob/full.xml
dos2unix ~/service/dir_ob/window.xml

# Download windowed file to services and make it executable
echo "Downloading windowed script..."
curl -L -o ~/services/windowed https://github.com/uureel/batocera.pro/raw/main/steam/desktop/services/windowed
chmod +x ~/services/windowed

# Convert windowed script to Unix format
dos2unix ~/services/windowed

# Download desktop environment scripts to /userdata/desktop and make them executable
echo "Downloading LXDE script..."
curl -L -o /userdata/desktop/LXDE.sh https://github.com/uureel/batocera.pro/raw/main/steam/desktop/LXDE.sh
echo "Downloading MATE script..."
curl -L -o /userdata/desktop/MATE.sh https://github.com/uureel/batocera.pro/raw/main/steam/desktop/MATE.sh
#echo "Downloading XFCE script..."
#curl -L -o /userdata/desktop/XFCE.sh https://github.com/uureel/batocera.pro/raw/main/steam/desktop/XFCE.sh
chmod +x /userdata/desktop/LXDE.sh
chmod +x /userdata/desktop/MATE.sh
#chmod +x /userdata/desktop/XFCE.sh

# Convert downloaded shell scripts to Unix format
dos2unix /userdata/desktop/LXDE.sh
dos2unix /userdata/desktop/MATE.sh
#dos2unix /userdata/desktop/XFCE.sh

# Display completion message
dialog --title "Installation Complete" --msgbox " To access desktop mode:\n1. In Emulationstation, Go to Main Menu-->System Settings-->services and toggle on the windowed service. Make sure to select back to save service \n2. Reboot Batocera.\n3. Press F1. You should see a windowed pcmanFM file manager.\n4. In /userdata/desktop, launch one of the desktop environment scripts. (can take a while) \n5. To revert back to regular mode, simply deactivate windowed service and reboot" 12 80

