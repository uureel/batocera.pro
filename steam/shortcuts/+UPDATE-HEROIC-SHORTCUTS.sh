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
batocera-mouse show
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
bash -c 'prepare && dbus-run-session heroic $launch_command --no-gui --no-sandbox '"\${@}"''
#------------------------------------------------
batocera-mouse hide

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

killall -9 emulationstation
echo "Script execution completed."

