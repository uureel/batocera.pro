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
