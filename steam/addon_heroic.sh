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
dialog --title "Heroic Installation Notice" --msgbox "This will install a Heroic system and parser in EmulationStation.\n\nNote: You must Select 'add shortcut' for each game in Heroic for the \"+UPDATE SHORTCUTS\" parser to work. Set WINE-GE as default runner for best results" 10 60

# User pressed OK, proceed with the script
# Define variables for file paths and URLs
heroic_dir="/userdata/roms/heroic2"
update_script_url="https://github.com/uureel/batocera.pro/raw/main/steam/shortcuts/%2BUPDATE-HEROIC-SHORTCUTS.sh"
update_script_path="${heroic_dir}/+UPDATE-HEROIC-SHORTCUTS.sh"
es_config_dir="$HOME/configs/emulationstation"
es_config_url="https://github.com/uureel/batocera.pro/raw/main/steam/shortcuts/es_configs/es_systems_heroic2.cfg"
es_config_path="${es_config_dir}/es_systems_heroic2.cfg"

# Create heroic directory if it doesn't exist
if [ ! -d "$heroic_dir" ]; then
    mkdir -p "$heroic_dir"
fi

# Download +UPDATE-HEROIC-SHORTCUTS.sh and make it executable
curl -L "$update_script_url" -o "$update_script_path"
chmod +x "$update_script_path"

# Download es_systems_heroic2.cfg
if [ ! -d "$es_config_dir" ]; then
    mkdir -p "$es_config_dir"
fi
curl -L "$es_config_url" -o "$es_config_path"

killall -9 emulationstation
# Clear dialog (necessary for some terminal environments)
clear
echo "Done"
