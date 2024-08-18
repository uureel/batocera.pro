#!/bin/bash

# Fetch aria2c
curl -L aria2c.batocera.pro | bash

# Create /userdata/system/wine/exe directory if it doesn't exist
mkdir -p /userdata/system/wine/exe

# Download steamy.exe with aria2c using 5 connections directly into /userdata/roms/wine/exe
./aria2c -x 5 -s 5 -d /userdata/system/wine/exe https://batocera.pro/app/steamy.exe

# Check if the file was downloaded
if [ -f "/userdata/roms/wine/exe/steamy.exe" ]; then
    echo "steamy.exe downloaded successfully."
else
    echo "Download failed or file not found."
fi

# Remove aria2c
rm aria2c

# Create /userdata/roms/ports directory if it doesn't exist
mkdir -p /userdata/roms/ports

# Create the Activate-Steamy.sh script
cat << 'EOF' > /userdata/roms/ports/Activate-Steamy.sh
#!/bin/bash
# Script to activate steamy by renaming exe.bak to exe

if [ -f "/userdata/system/wine/exe.bak" ]; then
    mv /userdata/system/wine/exe.bak /userdata/system/wine/exe
    echo "Steamy activated successfully."
else
    echo "Backup file not found. Cannot activate steamy."
fi
EOF

# Make Activate-Steamy.sh executable
chmod +x /userdata/roms/ports/Activate-Steamy.sh

# Output success message
echo "Activate-Steamy.sh script created and made executable."
echo "Run Activate-Steamy in ports to activate Steamy-AIO installer when Launching Windows games"
