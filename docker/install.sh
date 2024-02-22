#!/bin/bash

# Define the final CLI directory
final_cli_dir="/userdata/system/cli"

# Create a temporary directory under /userdata/system
temp_dir="/userdata/system/temp_cli"
mkdir -p "${temp_dir}"

# Step 1: Download and extract cli.tar.gz into the temporary directory
wget -O "${temp_dir}/cli.tar.gz" https://batocera.pro/app/cli.tar.gz
tar -xf "${temp_dir}/cli.tar.gz" -C "${temp_dir}"

# Move the extracted CLI content to the final directory
mkdir -p "${final_cli_dir}"
mv "${temp_dir}"/* "${final_cli_dir}/"

# Ensure the run script is executable
chmod +x "${final_cli_dir}/run"

# Step 2: Create directory if it doesn't exist
mkdir -p /userdata/system/services

# Step 3: Download docker script, move it to the target directory, and make it executable
wget https://github.com/uureel/batocera.pro/raw/main/docker/docker -O /userdata/system/services/docker
chmod +x /userdata/system/services/docker

# Step 4: Run the CLI run script from its final location
"${final_cli_dir}/run"

# Step 5: Install Portainer
docker volume create portainer_data
docker run -d -p 8000:8000 -p 9443:9443 --name portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce:latest

# Clean up: Remove the temporary directory
rm -rf "${temp_dir}"
