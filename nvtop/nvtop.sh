#!/bin/bash

# Animated intro title
print_intro() {
    local intro_message="Downloading the latest nvtop version to ~/pro/nvtop and adding it to ports..."
    local delay=0.05
    echo -n "Starting: "
    for (( i=0; i<${#intro_message}; i++ )); do
        echo -n "${intro_message:$i:1}"
        sleep $delay
    done
    echo -e "\n"
}

# Call the intro function to display the message
print_intro

# Define where to save the AppImage and the script
appimage_directory=~/pro/nvtop
script_path=/userdata/roms/ports/nvtop.sh

# GitHub user and repository
github_user="Syllo"
github_repo="nvtop"

# Create the directory if it doesn't exist
mkdir -p "$appimage_directory"

# Fetch the latest release download URL for the AppImage
latest_release_url=$(curl -s https://api.github.com/repos/$github_user/$github_repo/releases/latest | jq -r '.assets[] | select(.name | endswith(".AppImage")) | .browser_download_url')

# Extract the file name
appimage_name=$(basename "$latest_release_url")

# Download the latest AppImage version
curl -L "$latest_release_url" -o "$appimage_directory/$appimage_name"

# Make the AppImage executable
chmod +x "$appimage_directory/$appimage_name"

# Create the shell script
cat > "$script_path" <<EOF
#!/bin/bash
DISPLAY=:0.0 xterm -fs 30 -maximized -fg white -bg black -fa "DejaVuSansMono" -en UTF-8 -e bash -c "DISPLAY=:0.0 $appimage_directory/$appimage_name"
EOF

# Make the shell script executable
chmod +x "$script_path"

echo "nvtop setup is complete."
echo "DONE"
sleep 5 

curl http://127.0.0.1:1234/reloadgames

