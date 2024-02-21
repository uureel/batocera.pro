#!/bin/bash
# Specify the directory to scan and the output file
directory_to_scan="/userdata/system/.local/share/applications"
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
        exec_line=$(grep '^Exec=steam steam://rungameid/' "$file_path" | sed -n "s/^Exec=steam steam:\/\/rungameid\/\([0-9]\+\)/\1/p")
        if [ -n "$exec_line" ]; then
            # Append the information to the output file
            echo "$filename steam steam://rungameid/$exec_line" >> "$output_file"
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

    # Create the script content without an undesired trailing quote
    script_content="#!/bin/bash

#------------------------------------------------
conty=/userdata/system/pro/steam/conty.sh
#------------------------------------------------
batocera-mouse show
killall -9 steam steamfix steamfixer 2>/dev/null
#------------------------------------------------
/userdata/system/pro/steam/conty.sh \
--bind /userdata/system/containers/storage /var/lib/containers/storage \
--bind /userdata/system/flatpak /var/lib/flatpak \
--bind /userdata/system/etc/passwd /etc/passwd \
--bind /userdata/system/etc/group /etc/group \
--bind /var/run/nvidia /var/run/nvidia \
--bind /userdata/system /home/batocera \
--bind /sys/fs/cgroup /sys/fs/cgroup \
--bind /userdata/system /home/root \
--bind /etc/fonts /etc/fonts \
--bind /userdata /userdata \
--bind /newroot /newroot \        
--bind / /batocera \
bash -c 'prepare && dbus-run-session steam $steam_url_part -gamepadui '"\${@}"''
#------------------------------------------------
batocera-mouse hide
#------------------------------------------------

"

    # Create the script file
    script_path="/userdata/roms/steam2/$game_name.sh"
    echo "$script_content" > "$script_path"
    chmod +x "$script_path"
    echo "Script created: $script_path"
done < "$steam_list_file"

echo "Script execution completed. Check $output_file for the result."
killall -9 emulationstation

