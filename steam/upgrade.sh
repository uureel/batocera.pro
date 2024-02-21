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

# Function to show dialog confirmation box
confirm_start() {
    # Ensure dialog is installed
    if ! command -v dialog &> /dev/null; then
        echo "The 'dialog' utility is not installed. Please install it to continue."
        exit 1
    fi

    dialog --title "Confirm Operation" --yesno "This process may take a long time. Do you want to proceed?" 7 60
    local status=$?
    clear # Clear dialog remnants from the screen
    return $status
}

# Initial message
clear
animate_text "Container Updater"

# Show confirmation dialog box
if ! confirm_start; then
    echo "Operation aborted by the user."
    exit 1
fi

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

# Download the scripts using curl
animate_text "Downloading scripts..."
curl -L https://raw.githubusercontent.com/uureel/batocera.pro/main/steam/build/compress.sh -o compress.sh
curl -L https://raw.githubusercontent.com/uureel/batocera.pro/main/steam/build/conty-start.sh -o conty-start.sh
curl -L https://raw.githubusercontent.com/uureel/batocera.pro/main/steam/build/create.sh -o create.sh

# Make the scripts executable
chmod +x compress.sh conty-start.sh create.sh

# Run scripts with animated messages
animate_text "Running create.sh..."
./create.sh

animate_text "Running compress.sh..."
./compress.sh

# Check if conty.sh is successfully created and make it executable
if [ -f "conty.sh" ]; then
    chmod +x conty.sh
    # Move conty.sh to ~/pro/steam
    animate_text "moving: please wait"
    mv conty.sh ~/pro/steam/
    animate_text "conty.sh creation and move successful!"
    sleep 3
    clear
    animate_text "Downloading Shortcuts"
    

github_url="https://github.com/uureel/batocera.pro/raw/main/steam/shortcuts/"
target_directory="/userdata/roms/conty/"

# List of .sh files to download
sh_files=(
  "Antimicrox.sh"
  "Audacity.sh"
  "Balena-Etcher.sh"
  "Blender.sh"
  "Boilr.sh"
  "Brave.sh"
  "Filezilla.sh"
  "Firefox.sh"
  "GameHub.sh"
  "Geforce Now.sh"
  "Gimp.sh"
  "Google-Chrome.sh"
  "Gparted.sh"
  "Greenlight.sh"
  "Handbrake.sh"
  "Heroic Game Launcher.sh"
  "Inkscape.sh" 
  "Kdenlive.sh"
  "Kodi.sh"
  "Libreoffice.sh"
  "Lutris.sh"
  "Microsoft-Edge.sh"
  "Minigalaxy.sh"
  "Moonlight.sh"
  "OBS Studio.sh"
  "Opera.sh"
  "PCManFM (File Manager).sh"
  "Peazip.sh"
  "Play on Linux 4.sh"
  "Protonup-Qt.sh"
  "Qbittorrent.sh"
  "Qdirstat.sh"
  "Smplayer.sh"
  "Shotcut.sh"
  "Steam Big Picture Mode.sh"
  "Steam.sh"
  "SteamTinker Launch (settings).sh"
  "Terminal.sh"
  "Thunderbird.sh"
  "TigerVNC.sh"
  "VLC.sh"
  "Zoom.sh"
)

# Create the target directory if it doesn't exist
mkdir -p "$target_directory"

# Download the specified .sh files and make them executable
for file in "${sh_files[@]}"; do
  # Replace spaces with '%20' for URL encoding
  encoded_file=$(echo "$file" | sed 's/ /%20/g')
  echo "Downloading $file..."
  #curl -sSL "${github_url}${encoded_file}" -o "${target_directory}${file}"
  wget -q --tries=10 --no-check-certificate --no-cache --no-cookies -O "${target_directory}${file}" "${github_url}${encoded_file}"
  chmod +x "${target_directory}${file}"
done
animate_text "Cleaning up"
rm -rf ~/pro/steam/build
echo "DONE"
sleep 5
killall -9 emulationstation


else
    echo "conty.sh was not created."
fi
