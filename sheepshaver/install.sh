#!/bin/bash

# Intro animation for SheepShaver installer
echo "Batocera PRO -- Starting SheepShaver installation..."
sleep 3

# Create directory for SheepShaver if it doesn't exist
mkdir -p ~/pro/sheepshaver

# Download SheepShaver AppImage
echo "Downloading SheepShaver AppImage to /userdata/system/pro/sheepshaver..."
wget https://github.com/uureel/batocera.pro/raw/main/sheepshaver/SheepShaver-x86_64.AppImage -O ~/pro/sheepshaver/SheepShaver-x86_64.AppImage
echo "Download complete."

# Make the AppImage executable
chmod +x ~/pro/sheepshaver/SheepShaver-x86_64.AppImage
clear

# Create a launch script in /userdata/roms/ports
echo "Creating launch script..."
cat <<EOF > /userdata/roms/ports/SheepShaver.sh
#!/bin/bash
DISPLAY=:0.0 ~/pro/sheepshaver/SheepShaver-x86_64.AppImage
EOF

chmod +x /userdata/roms/ports/sheepshaver.sh
echo "Installation complete. You can now launch SheepShaver in PORTS"
sleep 3

curl http://127.0.0.1:1234/reloadgames
