#!/bin/bash

clear
# Display a welcome message explaining the script's actions
echo "This script will create the /userdata/roms/AppImage directory."
echo "You can place your AppImages there and use the included tools to generate launch scripts for them."
sleep 10

# Create /userdata/roms/AppImage if it does not exist
if [ ! -d "/userdata/roms/AppImage" ]; then
    mkdir -p /userdata/roms/AppImage
fi

# Create /userdata/system/AppImage if it does not exist
if [ ! -d "/userdata/system/AppImage" ]; then
    mkdir -p /userdata/system/AppImage
fi

# Define the array of URLs to download the scripts
declare -a urls=(
    "https://github.com/uureel/batocera.pro/raw/main/appimage/aip.sh"
    "https://github.com/uureel/batocera.pro/raw/main/appimage/aiparser.sh"
    "https://github.com/uureel/batocera.pro/raw/main/appimage/caip.sh"
)

# Download each script and make it executable
for url in "${urls[@]}"; do
    filename=$(basename "$url")
    wget -O "/userdata/system/AppImage/$filename" "$url"
    chmod +x "/userdata/system/AppImage/$filename"
done

# Download the AppImage Parser script to /userdata/roms/ports and make it executable
wget -O "/userdata/roms/ports/AppImage Parser.sh" "https://github.com/uureel/batocera.pro/raw/main/appimage/AppImage%20Parser.sh"
chmod +x "/userdata/roms/ports/AppImage Parser.sh"

clear 
echo "Setup is complete." 
echo "Put your AppImage files in /userdata/roms/AppImage"
echo "You can now Launch the parser from ports or use the tools in /userdata/system/AppImage."
sleep 10
echo "Done"
curl http://127.0.0.1:1234/reloadgames

