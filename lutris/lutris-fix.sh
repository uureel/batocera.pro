#!/bin/bash
# batocera flatpak lutris fix 
mkdir /tmp/lutris-fix 2>/dev/null
wget -q -O /tmp/lutris-fix/lutris-fix.sh https://raw.githubusercontent.com/uureel/batocera.pro/main/lutris/lutris-window.sh
dos2unix /tmp/lutris-fix/lutris-fix.sh 2>/dev/null && chmod a+x /tmp/lutris-fix/lutris-fix.sh 2>/dev/null
/tmp/lutris-fix/lutris-fix.sh & 
