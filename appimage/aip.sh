#!/bin/bash

# Define directories
appimage_dir="/userdata/roms/AppImage"
script_dir="/userdata/roms/ports"

# Ensure the AppImage directory exists
mkdir -p "$appimage_dir"

# Initialize a counter for new scripts
new_scripts_count=0

# Loop through all .AppImage files in the directory
for appimage in "$appimage_dir"/*.AppImage; do
    if [[ -f "$appimage" ]]; then
        # Make the AppImage executable
        chmod +x "$appimage"

        # Define script path
        appimage_base=$(basename "$appimage" .AppImage)
        script_path="$script_dir/$appimage_base.sh"

        # Check if script already exists
        if [[ ! -f "$script_path" ]]; then
            # Ask for no-sandbox option
            sandbox_option=$(dialog --title "Sandbox Option for $appimage_base" --menu "Add --no-sandbox flag to $appimage_base? (Useful for chromium/electron based apps running as root)" 15 60 2 1 "Yes" 2 "No" 3>&1 1>&2 2>&3)

            # Determine sandbox command
            sandbox_cmd=""
            if [[ "$sandbox_option" -eq 1 ]]; then
                sandbox_cmd="--no-sandbox"
            fi

            # Ask about showing mouse cursor
            cursor_option=$(dialog --title "Mouse Cursor for $appimage_base" --menu "Show mouse cursor?" 15 60 2 1 "Yes" 2 "No" 3>&1 1>&2 2>&3)

            # Determine cursor commands
            cursor_show_cmd=""
            cursor_hide_cmd=""
            if [[ "$cursor_option" -eq 1 ]]; then
                cursor_show_cmd="unclutter-remote -s"
                cursor_hide_cmd="unclutter-remote -h"
            fi

            # Write the new script file
            echo "#!/bin/bash" > "$script_path"
            echo "$cursor_show_cmd" >> "$script_path"
            echo "LD_LIBRARY_PATH=\"/userdata/system/pro/.dep:\${LD_LIBRARY_PATH}\" DISPLAY=:0.0 $appimage $sandbox_cmd" >> "$script_path"
            echo "$cursor_hide_cmd" >> "$script_path"
            chmod +x "$script_path"

            # Increment the new scripts counter
            new_scripts_count=$((new_scripts_count + 1))
        fi
    fi
done


# Close any open dialog boxes
dialog --clear

# Check if no new scripts were created
if [[ "$new_scripts_count" -eq 0 ]]; then
    echo "No AppImages with missing scripts found."
fi

sleep 5

curl http://127.0.0.1:1234/reloadgames
