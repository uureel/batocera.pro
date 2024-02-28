#!/bin/bash

# Directory to save web apps
webappsDir=~/webapps

# Function to check if the website is reachable
isWebsiteReachable() {
    response=$(curl -o /dev/null -s -w "%{http_code}\n" $1)
    if [ "$response" -eq 200 ] || [ "$response" -eq 301 ] || [ "$response" -eq 302 ]; then
        return 0 # Reachable
    else
        return 1 # Not reachable
    fi
}

attempt=0
max_attempts=5
url=""

while [ $attempt -lt $max_attempts ]; do
    # Increment the attempt counter
    ((attempt++))
    
    # Prompt for URL
    url=$(dialog --title "Enter URL (Attempt $attempt of $max_attempts)" --inputbox "Enter a URL including http/s:" 8 40 3>&1 1>&2 2>&3 3>&-)
    
    # Check if the website is reachable
    if isWebsiteReachable "$url"; then
        break
    else
        if [ $attempt -eq $max_attempts ]; then
            dialog --title "Website Unreachable" --msgbox "Website unreachable after $max_attempts attempts. Exiting." 6 50
            exit 1
        else
            dialog --title "Website Unreachable" --msgbox "Website unreachable. Please enter a reachable URL. Attempt $attempt of $max_attempts." 8 50
        fi
    fi
done

# Ensure the webapps directory exists
mkdir -p "$webappsDir"

# Name the web app based on the domain
appName=$(echo "$url" | awk -F/ '{print $3}' | sed 's/www\.//')

# Choose where to save the launcher script
choice=$(dialog --title "Save Location" --menu "Choose where to save the launcher script:" 15 50 4 \
1 "Ports (PAD2KEY AVAILABLE)" \
2 "Webapps" 3>&1 1>&2 2>&3 3>&-)

saveDir=""
case $choice in
    1) saveDir="/userdata/roms/ports" ;;
    2) saveDir="/userdata/roms/webapps" ;;
    *) echo "Invalid choice"; exit 1 ;;
esac

# Ensure the save directory exists
mkdir -p "$saveDir"

# Launcher script path
launcherPath="$saveDir/$appName.sh"

# Create the launcher script with Google Chrome in kiosk mode
cat > "$launcherPath" <<EOF
#!/bin/bash
#------------------------------------------------
conty=/userdata/system/pro/steam/conty.sh
#------------------------------------------------
batocera-mouse show
#------------------------------------------------
  "\$conty" \
          --bind /userdata/system/containers/storage /var/lib/containers/storage \
          --bind /userdata/system/flatpak /var/lib/flatpak \
          --bind /userdata/system/etc/passwd /etc/passwd \
          --bind /userdata/system/etc/group /etc/group \
          --bind /var/run/nvidia /var/run/nvidia \
          --bind /userdata/system /home/batocera \
          --bind /sys/fs/cgroup /sys/fs/cgroup \
          --bind /userdata/system /home/root \
          --bind /etc/fonts /etc/fonts \
          --bind /userdata /userdata \
          --bind /newroot /newroot \
          --bind / /batocera \
  bash -c 'google-chrome-stable --kiosk --no-sandbox --user-data-dir="/tmp/$appName-chrome-profile" "$url" "\${@}"'
#------------------------------------------------
# batocera-mouse hide
#------------------------------------------------
EOF

# Make the launcher script executable
chmod +x "$launcherPath"

echo "Web app $appName created and launcher script saved to $launcherPath."

curl http://127.0.0.1:1234/reloadgames
