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



# Prompt the user to choose a user agent
userAgentChoice=$(dialog --title "Choose User Agent" --menu "Choose a user agent:" 15 50 4 \
1 "Google Chrome" \
2 "Firefox" \
3 "Xbox" \
4 "Google TV" 3>&1 1>&2 2>&3 3>&-)

# Set the user agent string based on the choice
userAgent=""
case $userAgentChoice in
    1) userAgent="Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.3" ;;
    2) userAgent="Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:66.0) Gecko/20100101 Firefox/66.0" ;;
    3) userAgent="Mozilla/5.0 (compatible; MSIE 10.0; Windows NT 6.2; Trident/6.0; Xbox)" ;;
    4) userAgent="Mozilla/5.0 (Linux; Android 9; Google TV Build/PI) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/84.0.4147.89 Safari/537.36" ;;
    *) echo "Invalid choice"; exit 1 ;;
esac

# Modify the Nativefier command to include the user agent option
nativefier "$url" -n "$appName" --user-agent "$userAgent" --electron-version $(npm show electron version) "$webappsDir"








# Choose where to save the launcher script
choice=$(dialog --title "Save Location" --menu "Choose where to save the launcher script:" 15 50 4 \
1 "Ports (PAD2KEY Available)" \
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

# Create the launcher script
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
  bash -c 'prepare && dbus-run-session "/userdata/system/webapps/$appName-linux-x64/$appName" --no-sandbox "\${@}"'
#------------------------------------------------
# batocera-mouse hide
#------------------------------------------------
EOF

# Make the launcher script executable
chmod +x "$launcherPath"

echo "Web app $appName created and launcher script saved to $launcherPath."
sleep 3
curl http://127.0.0.1:1234/reloadgames
