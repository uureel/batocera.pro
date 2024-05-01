#!/bin/bash

# URL of the file to download
url="https://github.com/uureel/batocera.pro/raw/main/.dep/aria2c"
# Target file name
filename="aria2c"

# Download the file
curl -L $url -o $filename

# Check if the download was successful
if [ $? -ne 0 ]; then
    echo "Failed to download $filename"
    exit 1
fi

# Make the file executable
chmod +x $filename

# Verify that the file is present and executable
if [ -x "$filename" ]; then
    echo "$filename is downloaded and made executable."
else
    echo "Failed to make $filename executable."
    exit 1
fi
