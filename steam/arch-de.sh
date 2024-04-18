#!/bin/bash

# Create necessary directories
mkdir -p /userdata/desktop ~/service ~/services
mkdir -p ~/service/dir_ob

# Download files to dir_ob and make batocera-compositor executable
curl -L -o ~/service/dir_ob/batocera-compositor https://github.com/uureel/batocera.pro/raw/main/steam/desktop/service/dir_ob/batocera-compositor
curl -L -o ~/service/dir_ob/full.xml https://github.com/uureel/batocera.pro/raw/main/steam/desktop/service/dir_ob/full.xml
curl -L -o ~/service/dir_ob/window.xml https://github.com/uureel/batocera.pro/raw/main/steam/desktop/service/dir_ob/windows.xml
chmod +x ~/service/dir_ob/batocera-compositor

# Download windowed file to services and make it executable
curl -L -o ~/services/windowed https://github.com/uureel/batocera.pro/raw/main/steam/desktop/services/windowed
chmod +x ~/services/windowed

# Download desktop environment scripts to /userdata/desktop and make them executable
curl -L -o /userdata/desktop/LXDE.sh https://github.com/uureel/batocera.pro/raw/main/steam/desktop/LXDE.sh
curl -L -o /userdata/desktop/MATE.sh https://github.com/uureel/batocera.pro/raw/main/steam/desktop/MATE.sh
curl -L -o /userdata/desktop/XFCE.sh https://github.com/uureel/batocera.pro/raw/main/steam/desktop/XFCE.sh
chmod +x /userdata/desktop/LXDE.sh
chmod +x /userdata/desktop/MATE.sh
chmod +x /userdata/desktop/XFCE.sh

# Display completion message
dialog --title "Installation Complete" --msgbox " To access desktop mode:\n1. In Emulationstation, Go to Main Menu-->System Settings-->services and toggle on  the windowed service. Make sure select back to save service \n2. Reboot Batocera.\n3. Press F1. You should see a windowed pcmanFM file manager.\n4. In /userdata/desktop, launch one of the desktop environment scripts. \n5. To revert back to regular mode, simply deactivate windowed service and reboot" 12 80

