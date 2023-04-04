#!/bin/bash
# batocera flatpak lutris fix 
mkdir /tmp/lutris-fix 2>/dev/null
wget -q -O /tmp/lutris-fix/lutris-window.sh https://raw.githubusercontent.com/uureel/batocera.pro/main/lutris/lutris-window.sh
dos2unix /tmp/lutris-fix/lutris-window.sh 2>/dev/null && chmod a+x /tmp/lutris-fix/lutris-window.sh 2>/dev/null
wget -q -O /tmp/lutris-fix/lutris-rc.xml https://raw.githubusercontent.com/uureel/batocera.pro/main/lutris/lutris-rc.xml
dos2unix /tmp/lutris-fix/lutris-rc.xml 2>/dev/null && chmod a+x /tmp/lutris-fix/lutris-rc.xml 2>/dev/null
wget -q -O /tmp/lutris-fix/startx https://raw.githubusercontent.com/uureel/batocera.pro/main/lutris/lutris-startx
chmod a+x /tmp/lutris-fix/startx 2>/dev/null
wget -q -O /tmp/lutris-fix/xinitrc https://raw.githubusercontent.com/uureel/batocera.pro/main/lutris/lutris-xinitrc
chmod a+x /tmp/lutris-fix/xinitrc 2>/dev/null
cp /tmp/lutrix-fix/lutris-rc.xml /etc/openbox/rc.xml 2>/dev/null
sleep 0.01
/tmp/lutris-fix/startx &