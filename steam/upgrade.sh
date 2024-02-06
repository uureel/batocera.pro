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

# Function for countdown with option to exit
countdown() {
    local time_left=10
    echo "You have $time_left seconds to press any key to exit. Waiting..."
    while [ $time_left -gt 0 ]; do
        if read -t 1 -n 1; then
            echo -e "\nOperation aborted by the user."
            exit 1
        fi
        ((time_left--))
        echo -ne "Starting in $time_left seconds...\r"
    done
    echo # Ensure the next message is on a new line
}

# Initial message
clear
animate_text "Container Updater - This process may take a long time. You have an option to exit or wait."
# Start countdown and provide an option to exit
countdown

# Proceed with the script operations
animate_text "Proceeding with the operation..."


# Step 0: Remove the ~/pro/steam/build directory
animate_text "Cleaning build directory by removing it..."
rm -rf ~/pro/steam/build

# Verify the directory doesn't exist
if [ -d "~/pro/steam/build" ]; then
    echo "The directory still exists. Please reboot your system and try again."
    exit 1 # Exit the script with an error status
else
    animate_text "The directory has been successfully removed."
fi

# Step 1: Recreate the target directory
mkdir -p ~/pro/steam/build
animate_text "Recreated the build directory."

# Step 2: Navigate to the directory
cd ~/pro/steam/build

# Step 3: Download the scripts from the GitHub repository using curl
animate_text "Downloading scripts..."
curl -L https://raw.githubusercontent.com/uureel/batocera.pro/main/steam/build/compress.sh -o compress.sh
curl -L https://raw.githubusercontent.com/uureel/batocera.pro/main/steam/build/conty-start.sh -o conty-start.sh
curl -L https://raw.githubusercontent.com/uureel/batocera.pro/main/steam/build/create.sh -o create.sh

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
animate_text "Container Updater"

# Step 0: Clean the ~/pro/steam/build directory first
animate_text "Cleaning build directory..."
rm -rf ~/pro/steam/build/*

# Check if the directory is empty
if [ "$(ls -A ~/pro/steam/build)" ]; then
    echo "Failed to clean the build directory. Please reboot your system and try again."
    sleep 5
    exit 1 # Exit the script with an error status
else
    animate_text "Build directory cleaned successfully."
    sleep2
fi

# Step 1: Create the target directory if it doesn't exist (it should already exist but just in case)
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
    sleep 3
else
    echo "conty.sh was not created."
    sleep 3
fi
