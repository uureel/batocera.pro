#!/bin/bash

PAGE_URL="https://archive.org/download/retro-roms-best-set"
TEMP_DIR="/userdata/roms/temp"
TARGET_DIR="/userdata/roms"

# Ensure aria2 and dialog are installed
command -v aria2c >/dev/null 2>&1 || { echo >&2 "aria2 is not installed. Please install it to proceed."; exit 1; }
command -v dialog >/dev/null 2>&1 || { echo >&2 "dialog is not installed. Please install it to proceed."; exit 1; }

# Create temp directory if it doesn't exist
mkdir -p "$TEMP_DIR"

# Navigate to temp directory
cd "$TEMP_DIR"

# Fetch and parse the webpage content for download links (this is a placeholder command; adjust as needed)
# Assuming that the file names and download links can be extracted directly
download_links=$(curl -s "$PAGE_URL" | grep -oP 'href="[^"]*.zip"' | awk -F'"' '{print $2}')

# Use dialog to create a checklist menu from the extracted links for user selection
# Convert download links into a dialog-compatible format
dialog_input=()
for link in $download_links; do
    dialog_input+=("$link" "" off)
done

# Show dialog and capture selected files
SELECTED_FILES=$(dialog --stdout --checklist "Select files to download:" 22 76 16 "${dialog_input[@]}")

# Download the selected files using aria2
for file in $SELECTED_FILES; do
    aria2c -x 10 "$PAGE_URL/$file"
done

# Scan TARGET_DIR for subdirectories to present in dialog
cd "$TARGET_DIR"
subdirs=($(find . -maxdepth 1 -type d))
dialog_input=()
for subdir in "${subdirs[@]}"; do
    if [[ "$subdir" != "." ]]; then # Exclude current directory
        dialog_input+=("$subdir" "" off)
    fi
done

# Show dialog for user to select target directory for extraction
EXTRACT_DIR=$(dialog --stdout --radiolist "Select target directory for extraction:" 22 76 16 "${dialog_input[@]}")

# Extract selected files to chosen directory
for file in $SELECTED_FILES; do
    unzip -o "$TEMP_DIR/$file" -d "$TARGET_DIR/$EXTRACT_DIR"
done

# Clean up by deleting the temp directory
rm -rf "$TEMP_DIR"

# Exit the script
exit 0
