#!/bin/bash

# Get the machine hardware name
architecture=$(uname -m)

# Check if the architecture is x86_64 (AMD/Intel)
if [ "$architecture" != "x86_64" ]; then
    echo "This script only runs on AMD or Intel (x86_64) CPUs, not on $architecture."
    exit 1
fi
#!/bin/bash

# Create the list of apps in a string, each app as an option
apps=(
"Antimicrox"
"Audacity"
"Balena-Etcher"
"Blender"
"Boilr"
"Bottles"
"Brave"
"Chiaki"
"FileManager-Dolphin"
"FileManager-DoubleCmd"
"FileManager-Krusader"
"FileManager-Nemo"
"FileManager-PCManFM"
"FileManager-Thunar"
"Filezilla"
"Firefox"
"Flatpak-Config"
"FreeFileSync"
"GameHub"
"Geforce Now"
"Gimp"
"Google-Chrome"
"Gparted"
"Gthumb"
"Handbrake"
"Heroic Game Launcher"
"Hulu"
"Inkscape"
"Kdenlive"
"Kodi"
"Libreoffice"
"Lutris"
"Microsoft-Edge"
"Minigalaxy"
"Moonlight"
"Netflix"
"OBS Studio"
"Peazip"
"Play on Linux 4"
"PortProton"
"Protonup-Qt"
"Qbittorrent"
"Qdirstat"
"Shotcut"
"Smplayer"
"Spotify"
"Steam Big Picture Mode"
"Steam Diagnostic"
"Steam"
"SteamTinker Launch (settings)"
"SublimeText"
"Terminal-Kitty"
"Terminal-Lxterminal"
"Terminal-Tabby"
"Terminal-Terminator"
"Thunderbird"
"TigerVNC"
"VLC"
"WineGUI"
"Zoom"
)

# Use dialog to display the list in a message box
dialog --title Container Apps Available via EmulationStation" --msgbox "$(printf '%s\n' "${apps[@]}")" 30 55

# Ensure the terminal window is cleared after dialog closes
clear


# Define the options
OPTIONS=("1" "New Install: Download Arch Container (older build)"
         "2" "New Install: Build Arch container from scratch (up to date apps)"
         "3" "Uninstall Arch Container"
         "4" "Update Launcher shortcuts for emulationstation Arch container"
         "5" "Re-download container"
         "6" "Update apps and rebuild container"
         "7" "Addon: Add/Update Lutris Menu & Shortcuts to Emulationstation"
         "8" "Addon: Add/Update Heroic Menu & Shortcuts to Emulationstation"
         "9" "Addon: Emudeck (experimental)"
         "10" "Addon: Add/Update Webapps Web/Internet Menu to Emulationstation")

# Display the dialog and get the user choice
CHOICE=$(dialog --clear --backtitle "Arch Container Management" \
                --title "Main Menu" \
                --menu "Choose an option:" 20 90 3 \
                "${OPTIONS[@]}" \
                2>&1 >/dev/tty)

clear

# Act based on the user choice
case $CHOICE in
    1)
        echo "Installing Steam Container..."
        rm /tmp/runner 2>/dev/null
        wget -q --tries=30 --no-check-certificate --no-cache --no-cookies -O /tmp/runner https://raw.githubusercontent.com/uureel/batocera.pro/main/steam/install2.sh
        dos2unix /tmp/runner 2>/dev/null 
        chmod 777 /tmp/runner 2>/dev/null
        bash /tmp/runner
        ;;
     2)
        echo "Installing Steam Container..."
        rm /tmp/runner 2>/dev/null
        wget -q --tries=30 --no-check-certificate --no-cache --no-cookies -O /tmp/runner https://raw.githubusercontent.com/uureel/batocera.pro/main/steam/install_new.sh
        dos2unix /tmp/runner 2>/dev/null 
        chmod 777 /tmp/runner 2>/dev/null
        bash /tmp/runner
        ;;
    3)
        echo "Loading Uninstall script..."
        rm /tmp/runner 2>/dev/null
        wget -q --tries=30 --no-check-certificate --no-cache --no-cookies -O /tmp/runner https://raw.githubusercontent.com/uureel/batocera.pro/main/steam/uninstall.sh
        dos2unix /tmp/runner 2>/dev/null 
        chmod 777 /tmp/runner 2>/dev/null
        bash /tmp/runner
        ;;
    4)  
        echo "Update EmulationStation Arch Container Launcher Shortcuts..."
        rm /tmp/runner 2>/dev/null
        wget -q --tries=30 --no-check-certificate --no-cache --no-cookies -O /tmp/runner https://raw.githubusercontent.com/uureel/batocera.pro/main/steam/update_shortcuts.sh
        dos2unix /tmp/runner 2>/dev/null 
        chmod 777 /tmp/runner 2>/dev/null
        bash /tmp/runner
        ;;    
    5)  
        echo "Update/Re-download Container..."
        rm /tmp/runner 2>/dev/null
        wget -q --tries=30 --no-check-certificate --no-cache --no-cookies -O /tmp/runner https://raw.githubusercontent.com/uureel/batocera.pro/main/steam/redownload.sh
        dos2unix /tmp/runner 2>/dev/null 
        chmod 777 /tmp/runner 2>/dev/null
        bash /tmp/runner
        ;;
    6)  
        echo "Update Conty Container..."
        rm /tmp/runner 2>/dev/null
        wget -q --tries=30 --no-check-certificate --no-cache --no-cookies -O /tmp/runner https://raw.githubusercontent.com/uureel/batocera.pro/main/steam/upgrade.sh
        dos2unix /tmp/runner 2>/dev/null 
        chmod 777 /tmp/runner 2>/dev/null
        bash /tmp/runner
        ;;
    7)  
        echo "Add/Update Lutris shortcuts to emulationstation..."
        rm /tmp/runner 2>/dev/null
        wget -q --tries=30 --no-check-certificate --no-cache --no-cookies -O /tmp/runner https://raw.githubusercontent.com/uureel/batocera.pro/main/steam/addon_lutris.sh
        dos2unix /tmp/runner 2>/dev/null 
        chmod 777 /tmp/runner 2>/dev/null
        bash /tmp/runner
        ;;
    8)  
        echo "Add/update Heroic shortcuts to emulationstation..."
        rm /tmp/runner 2>/dev/null
        wget -q --tries=30 --no-check-certificate --no-cache --no-cookies -O /tmp/runner https://raw.githubusercontent.com/uureel/batocera.pro/main/steam/addon_heroic.sh
        dos2unix /tmp/runner 2>/dev/null 
        chmod 777 /tmp/runner 2>/dev/null
        bash /tmp/runner
        ;;
    9)  
        echo "Emudeck Menu..."
        rm /tmp/runner 2>/dev/null
        wget -q --tries=30 --no-check-certificate --no-cache --no-cookies -O /tmp/runner https://github.com/uureel/batocera.pro/raw/main/emudeck/emudeck.sh
        dos2unix /tmp/runner 2>/dev/null 
        chmod 777 /tmp/runner 2>/dev/null
        bash /tmp/runner
        ;;
    10)  
        echo "Webapps Installer..."
        rm /tmp/runner 2>/dev/null
        wget -q --tries=30 --no-check-certificate --no-cache --no-cookies -O /tmp/runner https://github.com/uureel/batocera.pro/raw/main/webapps/install.sh
        dos2unix /tmp/runner 2>/dev/null 
        chmod 777 /tmp/runner 2>/dev/null
        bash /tmp/runner
        ;;   
    *)
        echo "No valid option selected or cancelled. Exiting."
        ;;
esac
