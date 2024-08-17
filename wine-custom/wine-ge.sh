#!/bin/bash

# Display a notice using dialog
dialog --msgbox "Note: Testing has shown Wine-GE versions above 8.15 appear broken on Batocera." 7 60


# API endpoint for GitHub releases with 100 releases per page
REPO_URL="https://api.github.com/repos/GloriousEggroll/wine-ge-custom/releases?per_page=100"

# Directory to store custom Wine versions
INSTALL_DIR="/userdata/system/wine/custom/"
mkdir -p "$INSTALL_DIR"

# Check for required commands
for cmd in jq dialog wget curl tar; do
    if ! command -v $cmd &> /dev/null; then
        echo "Error: $cmd is not installed."
        exit 1
    fi
done

# Fetch release data from GitHub (up to 100 releases)
echo "Fetching release information..."
release_data=$(curl -s "$REPO_URL")

# Check if curl succeeded
if [[ $? -ne 0 || -z "$release_data" ]]; then
    echo "Failed to fetch release data."
    exit 1
fi

# Prepare the selection menu using dialog
cmd=(dialog --separate-output --checklist "Select Wine/Proton versions to download:" 22 76 16)
options=()
i=1

# Parse JSON and build options array
while IFS= read -r line; do
    name=$(echo "$line" | jq -r '.name')
    tag=$(echo "$line" | jq -r '.tag_name')
    description="${name} - ${tag}"
    options+=($i "$description" off)
    ((i++))
done < <(echo "$release_data" | jq -c '.[]')

# Show dialog, capture selections
choices=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)

# Clear up the dialog artifacts
clear

# Process selections
for choice in $choices; do
    version=$(echo "$release_data" | jq -r ".[$choice-1].tag_name")
    url=$(echo "$release_data" | jq -r ".[$choice-1].assets[] | select(.name | endswith(\"x86_64.tar.xz\")).browser_download_url" | head -n1)

    if [[ -z "$url" ]]; then
        echo "No compatible download found for Wine ${version}."
        continue
    fi

    # Create directory for the selected version
    version_dir="${INSTALL_DIR}wine-${version}"
    mkdir -p "$version_dir"
    cd "$version_dir" || { echo "Failed to change directory."; exit 1; }

    # Download the selected version
    echo "Downloading Wine ${version} from $url"
    wget -q --tries=10 --no-check-certificate --no-cache --no-cookies --show-progress -O "${version_dir}/wine-${version}.tar.xz" "$url"

    # Check if the download was successful
    if [ -f "${version_dir}/wine-${version}.tar.xz" ]; then
        echo "Unpacking Wine ${version}..."
        tar --strip-components=1 -xf "${version_dir}/wine-${version}.tar.xz"
        rm "wine-${version}.tar.xz"
        echo "Installation of Wine ${version} complete."
    else
        echo "Failed to download Wine ${version}."
    fi

    # Return to the initial directory
    cd - > /dev/null
done

echo "All selected versions have been processed."

