#!/bin/bash

# API endpoint for GitHub releases
REPO_URL="https://api.github.com/repos/Kron4ek/Wine-Builds/releases?per_page=300"

# Directory to store custom Wine versions
INSTALL_DIR="/userdata/system/wine/custom/"
mkdir -p "$INSTALL_DIR"

# Fetch release data from GitHub
echo "Fetching release information..."
release_data=$(curl -s $REPO_URL)

# Check if curl succeeded
if [[ $? -ne 0 ]]; then
    echo "Failed to fetch release data."
    exit 1
fi

# Prepare the selection menu using dialog
cmd=(dialog --separate-output --checklist "Select Wine tkg-staging versions to download:" 22 76 16)
options=()
i=1

# Parse JSON and build options array, filter only tkg-staging builds
while IFS= read -r line; do
    name=$(echo "$line" | jq -r '.name')
    tag=$(echo "$line" | jq -r '.tag_name')
    description="${name} - ${tag}"
    tkg_staging_assets=$(echo "$line" | jq -c '.assets[] | select(.name | contains("staging-tkg"))')
    if [ -n "$tkg_staging_assets" ]; then
        options+=($i "$description" off)
        ((i++))
    fi
done < <(echo "$release_data" | jq -c '.[]')

# Show dialog, capture selections
choices=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)

# Clear up the dialog artifacts
clear

# Process selections
for choice in $choices
do
    version=$(echo "$release_data" | jq -r ".[$choice-1].tag_name")
    url=$(echo "$release_data" | jq -r ".[$choice-1].assets[] | select(.name | contains(\"staging-tkg\") and endswith(\"amd64.tar.xz\")).browser_download_url" | head -n1)
    
    # Define output folder
    output_folder="${INSTALL_DIR}wine-${version}-staging-tkg"
    
    # Create directory for the selected version
    mkdir -p "$output_folder"
    cd "$output_folder"

    # Download the selected version
    echo "Downloading wine ${version} from $url"
    wget -q --tries=10 --no-check-certificate --no-cache --no-cookies --show-progress -O "${output_folder}/wine-${version}-staging-tkg.tar.xz" "$url"

    # Check if the download was successful
    if [ -f "${output_folder}/wine-${version}-staging-tkg.tar.xz" ]; then
        echo "Unpacking Wine ${version}..."
        cd "$output_folder"
        tar --strip-components=1 -xf "${output_folder}/wine-${version}-staging-tkg.tar.xz"
        rm "wine-${version}-staging-tkg.tar.xz"
        echo "Installation of Wine ${version} complete."
    else
        echo "Failed to download Wine ${version}."
    fi

    # Return to the initial directory
    cd -
done

echo "All selected versions have been processed."
