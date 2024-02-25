#!/bin/bash

# Define the file path
filePath="$HOME/pro/steam/conty.sh"

# Check if the file exists
if [ -f "$filePath" ]; then
    echo "conty.sh exists, continuing the script..."
   
else
    echo "It appears the container is not installed. Please install the steam/lutris/heroic container first, then retry."
    sleep 10
    exit 1
fi


# Display the dialog message box
dialog --title "Lutris Installation Notice" --msgbox "This will install a Lutris system and parser in EmulationStation.\n\nNote: You must create desktop shortcuts in Lutris for the \"+UPDATE SHORTCUTS\" parser to work." 10 50

# User pressed OK, proceed with the script
# Define variables for file paths and URLs
lutris_dir="/userdata/roms/lutris"
update_script_url="https://github.com/uureel/batocera.pro/raw/main/steam/shortcuts/%2BUPDATE-LUTRIS-SHORTCUTS.sh"
update_script_path="${lutris_dir}/+UPDATE-LUTRIS-SHORTCUTS.sh"
es_config_dir="$HOME/configs/emulationstation"
es_config_url="https://github.com/uureel/batocera.pro/raw/main/steam/shortcuts/es_configs/es_systems_lutris.cfg"
es_config_path="${es_config_dir}/es_systems_lutris.cfg"

# Create lutris directory if it doesn't exist
if [ ! -d "$lutris_dir" ]; then
    mkdir -p "$lutris_dir"
fi

# Download +UPDATE-LUTRIS-SHORTCUTS.sh and make it executable
curl -L "$update_script_url" -o "$update_script_path"
chmod +x "$update_script_path"

# Download es_systems_lutris.cfg
if [ ! -d "$es_config_dir" ]; then
    mkdir -p "$es_config_dir"
fi
curl -L "$es_config_url" -o "$es_config_path"

killall -9 emulationstation
# Clear dialog (necessary for some terminal environments)
clear
echo "Done"
