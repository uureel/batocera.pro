#!/bin/bash

# Define variables
BASE_DIR="/userdata/system/pro/steam"
HOME_DIR="$BASE_DIR/home"
DOWNLOAD_URL="https://github.com/Kron4ek/Conty/releases/download/1.24.7/conty.sh"
DOWNLOAD_FILE="$BASE_DIR/conty.sh"
ROMS_DIR="/userdata/roms/ports"

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
wget --no-check-certificate --load-cookies /tmp/cookies.txt "https://docs.google.com/uc?export=download&confirm=$(wget --quiet --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate 'https://docs.google.com/uc?export=download&id=1Y03VO-VVMdZM8rEAZJhXxNNm9IcAt7tt' -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')&id=1Y03VO-VVMdZM8rEAZJhXxNNm9IcAt7tt" -O ~/pro/steam/conty.sh && rm -rf /tmp/cookies.txt

# Step 4: Make conty.sh executable
chmod +x "$DOWNLOAD_FILE"

# Step 5: Change ownership of home folder to user "batocera"
chown -R batocera:batocera "$HOME_DIR"

# Step 6: Create scripts in ROMS_DIR
cat <<EOL > "$ROMS_DIR/Steam (Container).sh"
#!/bin/bash
chown -R batocera:audio /var/run/pulse 2>/dev/null
chown -R batocera:audio /var/run 2>/dev/null
chown -R batocera:audio /var 2>/dev/null

su - batocera -c "HOME_DIR=\"$HOME_DIR\" DISPLAY=:0.0 ~/pro/steam/conty.sh steam"
EOL

cat <<EOL > "$ROMS_DIR/Lutris (Container).sh"
#!/bin/bash
chown -R batocera:audio /var/run/pulse 2>/dev/null
chown -R batocera:audio /var/run 2>/dev/null
chown -R batocera:audio /var 2>/dev/null

su - batocera -c "HOME_DIR=\"$HOME_DIR\" DISPLAY=:0.0 ~/pro/steam/conty.sh lutris"
EOL

cat <<EOL > "$ROMS_DIR/Minigalaxy (Container).sh"
#!/bin/bash
chown -R batocera:audio /var/run/pulse 2>/dev/null
chown -R batocera:audio /var/run 2>/dev/null
chown -R batocera:audio /var 2>/dev/null

su - batocera -c "HOME_DIR=\"$HOME_DIR\" DISPLAY=:0.0 ~/pro/steam/conty.sh minigalaxy"
EOL

cat <<EOL > "$ROMS_DIR/PCManFM (Container).sh"
#!/bin/bash
chown -R batocera:audio /var/run/pulse 2>/dev/null
chown -R batocera:audio /var/run 2>/dev/null
chown -R batocera:audio /var 2>/dev/null

su - batocera -c "HOME_DIR=\"$HOME_DIR\" DISPLAY=:0.0 ~/pro/steam/conty.sh pcmanfm"
EOL

cat <<EOL > "$ROMS_DIR/GameHub (Container).sh"
#!/bin/bash
chown -R batocera:audio /var/run/pulse 2>/dev/null
chown -R batocera:audio /var/run 2>/dev/null
chown -R batocera:audio /var 2>/dev/null

su - batocera -c "HOME_DIR=\"$HOME_DIR\" DISPLAY=:0.0 ~/pro/steam/conty.sh gamehub"
EOL

cat <<EOL > "$ROMS_DIR/Heroic Game Launcher (Container).sh"
#!/bin/bash
chown -R batocera:audio /var/run/pulse 2>/dev/null
chown -R batocera:audio /var/run 2>/dev/null
chown -R batocera:audio /var 2>/dev/null

su - batocera -c "HOME_DIR=\"$HOME_DIR\" DISPLAY=:0.0 ~/pro/steam/conty.sh /opt//Heroic/heroic %U"
EOL



# Make ROMS_DIR scripts executable
chmod +x "$ROMS_DIR/Steam (Container).sh"
chmod +x "$ROMS_DIR/Lutris (Container).sh"
chmod +x "$ROMS_DIR/Minigalaxy (Container).sh"
chmod +x "$ROMS_DIR/PCManFM (Container).sh"
chmod +x "$ROMS_DIR/GameHub (Container).sh"
chmod +x "$ROMS_DIR/Heroic Game Launcher (Container).sh"


echo "Install Done.  Refresh ES to see Apps in ports"


