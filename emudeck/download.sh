#!/bin/bash

# Set the target directory
TARGET_DIR="$HOME/pro/steam/emudeck"

# GitHub user/repo
GH_USER="EmuDeck"
GH_REPO="emudeck-electron"

# API URL for the latest release
API_URL="https://api.github.com/repos/$GH_USER/$GH_REPO/releases/latest"

# Make sure the target directory exists
mkdir -p "$TARGET_DIR"

# Navigate to the target directory
cd "$TARGET_DIR"

# Fetch the latest release data and extract the download URL for the AppImage
APPIMAGE_URL=$(curl -s $API_URL | jq -r '.assets[] | select(.name | endswith(".AppImage")) | .browser_download_url')

# Check if the URL is valid
if [ -z "$APPIMAGE_URL" ]; then
    echo "Failed to find a valid AppImage URL. Exiting."
    exit 1
fi

# Download the AppImage
echo "Downloading $APPIMAGE_URL"
wget -O emudeck.AppImage "$APPIMAGE_URL"

# Make the AppImage executable
chmod +x emudeck.AppImage

echo "Download and setup complete. The AppImage is ready to use in $TARGET_DIR."

sleep 5

# Define the directory where you want to save the files
DESTINATION_DIR="/userdata/roms/conty"

# Create the destination directory if it doesn't exist
mkdir -p "$DESTINATION_DIR"

# Base URL for downloading
BASE_URL="https://raw.githubusercontent.com/uureel/batocera.pro/main/emudeck/shortcuts"

# Declare an array of file names to download
FILES=(
  "Emudeck-EmulationStation-DE.sh"
  "Emudeck-Steam-Rom-Manager.sh"
  "Emudeck.sh"
)

# Loop through the array and download each file
for FILE in "${FILES[@]}"; do
  echo "Downloading $FILE..."
  curl -L "${BASE_URL}/${FILE}" -o "${DESTINATION_DIR}/${FILE}"
done

echo "Download complete."

