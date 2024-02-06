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

# Clear the screen and display animated title
clear
animate_text "Container Updater: Depending on CPU, Storage, and Download speed, this can take a while"

# Step 0: Clean the ~/pro/steam/build directory first
animate_text "Cleaning build directory..."
rm -rf ~/pro/steam/build/*

# Step 1: Create the target directory if it doesn't exist
mkdir -p ~/pro/steam/build

# Step 2: Navigate to the directory
cd ~/pro/steam/build

# Step 3: Download the scripts from the GitHub repository
wget https://raw.githubusercontent.com/uureel/batocera.pro/main/steam/build/compress.sh
wget https://raw.githubusercontent.com/uureel/batocera.pro/main/steam/build/conty-start.sh
wget https://raw.githubusercontent.com/uureel/batocera.pro/main/steam/build/create.sh

# Step 4: Make the scripts executable
chmod +x compress.sh conty-start.sh create.sh

# Display animated messages and run scripts
animate_text "Running create.sh..."
./create.sh

animate_text "Running compress.sh..."
./compress.sh

# Step 7: Check if conty.sh is successfully created and make it executable
if [ -f "conty.sh" ]; then
    chmod +x conty.sh
    # Step 8: Move conty.sh to ~/pro/steam
    mv conty.sh ~/pro/steam/
    animate_text "conty.sh creation and move successful!"
else
    echo "conty.sh was not created."
fi
echo "Done"
sleep 6
