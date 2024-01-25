#!/bin/bash

# Get the machine hardware name
architecture=$(uname -m)

# Check if the architecture is x86_64 (AMD/Intel)
if [ "$architecture" != "x86_64" ]; then
    echo "This script only runs on AMD or Intel (x86_64) CPUs, not on $architecture."
    exit 1
fi




# Function to display animated title
animate_title() {
    local text="Batocera PLUS Steam/Heroic container installer"
    local delay=0.1
    local length=${#text}

    for (( i=0; i<length; i++ )); do
        echo -n "${text:i:1}"
        sleep $delay
    done
    echo
}

display_controls() {
    echo 
    echo "This Will install Steam, & Heroic-Games-Launcher"
    echo "and more apps in an immutable Arch container with"
    echo "the apps appearing in Ports"  
    echo "NOTE: NVIDIA USERS and SLOW STORAGE DEVICES CAN TAKE A WHILE TO START UP FIRST TIME"
    echo "NVIDIA USERS SHOULD LAUNCH STEAM IN BIG PICTURE MODE FIRST TIME TO PREVENT HANG AFTER DRIVER INSTALL"
    echo ""
    echo ""
    echo "Isso irá instalar o Steam e o Heroic-Games-Launcher"
    echo "e mais aplicativos em um contêiner Arch imutável com"
    echo "os aplicativos aparecendo nas PORTS"
    echo "NOTA: USUÁRIOS DA NVIDIA E DISPOSITIVOS DE ARMAZENAMENTO LENTOS PODEM DEMORAR UM POUCO PARA INICIAR PELA PRIMEIRA VEZ"
    echo "USUÁRIOS DA NVIDIA DEVEM INICIAR O STEAM NO MODO BIG PICTURE PELA PRIMEIRA VEZ PARA EVITAR TRAVAMENTOS APÓS A INSTALAÇÃO DO DRIVER"
    echo ""
    echo ""
    echo ""
    echo ""
    echo ""
    
    sleep 5  # Delay for 5 seconds
}


clear

# Main script execution
clear
animate_title
display_controls
# Define variables
BASE_DIR="/storage/roms/ports/conty"
DOWNLOAD_URL="batocera.pro/app/conty.sh"
DOWNLOAD_FILE="$BASE_DIR/conty.sh"
ROMS_DIR="/stoage/roms/ports"

# Step 1: Create base folder if not exists
mkdir -p "$BASE_DIR"
if [ ! -d "$BASE_DIR" ]; then
  # Handle error or exit if necessary
  echo "Error creating BASE_DIR."
  exit 1
fi

# Step 1b create ports folder and pro folders on Batocera+ 
mkdir -p /userdata/roms/ports
mkdir -p ~/pro
mkdir -p ~/pro/steam
mkdir -p ~/pro/steam/home
   
# Step 2: Download conty.sh with download percentage indicator
wget batocera.pro/app/conty.sh -O ~/pro/steam/conty.sh 

# Step 3: Make conty.sh executable
chmod +x  ~/pro/steam/conty.sh 

# Step 4: Download scripts to ports folder

# Define the URL of the GitHub repository and the target directory
github_url="https://github.com/trashbus99/batocera-addon-scripts/raw/plus/jelos/shortcuts/"
target_directory="/userdata/roms/ports/"

# List of .sh files to download
sh_files=(
  "Boilr.sh"
  "GameHub.sh"
  "Geforce-Now.sh"
  "Google-Chrome.sh"
  "Greenlight.sh"
  "Heroic-Game-Launcher.sh"
  "Kodi.sh"
  "Libreoffice.sh"
  "Microsoft-Edge.sh"
  "Minigalaxy.sh"
  "Moonlight.sh"
  "PCManFM-(File-Manager).sh"
  "Protonup-Qt.sh"
  "Spotify.sh"
  "Steam-Big-Picture-Mode.sh"
  "Steam.sh"
  "Terminal.sh"
  "Xcloud.sh"
)

# Create the target directory if it doesn't exist
mkdir -p "$target_directory"

# Download the specified .sh files and make them executable
for file in "${sh_files[@]}"; do
  echo "Downloading $file..."
  curl -sSL "${github_url}$file" -o "$target_directory$file"
  chmod +x "$target_directory$file"
done

echo "Downloaded and made executable the specified .sh files in $target_directory"



echo "Install Done.  Restart/Refresh Emulationstation to see new Apps in PORTS"
echo "More apps can be found in the container's PCMANFM"

echo "Instalação concluída. Reinicie/Atualize o Emulationstation para ver novos aplicativos em PORTS"
echo "Mais aplicativos podem ser encontrados no PCMANFM do contêiner"

