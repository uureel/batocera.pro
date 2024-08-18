#!/bin/bash

# Fetch aria2c
curl -L aria2c.batocera.pro | bash

# Create /userdata/system/wine/exe directory if it doesn't exist
mkdir -p /userdata/system/wine/exe

# Download steamy.exe with aria2c using 5 connections directly into /userdata/roms/wine/exe
./aria2c -x 5 -s 5 -d /userdata/system/wine/exe https://batocera.pro/app/steamy.exe

# Check if the file was downloaded
if [ -f "/userdata/system/wine/exe/steamy.exe" ]; then
    echo "steamy.exe downloaded successfully."
else
    echo "Download failed or file not found."
fi

# Remove aria2c
rm aria2c

clear

# Output success message
echo "Steamy-AIO downloaded to /userdata/system/wine/exe."
echo ""
echo ""
echo "Rename /userdata/system/wine/exe.bak to /userdata/system/wine/exe anytime"
echo "you need to launch steamy-aio dependency installer before the windows game launches"
