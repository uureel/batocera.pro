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
#------------------------------------------------
batocera-mouse show
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
bash -c 'prepare && ulimit -H -n 819200 && ulimit -S -n 819200 && sysctl -w fs.inotify.max_user_watches=8192000 vm.max_map_count=2147483642 fs.file-max=8192000 >/dev/null 2>&1 && dbus-run-session heroic $launch_command --no-gui --no-sandbox'
#------------------------------------------------
batocera-mouse hide
#------------------------------------------------

"
# HEROIC COMMAND:  heroic $launch_command --no-gui --no-sandbox


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

rm -rf "$scan" 2>/dev/null

curl http://127.0.0.1:1234/reloadgames
echo "Script execution completed."

