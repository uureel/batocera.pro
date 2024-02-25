#!/bin/bash

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
  
