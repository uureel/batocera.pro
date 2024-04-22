#!/bin/bash

# Define the path to conty.sh
conty_path="/userdata/system/pro/steam/conty.sh"

# Check if conty.sh exists
if [[ ! -f "$conty_path" ]]; then
    # Ask user if they want to install conty.sh
    install_option=$(dialog --title "Arch Container Missing" --yesno "Arch Container appears to be not installed. Do you want to install it now?" 10 60 3>&1 1>&2 2>&3)
    response=$?
    if [[ $response -eq 0 ]]; then
        # User chose to install
        if curl -L steam.batocera.pro | bash; then
            # Check if the installation was successful
            if [[ ! -f "$conty_path" ]]; then
                dialog --msgbox "Installation failed. conty.sh still not found. Exiting script." 5 50
                exit 1
            else
                dialog --msgbox "Installation completed successfully." 5 50
            fi
        else
            dialog --msgbox "Installation command failed. Exiting script." 5 50
            exit 1
        fi
    else
        # User chose not to install
        dialog --msgbox "User opted not to install. Exiting script." 5 50
        exit 1
    fi
fi

# Define directories
appimage_dir="/userdata/roms/AppImage"
script_dir="/userdata/roms/ports"

# Ask user if they want to process all AppImages or only new ones
process_option=$(dialog --title "Processing Options" --menu "Choose how to process AppImages:" 15 60 2 1 "All AppImages" 2 "Only new AppImages" 3>&1 1>&2 2>&3)

# Loop through all .AppImage files in the directory
for appimage in "$appimage_dir"/*.AppImage; do
    if [[ -f "$appimage" ]]; then
        # Make the AppImage executable
        chmod +x "$appimage"

        # Define script path
        appimage_base=$(basename "$appimage" .AppImage)
        script_path="$script_dir/$appimage_base.sh"

        # Check if script already exists
        if [[ "$process_option" -eq 2 && -f "$script_path" ]]; then
            continue # Skip processing this AppImage
        fi

        # Display filename in dialog
        appimage_name=$(basename "$appimage")

        # Ask for no-sandbox option
        sandbox_option=$(dialog --title "Sandbox Option for $appimage_name" --menu "Add --no-sandbox flag to $appimage_name? Needed for Chromium/Electron apps running as root" 15 60 2 1 "Yes" 2 "No" 3>&1 1>&2 2>&3)
        sandbox_cmd=""
        if [[ "$sandbox_option" -eq 1 ]]; then
            sandbox_cmd="--no-sandbox"
        fi

        # Write the new script file
        echo "#!/bin/bash" > "$script_path"
        echo "#------------------------------------------------" >> "$script_path"
        echo "conty=/userdata/system/pro/steam/conty.sh" >> "$script_path"
        echo "#------------------------------------------------" >> "$script_path"
        echo "batocera-mouse show" >> "$script_path"
        echo "#------------------------------------------------" >> "$script_path"
        echo '  "$conty" \' >> "$script_path"
        echo "          --bind /userdata/system/containers/storage /var/lib/containers/storage \\" >> "$script_path"
        echo "          --bind /userdata/system/flatpak /var/lib/flatpak \\" >> "$script_path"
        echo "          --bind /userdata/system/etc/passwd /etc/passwd \\" >> "$script_path"
        echo "          --bind /userdata/system/etc/group /etc/group \\" >> "$script_path"
        echo "          --bind /var/run/nvidia /var/run/nvidia \\" >> "$script_path"
        echo "          --bind /userdata/system /home/batocera \\" >> "$script_path"
        echo "          --bind /sys/fs/cgroup /sys/fs/cgroup \\" >> "$script_path"
        echo "          --bind /userdata/system /home/root \\" >> "$script_path"
        echo "          --bind /etc/fonts /etc/fonts \\" >> "$script_path"
        echo "          --bind /userdata /userdata \\" >> "$script_path"
        echo "          --bind /newroot /newroot \\" >> "$script_path"
        echo "          --bind / /batocera \\" >> "$script_path"
        echo "  bash -c 'prepare && ulimit -H -n 819200 && ulimit -S -n 819200 && sysctl -w fs.inotify.max_user_watches=8192000 vm.max_map_count=2147483642 fs.file-max=8192000 >/dev/null 2>&1 && dbus-run-session $appimage $sandbox_cmd \"\$\{@\}\"'" >> "$script_path"
        echo "#------------------------------------------------" >> "$script_path"
        echo "batocera-mouse hide" >> "$script_path"
        echo "#------------------------------------------------" >> "$script_path"
        chmod +x "$script_path"
    fi
done

# Close any open dialog boxes
dialog --clear

curl http://127.0.0.1:1234/reloadgames

