#!/bin/bash

# Function to simulate animated text
animate_text() {
    local message="$1"
    local delay=0.1
    for (( i=0; i<${#message}; i++ )); do
        echo -n "${message:$i:1}"
        sleep $delay
    done
    echo # Move to a new line
}

# Step 0: Clean the directory
animate_text "Cleaning build directory by removing it..."
rm -rf ~/pro/steam/build

# Verify the directory doesn't exist
if [ -d "~/pro/steam/build" ]; then
    echo "The directory still exists. Please reboot your system and try again."
    exit 1
else
    animate_text "..."
fi

# Recreate the target directory
mkdir -p ~/pro/steam/build
animate_text "Recreated the build directory."

# Navigate to the directory
cd ~/pro/steam/build
rm compress.sh conty-start.sh create.sh 2>/dev/null

# Download the scripts using curl
animate_text "Downloading scripts..."
curl -Ls https://raw.githubusercontent.com/uureel/batocera.pro/main/steam/build/compress.sh -o compress.sh
curl -Ls https://raw.githubusercontent.com/uureel/batocera.pro/main/steam/build/conty-start.sh -o conty-start.sh
curl -Ls https://raw.githubusercontent.com/uureel/batocera.pro/main/steam/build/create.sh -o create.sh

# Make the scripts executable
chmod 777 compress.sh conty-start.sh create.sh 2>/dev/null

# Run scripts with animated messages
animate_text "Running create.sh..."
bash ./create.sh

animate_text "Running compress.sh..."
bash ./compress.sh

# Check if conty.sh is successfully created and make it executable
if [ -f "conty.sh" ]; then
    chmod +x conty.sh
    # Move conty.sh to ~/pro/steam
    animate_text "moving: please wait..."
    mv conty.sh /userdata/system/pro/steam/
    animate_text "conty.sh creation and move successful!"
    sleep 3
    clear
    animate_text "Downloading Shortcuts"

# Update shortcuts
wget -q --tries=30 --no-check-certificate --no-cache --no-cookies --tries=50 -O /tmp/update_shortcuts.sh https://raw.githubusercontent.com/uureel/batocera.pro/main/steam/update_shortcuts.sh
dos2unix /tmp/update_shortcuts.sh 2>/dev/null
chmod 777 /tmp/update_shortcuts.sh 2>/dev/null
bash /tmp/update_shortcuts.sh 
sleep 1

# Clean up
animate_text "Cleaning up"
rm -rf ~/pro/steam/build
echo "DONE"
sleep 5

curl http://127.0.0.1:1234/reloadgames

else
    echo "conty.sh was not created."
fi
