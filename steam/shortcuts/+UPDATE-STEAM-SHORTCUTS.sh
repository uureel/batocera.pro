#!/bin/bash

# Update shortcuts
wget -q --tries=30 --no-check-certificate --no-cache --no-cookies --tries=50 -O /tmp/update_shortcuts.sh https://raw.githubusercontent.com/uureel/batocera.pro/main/steam/update_shortcuts.sh
dos2unix /tmp/update_shortcuts.sh 2>/dev/null
chmod 777 /tmp/update_shortcuts.sh 2>/dev/null
bash /tmp/update_shortcuts.sh 
sleep 1

# merge ~/.local/share/applications/* and ~/Desktop/* for scanning
scan=/tmp/.conty-scandir
rm -rf "$scan" 2>/dev/null
mkdir -p "$scan" 2>/dev/null
cp -r ~/.local/share/applications/*.desktop "$scan"/ 2>/dev/null
cp -r ~/Desktop/*.desktop "$scan"/ 2>/dev/null

# Specify the directory to scan and the output file
directory_to_scan="$scan"
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
batocera-mouse show
#------------------------------------------------
killall -9 steam steamfix steamfixer 2>/dev/null
#------------------------------------------------
/userdata/system/pro/steam/conty.sh \\
--bind /userdata/system/containers/storage /var/lib/containers/storage \\
--bind /userdata/system/flatpak /var/lib/flatpak \\
--bind /userdata/system/etc/passwd /etc/passwd \\
--bind /userdata/system/etc/group /etc/group \\
--bind /var/run/nvidia /var/run/nvidia \\
--bind /userdata/system /home/batocera \\
--bind /sys/fs/cgroup /sys/fs/cgroup \\
--bind /userdata/system /home/root \\
--bind /etc/fonts /etc/fonts \\
--bind /userdata /userdata \\
--bind /newroot /newroot \\
--bind / /batocera \\
bash -c 'prepare && source /opt/env && ulimit -H -n 819200 && ulimit -S -n 819200 && sysctl -w fs.inotify.max_user_watches=8192000 vm.max_map_count=2147483642 fs.file-max=8192000 >/dev/null 2>&1 && dbus-run-session steam $steam_url_part -gamepadui' &
#------------------------------------------------
# batocera-mouse hide
#------------------------------------------------

"

    # Create the script file
    script_path="/userdata/roms/steam2/$game_name.sh"
    echo "$script_content" > "$script_path"
    chmod +x "$script_path"
    echo "Script created: $script_path"
done < "$steam_list_file"

rm -rf "$scan" 2>/dev/null

echo "Script execution completed. Check $output_file for the result."
curl http://127.0.0.1:1234/reloadgames

