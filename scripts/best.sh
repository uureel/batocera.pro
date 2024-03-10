#!/bin/bash

PAGE_URL="https://archive.org/download/retro-roms-best-set"
DOWNLOAD_DIR="/userdata/roms/temp"

# Create the download directory if it does not exist
mkdir -p "$DOWNLOAD_DIR"

# Fetch the webpage content
WEBPAGE_CONTENT=$(curl -s "$PAGE_URL")

# Parse the webpage content to extract download links and file names, clean up spaces in names for display
echo "$WEBPAGE_CONTENT" | grep -oP 'href="[^"]*.zip"' | sed -e 's/%20/ /g' -e 's/href="//' -e 's/"//' > download_links.txt

# Use dialog to create a checklist menu from the extracted links
# The user can select which files to download
# Clean up spaces for better display
SELECTED_FILES=$(dialog --stdout --checklist "Select files to download:" 0 0 0 $(awk -F'/' '{print $NF " " $NF " off"}' download_links.txt) | sed 's/ /%20/g')

# Download the selected files using aria2
for file in $SELECTED_FILES; do
    aria2c -x 10 -d "$DOWNLOAD_DIR" "$PAGE_URL/$file"
done

# List folders in /userdata/roms for user to select where to extract the downloaded zip
ROMS_DIR="/userdata/roms"
FOLDERS=$(find $ROMS_DIR -maxdepth 1 -type d | awk -F'/' '{print $NF " " $NF " off"}')

# Remove the leading " off" for the root /userdata/roms entry to avoid confusion
FOLDERS=${FOLDERS/" /userdata/roms off"/}

TARGET_DIR=$(dialog --stdout --radiolist "Select target directory for extraction:" 0 0 0 $FOLDERS)

# Extract the downloaded files to the selected directory
for file in $SELECTED_FILES; do
    unzip -o "$DOWNLOAD_DIR/${file//%20/ }" -d "$ROMS_DIR/$TARGET_DIR"
done

# Clean up: remove downloaded files and the temp directory
rm -rf "$DOWNLOAD_DIR"

# Exit the script
exit 0
