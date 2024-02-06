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

# Animated title
clear
animate_text "Container Updater -- This can take a while depending on CPU, Storage, and Download speeds"

# Step 1: (Re)Create the target directory if it doesn't exist
rm -rf ~/pro/steam/build
mkdir -p ~/pro/steam/build

# Step 2: Navigate to the directory
cd ~/pro/steam/build

# Step 3: Download the scripts from the GitHub repository
wget https://raw.githubusercontent.com/uureel/batocera.pro/main/steam/build/compress.sh
wget https://raw.githubusercontent.com/uureel/batocera.pro/main/steam/build/conty-start.sh
wget https://raw.githubusercontent.com/uureel/batocera.pro/main/steam/build/create.sh

# Step 4: Make the scripts executable
chmod +x compress.sh conty-start.sh create.sh

# Animated message indicating the start of create.sh
animate_text "Running create.sh..."
# Step 5: Run create.sh
./create.sh

# Animated message indicating the start of compress.sh
animate_text "Running compress.sh..."
# Step 6: After create.sh completes, run compress.sh
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
