#!/bin/bash

# Specify the directory to scan and the output file
directory_to_scan="~/.local/share/applications"
output_file="/userdata/system/pro/steam/steam_list.txt"

# Check if the directory exists
if [ ! -d "$directory_to_scan" ]; then
    echo "Error: Directory '$directory_to_scan' does not exist."
    exit 1
fi

# Remove existing output file
rm -f "$output_file"

# Iterate through .desktop files in the specified directory
for file_path in "$directory_to_scan"/*.desktop; do
    # Check if the file exists
    if [ -f "$file_path" ]; then
        # Extract the filename without extension
        filename=$(basename "$file_path" .desktop)

        # Extract the relevant information using grep and sed
        exec_line=$(grep '^Exec=steam steam://rungameid/' "$file_path" | sed -n "s/^Exec=steam steam:\/\/rungameid\/\([0-9]\+\)/$filename steam steam:\/\/rungameid\/\1/p")
        if [ -n "$exec_line" ]; then
            # Append the information to the output file
            echo "$exec_line" >> "$output_file"
        fi
    fi
done



# Full path to steam_list.txt
steam_list_file="/userdata/system/pro/steam/steam_list.txt"

# Read each line from steam_list.txt
while IFS= read -r line; do
    # Extract game_name and steam_url_part
    game_name=$(echo "$line" | awk -F ' steam ' '{print $1}')
    steam_url_part=$(echo "$line" | awk -F ' steam ' '{print $2}')

    # Create the script content
    script_content="#!/bin/bash
mkdir -p ~/.local
chmod 777 ~/.local
chmod 777 ~/.local/*

echo "starting steam..."
export DISPLAY=:0.0
killall -9 steam steamfix steamfixer 2>/dev/null
sleep 1

# Fix audio permissions 
chown -R root:audio /var/run/pulse
chmod -R g+rwX /var/run/pulse

# Fix directories permissions 
dir1=/userdata/system/pro/steam/home
dir2=/userdata/system/.local/share/Conty
  mkdir -p $dir1 $dir2 2>/dev/null
  chown -R batocera:batocera $dir1 $dir2 2>/dev/null

# Fix ctrl+click bug in openbox 
xbind=/userdata/system/.xbindkeysrc
  rm $xbind 2>/dev/null
  echo '# .xbindkeysrc' >> $xbind
  echo '"xdotool keydown ctrl click 1 keyup ctrl"' >> $xbind
  echo '  b:1 + Release' >> $xbind
  chown -R batocera:batocera "$xbind" 2>/dev/null

unclutter-remote -s

ALLOW_ROOT=1 DISPLAY=:0.0 /userdata/system/pro/steam/conty.sh dbus-run-session steamlauncher $steam_url_part -gamepadui"

    # Create the script file
    script_path="/userdata/roms/steam2/$game_name.sh"
    echo "$script_content" > "$script_path"
    chmod +x "$script_path"

    echo "Script created: $script_path"


echo "Script execution completed. Check $output_file for the result."
done < "$steam_list_file"

killall -9 emulationstation
