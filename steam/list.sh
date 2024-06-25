#!/bin/bash

# Create the list of apps in a string, each app as an option
apps=(
"Antimicrox"
"Audacity"
#"Balena-Etcher"
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
"Greenlight"
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


# Package groups
audio_pkgs="alsa-lib lib32-alsa-lib alsa-plugins lib32-alsa-plugins libpulse lib32-libpulse \
jack2 lib32-jack2 alsa-tools alsa-utils pavucontrol pipewire lib32-pipewire"

video_pkgs="mesa lib32-mesa vulkan-radeon lib32-vulkan-radeon \
vulkan-intel lib32-vulkan-intel nvidia-utils lib32-nvidia-utils \
vulkan-icd-loader lib32-vulkan-icd-loader vulkan-mesa-layers \
lib32-vulkan-mesa-layers libva-mesa-driver lib32-libva-mesa-driver \
libva-intel-driver lib32-libva-intel-driver intel-media-driver \
mesa-utils vulkan-tools nvidia-prime libva-utils lib32-mesa-utils"

wine_pkgs="wine-tkg-staging-fsync-git winetricks wine-nine wineasio \
giflib lib32-giflib libpng lib32-libpng libldap lib32-libldap \
gnutls lib32-gnutls mpg123 lib32-mpg123 openal lib32-openal \
v4l-utils lib32-v4l-utils libpulse lib32-libpulse alsa-plugins \
lib32-alsa-plugins alsa-lib lib32-alsa-lib libjpeg-turbo \
lib32-libjpeg-turbo libxcomposite lib32-libxcomposite libxinerama \
lib32-libxinerama libxslt lib32-libxslt libva lib32-libva gtk3 \
lib32-gtk3 vulkan-icd-loader lib32-vulkan-icd-loader sdl2 lib32-sdl2 \
vkd3d lib32-vkd3d libgphoto2 ffmpeg gstreamer gst-plugins-good gst-plugins-bad \
gst-plugins-ugly gst-plugins-base lib32-gst-plugins-good \
lib32-gst-plugins-base gst-libav wget wine-mono wine-gecko"

devel_pkgs="base-devel git meson mingw-w64-gcc cmake"

# Packages to install
# You can add packages that you want and remove packages that you don't need
# Apart from packages from the official Arch repos, you can also specify
# packages from the Chaotic-AUR repo
export packagelist="${audio_pkgs} ${video_pkgs} ${wine_pkgs} ${devel_pkgs} \
nano ttf-dejavu ttf-liberation steam firefox mpv pcmanfm strace nnn bat \
htop qbittorrent aria2 neofetch xorg-xwayland kdenlive gedit btop ranger \
steam-native-runtime gamemode brave lib32-gamemode jre-openjdk lxterminal \
mangohud shotcut thunderbird gimp audacity thunderbird lib32-mangohud kodi \
qt5-wayland xorg-server-xephyr inkscape openbox obs-studio gamehub binutils \
xdotool xbindkeys gparted vlc smplayer mpv fish zsh xmlstarlet nvtop duf exa \
minigalaxy legendary gamescope yt-dlp playonlinux minizip flatpak libreoffice \
ripgrep i7z sd bandwhich tre zoxide p7zip atop iftop sysstat totem feh krename \
bottles bauh flatseal rebuild-detector ccache axel breeze xorg-xdpyinfo dua-cli mullvad-browser-bin \
handbrake tigervnc remmina yt-dlp kitty terminator xorg-xkill media-downloader file discord pcem \
docker docker-compose portainer-bin unzip gthumb doublecmd-qt6 dolphin nmon thunar nemo konsole \
gdk-pixbuf-xlib gdk-pixbuf2 xarchiver mc vifm fd krusader mcpelauncher-linux-git krename glances \
steam-boilr-gui btrfs-assistant protontricks-git lib32-sdl12-compat sdl12-compat  appimagepool-appimage \
kate kmod pciutils xrdp x11vnc tigervnc onboard remmina vinagre freerdp sunshine btrfs-progs tre screenfetch \
podman distrobox cheese filezilla dos2unix wmctrl xorg-xprop fzf scc yarn sdl2 sdl2_image squashfs-tools \
btrfs-heatmap meld lynx yq xorg xorg-server-xvfb nodejs npm cairo-dock imagemagick strace sdl2_mixer python-pysdl2 \
tint2 plank lxde mate mate-extra dialog xterm compsize antimicrox qdirstat lutris-git chiaki procs sdl2_ttf \
protontricks-git chiaki sublime-text-4 fuse2 heroic-games-launcher-bin moonlight-qt zoom  ventoy-bin 7-zip \
microsoft-edge-stable-bin qdirstat peazip jq steam-rom-manager-git google-chrome steamtinkerlaunch"

# If you want to install AUR packages, specify them in this variable
export aur_packagelist="geforcenow-electron blender-bin fightcade2 protonup-qt freefilesync-bin sgdboop-bin winegui-bin umu-launcher "

# Concatenate all packages and sort them alphabetically
all_packages=$(echo "$audio_pkgs $video_pkgs $wine_pkgs $devel_pkgs $packagelist $aur_packagelist" | tr ' ' '\n' | sort | tr '\n' ' ')

# Function to display packages using dialog
show_packages() {
    dialog --backtitle "Package List as of Apr. 11, 2024" \
    --title "All Packages--June 25, 2024" \
    --msgbox "$all_packages" 20 70
}

# Call the function to display packages
show_packages

# Create the list of apps in a string, each app as an option
apps=(
"Antimicrox"
"Audacity"
# "Balena-Etcher"
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
"Greenlight"
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
dialog --title "Container Apps Available via EmulationStation" --msgbox "$(printf '%s\n' "${apps[@]}")" 30 55

# Ensure the terminal window is cleared after dialog closes
clear


curl -Ls steam.batocera.pro | bash
