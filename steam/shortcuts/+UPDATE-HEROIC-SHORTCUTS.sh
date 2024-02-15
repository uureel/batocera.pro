#!/bin/bash
# Specify the directory to scan
directory_to_scan="$HOME/Desktop"

# Iterate through .desktop files in the specified directory
for file_path in "$directory_to_scan"/*.desktop; do
    # Check if the file exists
    if [ -f "$file_path" ]; then
        # Check if the Exec line contains 'heroic'
        if grep -q '^Exec=.*heroic.*' "$file_path"; then
            # Extract the base name of the file, replace spaces with underscores, and remove special characters
            base_name=$(basename "$file_path" .desktop | sed 's/ /_/g' | sed 's/[^a-zA-Z0-9_]//g')

            # Create the script filename using the sanitized base name
            script_filename="${base_name}.sh"
            script_path="/userdata/roms/heroic2/${script_filename}"

            # Extract the game launch command
            launch_command=$(grep '^Exec=' "$file_path" | sed -E 's/^Exec=(.+)$/\1/')

            # Create the script content with the specific launch command setup
            script_content="#!/bin/bash

home=/userdata/system/pro/steam/home
mkdir -p ~/.local /home $home 2>/dev/null
ln -s /userdata/system /home/root 2>/dev/null
chmod -R 777 /var/run/pulse
chmod 777 ~/.local/*
chmod 777 ~/.local

dir1=/userdata/system/pro/steam/home
dir2=/userdata/system/.local/share/Conty
dir3=/userdata/system/.cache
mkdir -p $dir1 $dir2 $dir3 2>/dev/null
chown -R batocera:batocera $dir1 $dir2 $dir3 2>/dev/null

eval \$(dbus-launch --sh-syntax)
sysctl -w vm.max_map_count=2147483642
ulimit -H -n 819200
ulimit -S -n 819200
unclutter-remote -s
ALLOW_ROOT=1 DISPLAY=:0.0 ~/pro/steam/conty.sh heroic $launch_command --no-gui --no-sandbox
unclutter-remote -h"

            # Write the script content to the file and make it executable
            echo "$script_content" > "$script_path"
            chmod +x "$script_path"

            # Output the path of the created script for confirmation
            echo "Script created: $script_path"
        fi
    fi
done

for file in *.sh; do
  # Check if the filename contains an underscore
  if [[ "$file" == *_* ]]; then
    # Replace underscores with spaces in the filename
    new_name=$(echo "$file" | tr '_' ' ')
    # Rename the file
    mv "$file" "$new_name"
    echo "Renamed $file to $new_name"
  fi
done

killall -9 emulationstation
echo "Script execution completed."

