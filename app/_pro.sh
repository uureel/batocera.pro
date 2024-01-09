#!/bin/bash

# Function to display animated title
animate_title() {
    local text="BATOCERA PRO APP INSTALLER"
    local delay=0.1
    local length=${#text}

    for (( i=0; i<length; i++ )); do
        echo -n "${text:i:1}"
        sleep $delay
    done
    echo
}

# Function to display controls
display_controls() {
    echo "Controls:"
    echo "  Navigate with up-down-left-right"
    echo "  Select app with A/B/SPACE and execute with Start/X/Y/ENTER"
    echo
    sleep 7  # Delay for 5 seconds
}

# Main script execution
clear
animate_title
display_controls


# Define an associative array for app names and their install commands
declare -A apps
apps=(
    # ... (populate with your apps as shown before)
    ["7ZIP"]="curl -L 7zip.batocera.pro | bash"
    ["86BOX"]="curl -L 86box.batocera.pro | bash"
    ["ALTUS"]="curl -L altus.batocera.pro | bash"
    ["ANTIMICROX"]="curl -L antimicrox.batocera.pro | bash"
    ["ATOM"]="curl -L atom.batocera.pro | bash"
    ["BALENA-ETCHER"]="curl -L balena.batocera.pro | bash"
    ["BLENDER"]="curl -L blender.batocera.pro | bash"
    ["BRAVE"]="curl -L brave.batocera.pro | bash"
    ["CHIAKI"]="curl -L chiaki.batocera.pro | bash"
    ["CHROME"]="curl -L chrome.batocera.pro | bash"
    ["CHROMIUM"]="curl -L chromium.batocera.pro | bash"
    ["CLONEHERO"]="curl -L clonehero.batocera.pro | bash"
    ["COCKATRICE"]="curl -L cockatrice.batocera.pro | bash"
    ["DISCORD"]="curl -L discord.batocera.pro | bash"
    ["DOUBLE-COMMANDER"]="curl -L doublecmd.batocera.pro | bash"
    ["EDGE"]="curl -L edge.batocera.pro | bash"
    ["EXTRACT-XISO-GUI"]="curl -L xiso.batocera.pro | bash"
    ["FERDIUM"]="curl -L ferdium.batocera.pro | bash"
    ["FILEZILLA"]="curl -L filezilla.batocera.pro | bash"
    ["FIREFOX"]="curl -L firefox.batocera.pro | bash"
    ["FIREFOX-NIGHTLY"]="curl -L ffnightly.batocera.pro | bash"
    ["FIGHTCADE 2"]="curl -L fightcade.batocera.pro | bash"
    ["FOOBAR2000"]="curl -L foobar.batocera.pro | bash"
    ["GEFORCENOW"]="curl -L geforcenow.batocera.pro | bash"
    ["GPARTED"]="curl -L gparted.batocera.pro | bash"
    ["GREENLIGHT"]="curl -L greenlight.batocera.pro | bash"
    ["GTHUMB"]="curl -L gthumb.batocera.pro | bash"
    ["HEROIC-LAUNCHER-APPIMAGE"]="curl -L heroic.batocera.pro | bash"
    ["HEROIC-LAUNCHER-CONTAINER"]="curl -L heroic2.batocera.pro | bash"
    ["HYPER"]="curl -L hyper.batocera.pro | bash"
    ["ITCH"]="curl -L itch.batocera.pro | bash"
    ["JAVA-RUNTIME"]="curl -L java.batocera.pro | bash"
    ["KDENLIVE"]="curl -L kdenlive.batocera.pro | bash"
    ["KITTY"]="curl -L kitty.batocera.pro | bash"
    ["KRITA"]="curl -L krita.batocera.pro | bash"
    ["LOGS"]="curl -L logs.batocera.pro | bash"
    ["LUTRIS-CONTAINER"]="curl -L lutris.batocera.pro | bash"
    ["MEDIAELCH"]="curl -L mediaelch.batocera.pro | bash"
    ["MINECRAFT"]="curl -L minecraft.batocera.pro | bash"
    ["MOONLIGHT"]="curl -L moonlight.batocera.pro | bash"
    ["MPV"]="curl -L mpv.batocera.pro | bash"
    ["MULTIMC-LAUNCHER"]="curl -L multimc.batocera.pro | bash"
    ["MUSEEKS"]="curl -L museeks.batocera.pro | bash"
    ["MYRETROTV"]="curl -L myretrotv.batocera.pro | bash"
    ["NOMACS"]="curl -L nomacs.batocera.pro | bash"
    ["OBS-STUDIO"]="curl -L obs.batocera.pro | bash"
    ["ODIO"]="curl -L odio.batocera.pro | bash"
    ["OLIVE"]="curl -L olive.batocera.pro | bash"
    ["OPERA"]="curl -L opera.batocera.pro | bash"
    ["PEAZIP"]="curl -L peazip.batocera.pro | bash"
    ["PHOTOCOLLAGE"]="curl -L photocollage.batocera.pro | bash"
    ["PLEXAMP"]="curl -L plexamp.batocera.pro | bash"
    ["POKEMMO"]="curl -L pokemmo.batocera.pro | bash"
    ["PRISM-LAUNCHER"]="curl -L prism.batocera.pro | bash"
    ["PS2-MINUS"]="curl -L ps2minus.batocera.pro | bash"
    ["PS2-PLUS"]="curl -L ps2plus.batocera.pro | bash"
    ["PS3-PLUS"]="curl -L ps3plus.batocera.pro | bash"
    ["QBITTORRENT"]="curl -L qbittorrent.batocera.pro | bash"
    ["QDIRSTAT"]="curl -L qdirstat.batocera.pro | bash"
    ["RATS-SEARCH"]="curl -L rats.batocera.pro | bash"
    ["RHYTHMBOX"]="curl -L rhythmbox.batocera.pro | bash"
    ["SAK"]="curl -L sak.batocera.pro | bash"
    ["SAYONARA"]="curl -L sayonara.batocera.pro | bash"
    ["SMPLAYER"]="curl -L smplayer.batocera.pro | bash"
    ["SPOTIFY"]="curl -L spotify.batocera.pro | bash"
    ["STEAM-CONTAINER"]="curl -L steam.batocera.pro | bash"
    ["STRAWBERRY"]="curl -L strawberry.batocera.pro | bash"
    ["SUBLIME-TEXT"]="curl -L sublime.batocera.pro | bash"
    ["SUNSHINE"]="curl -L sunshine.batocera.pro | bash"
    ["SWITCH-EMULATION"]="curl -L switch.batocera.pro | bash"
    ["TABBY"]="curl -L tabby.batocera.pro | bash"
    ["TELEGRAM"]="curl -L telegram.batocera.pro | bash"
    ["TOTAL-COMMANDER"]="curl -L totalcmd.batocera.pro | bash"
    ["TRANSMISSION"]="curl -L transmission.batocera.pro | bash"
    ["UPDATE-THIS-SCRIPT"]="curl -L app.batocera.pro | bash"
    ["VIVALDI"]="curl -L vivaldi.batocera.pro | bash"
    ["VLC"]="curl -L vlc.batocera.pro | bash"
    ["WHATSAPP"]="curl -L whatsapp.batocera.pro | bash"
    ["WIIU-PLUS"]="curl -L wiiuplus.batocera.pro | bash"
    ["XARCHIVER"]="curl -L xarchiver.batocera.pro | bash"
    ["YARG & YARC-Launcher"]="curl -L yarg.batocera.pro | bash"
    ["YOUTUBE-TV"]="curl -L yttv.batocera.pro | bash"
)

# Prepare array for dialog command
app_list=()
for app in "${!apps[@]}"; do
    app_list+=("$app" "" OFF)
done

# Show dialog checklist
cmd=(dialog --separate-output --checklist "Select applications to install or update:" 22 76 16)
choices=$("${cmd[@]}" "${app_list[@]}" 2>&1 >/dev/tty)

# Check if Cancel was pressed
if [ $? -eq 1 ]; then
    echo "Installation cancelled."
    exit
fi

# Install selected apps
for choice in $choices; do
    echo "Installing $choice..."
    eval ${apps[$choice]}
    echo "$choice installed."
done

echo "Installation process completed."

