#!/bin/bash
echo "Starting Minimal Steam/Lutris Installer Script...with Nvidia Support"


cvlc --quiet --play-and-exit --no-osd https://github.com/trashbus99/batocera-addon-scripts/raw/main/media/steam.mp4 >/dev/null 2>&1 &

# Wait for cvlc to finish
wait $!

killall -9 vlc

Clear 

# Function to display animated title
animate_title() {
    local text="Steam/Lutris NVIDIA container installer"
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
    echo "This Will install Steam, Lutris,"
    echo "and more apps in ports."
    echo "Home Folder location: ~/pro/steam/home"  
    echo 
    sleep 10  # Delay for 10 seconds
}


clear

# Main script execution
clear
animate_title
display_controls
# Define variables
BASE_DIR="/userdata/system/pro/steam"
HOME_DIR="$BASE_DIR/home"
DOWNLOAD_URL="https://github.com/Kron4ek/Conty/releases/download/1.24.8/conty.sh"
DOWNLOAD_FILE="$BASE_DIR/conty.sh"
ROMS_DIR="/userdata/roms/ports"

#Step 0: Clean old folders from AMD/INTEL build
rm -rf ~/.local/share/Conty
rm -rf /userdata/roms/conty
rm -rf /userdata/roms/steam2

# Step 1: Create base folder if not exists
mkdir -p "$BASE_DIR"
if [ ! -d "$BASE_DIR" ]; then
  # Handle error or exit if necessary
  echo "Error creating BASE_DIR."
  exit 1
fi

# Step 2: Create home folder if not exists
if [ ! -d "$HOME_DIR" ]; then
  mkdir -p "$HOME_DIR"
fi

# Step 3: Download conty.sh with download percentage indicator
wget https://github.com/Kron4ek/Conty/releases/download/1.24.8/conty.sh -O ~/pro/steam/conty.sh

# Step 4: Make conty.sh executable
chmod +x "$DOWNLOAD_FILE"

# Step 5: Change ownership of home folder to user "batocera"
chown -R batocera:batocera "$HOME_DIR"

# Step 6: Create scripts in ROMS_DIR
cat <<EOL > "$ROMS_DIR/Steam (Container).sh"
#!/bin/bash
mkdir -p ~/.local
chmod 777 ~/.local
chmod 777 ~/.local/*
chown -R root:audio /var/run/pulse
chmod -R g+rwX /var/run/pulse


su - batocera -c "HOME_DIR=\"$HOME_DIR\" DISPLAY=:0.0 ~/pro/steam/conty.sh steam"
EOL

cat <<EOL > "$ROMS_DIR/Lutris (Container).sh"
#!/bin/bash
mkdir -p ~/.local
chmod 777 ~/.local
chmod 777 ~/.local/*
chown -R root:audio /var/run/pulse
chmod -R g+rwX /var/run/pulse

unclutter-remote -s
su - batocera -c "HOME_DIR=\"$HOME_DIR\" DISPLAY=:0.0 ~/pro/steam/conty.sh lutris"
unclutter-remote -h
EOL

cat <<EOL > "$ROMS_DIR/Minigalaxy (Container).sh"
#!/bin/bash
mkdir -p ~/.local
chmod 777 ~/.local
chmod 777 ~/.local/*
chown -R root:audio /var/run/pulse
chmod -R g+rwX /var/run/pulse

unclutter-remote -s
su - batocera -c "HOME_DIR=\"$HOME_DIR\" DISPLAY=:0.0 ~/pro/steam/conty.sh minigalaxy"
unclutter-remote -h
EOL

cat <<EOL > "$ROMS_DIR/PCManFM (Container).sh"
#!/bin/bash
mkdir -p ~/.local
chmod 777 ~/.local
chmod 777 ~/.local/*
chown -R root:audio /var/run/pulse
chmod -R g+rwX /var/run/pulse


unclutter-remote -s
su - batocera -c "HOME_DIR=\"$HOME_DIR\" DISPLAY=:0.0 ~/pro/steam/conty.sh pcmanfm"
unclutter-remote -h
EOL

cat <<EOL > "$ROMS_DIR/GameHub (Container).sh"
#!/bin/bash
mkdir -p ~/.local
chmod 777 ~/.local
chmod 777 ~/.local/*
chown -R root:audio /var/run/pulse
chmod -R g+rwX /var/run/pulse


unclutter-remote -s
su - batocera -c "HOME_DIR=\"$HOME_DIR\" DISPLAY=:0.0 ~/pro/steam/conty.sh gamehub"
unclutter-remove -h
EOL

cat <<EOL > "$ROMS_DIR/Steam Big Picture Mode (Container).sh"
#!/bin/bash
mkdir -p ~/.local
chmod 777 ~/.local
chmod 777 ~/.local/*
chown -R root:audio /var/run/pulse
chmod -R g+rwX /var/run/pulse


unclutter-remote -s
su - batocera -c "HOME_DIR=\"$HOME_DIR\" DISPLAY=:0.0 ~/pro/steam/conty.sh steam -gamepadui"
unclutter-remote -h
EOL



# Make ROMS_DIR scripts executable
chmod +x "$ROMS_DIR/Steam (Container).sh"
chmod +x "$ROMS_DIR/Lutris (Container).sh"
chmod +x "$ROMS_DIR/Minigalaxy (Container).sh"
chmod +x "$ROMS_DIR/PCManFM (Container).sh"
chmod +x "$ROMS_DIR/GameHub (Container).sh"
chmod +x "$ROMS_DIR/Steam Big Picture Mode (Container).sh"

echo "Preparing to launch Steam..."
sleep 2

# 5-second countdown with simple animation
for i in {5..1}
do
   clear
   echo "Launching Steam in... $i seconds"
   echo -ne '##########\r'
   sleep 0.2
   echo -ne '######### \r'
   sleep 0.2
   echo -ne '########  \r'
   sleep 0.2
   echo -ne '#######   \r'
   sleep 0.2
   echo -ne '######    \r'
   sleep 0.2
   echo -ne '#####     \r'
   sleep 0.2
   echo -ne '####      \r'
   sleep 0.2
   echo -ne '###       \r'
   sleep 0.2
   echo -ne '##        \r'
   sleep 0.2
   echo -ne '#         \r'
   sleep 0.2
   echo -ne '          \r'
done

echo "Steam is now starting"

/userdata/roms/ports/"Steam Big Picture Mode (Container).sh"




echo "Install Done. Shortcuts are in ports."
sleep 5
curl http://127.0.0.1:1234/reloadgames
