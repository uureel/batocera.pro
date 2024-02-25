#!/bin/bash

# Define a temporary file
tempfile=$(mktemp)

# Write the message to the temporary file
cat > "$tempfile" <<- EOF
EmuDeck Installer Notes:
1. When EmuDeck installs, it will open on the main display. 
Please install and close out to continue installing parsers.
2. You must launch Steam ROM Manager through EmulationStation, not through the EmuDeck UI.
3. If there are no parsers, use the parser fix option to redownload them.
EOF

# Display the message in a dialog box
dialog --title "EmuDeck Installer" --textbox "$tempfile" 20 100

# Clear the screen after dialog exits and remove the temporary file
clear
rm -f "$tempfile"

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

echo "Download Complete. The AppImage is ready to use in $TARGET_DIR."

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
  # Make the file executable
    chmod +x "$DEST_DIR/$file"

echo "Download complete."
sleep 3
echo "Starting Emudeck -- Check your main display -- Please install Emudeck, then close out Emudeck to continue installation"
sleeo 10
/userdata/roms/conty/Emudeck.sh

echo "Continuing install"
echo "Downloading Steam ROM Manager parser fix"

##!/bin/bash

# Define the target directory
target_dir="$HOME/.config/steam-rom-manager/userData"

# Define base URL for the fix_parser files
base_url_fix_parser="https://raw.githubusercontent.com/uureel/batocera.pro/main/emudeck/fix_parser"

# Check if the target directory exists
if [ -d "$target_dir" ]; then
    # The directory exists, proceed with download
    echo "Downloading JSON files..."
    curl -L "${base_url_fix_parser}/userConfigurations.json" -o "${target_dir}/userConfigurations.json"
    curl -L "${base_url_fix_parser}/userSettings.json" -o "${target_dir}/userSettings.json"
  echo "JSON files downloaded successfully."
  echo "Install complete"
  sleep 5
  
else
    # The directory does not exist, display message
    echo "Please install EmuDeck and redownload parser fix after it is installed."
    curl http://127.0.0.1:1234/reloadgames
fi



