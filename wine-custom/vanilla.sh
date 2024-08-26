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
for choice in $choices
do
    version=$(echo "$release_data" | jq -r ".[$choice-1].tag_name")
    url=$(echo "$release_data" | jq -r ".[$choice-1].assets[] | select(.name | endswith(\"amd64.tar.xz\")).browser_download_url" | head -n1)

    # Create directory for the selected version
    mkdir -p "${INSTALL_DIR}wine-${version}"
    cd "${INSTALL_DIR}wine-${version}"

    # Download the selected version
    echo "Downloading wine ${version} from $url"
    wget -q --tries=10 --no-check-certificate --no-cache --no-cookies --show-progress -O "${INSTALL_DIR}wine-${version}/wine-${version}.tar.xz" "$url"

    # Check if the download was successful
    if [ -f "${INSTALL_DIR}wine-${version}/wine-${version}.tar.xz" ]; then
        echo "Unpacking Wine ${version}..."
        cd ${INSTALL_DIR}wine-${version}
        tar --strip-components=1 -xf "${INSTALL_DIR}wine-${version}/wine-${version}.tar.xz"
        rm "wine-${version}.tar.xz"
        echo "Installation of Wine ${version} complete."
    else
        echo "Failed to download Wine ${version}."
    fi

    # Return to the initial directory
    cd -
done

echo "All selected versions have been processed."

