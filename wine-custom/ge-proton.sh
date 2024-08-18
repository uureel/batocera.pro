#!/bin/bash

# API endpoint for GitHub releases with 100 releases per page
REPO_URL="https://api.github.com/repos/GloriousEggroll/proton-ge-custom/releases?per_page=100"

# Directory to store custom Wine (Proton-GE) versions
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
cmd=(dialog --separate-output --checklist "Select Proton-GE versions to download:" 22 76 16)
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
    url=$(echo "$release_data" | jq -r ".[$choice-1].assets[] | select(.name | endswith(\".tar.gz\")).browser_download_url" | head -n1)

    if [[ -z "$url" ]]; then
        echo "No compatible download found for Proton ${version}."
        continue
    fi

    # Create directory for the selected version
    version_dir="${INSTALL_DIR}proton-${version}"
    mkdir -p "$version_dir"
    cd "$version_dir" || { echo "Failed to change directory."; exit 1; }

    # Download the selected version
    echo "Downloading Proton-GE ${version} from $url"
    wget -q --tries=10 --no-check-certificate --no-cache --no-cookies --show-progress -O "${version_dir}/proton-${version}.tar.gz" "$url"

    # Check if the download was successful
    if [ -f "${version_dir}/proton-${version}.tar.gz" ]; then
        echo "Unpacking Proton-GE ${version} in ${version_dir}..."
        
        # Unpack the .tar.gz file
        tar -xzf "${version_dir}/proton-${version}.tar.gz" --strip-components=1
        
        # Check if extraction was successful
        if [ "$(ls -A "$version_dir")" ]; then
            echo "Unpacking successful."
            rm "proton-${version}.tar.gz"

            # Check if a "files" folder exists
            if [ -d "${version_dir}/files" ]; then
                echo "Moving files from 'files' folder to parent directory..."
                
                # Move files from the "files" folder to the parent directory
                mv "${version_dir}/files/"* "${version_dir}/"
                
                # Remove the "files" folder
                rmdir "${version_dir}/files"
                
                echo "'files' folder processed and deleted."
            fi
        else
            echo "Unpacking failed, directory is empty."
        fi
        
        echo "Installation of Proton-GE ${version} complete."
    else
        echo "Failed to download Proton-GE ${version}."
    fi

    # Return to the initial directory
    cd - > /dev/null
done

echo "All selected versions have been processed."

