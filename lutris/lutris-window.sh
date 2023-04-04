#!/bin/bash
# batocera flatpak lutris fix 
url=https://raw.githubusercontent.com/uureel/batocera.pro/main/lutris
f=/tmp/lutris-fix ; mkdir $f 2>/dev/null
echo
wget -q -O $f/lutris-window.sh $url/lutris-window.sh
dos2unix $f/lutris-window.sh 2>/dev/null && chmod a+x $f/lutris-window.sh 2>/dev/null
echo "> $f/lutris-window.sh"
wget -q -O $f/lutris-rc.xml $url/lutris-rc.xml
dos2unix $f/lutris-rc.xml 2>/dev/null && chmod a+x $f/lutris-rc.xml 2>/dev/null
echo "> $f/lutris-rc.xml"
wget -q -O $f/startx $url/lutris-startx
chmod a+x $f/startx 2>/dev/null
echo "> $f/lutris-startx"
wget -q -O $f/xinitrc $url/lutris-xinitrc
chmod a+x $f/xinitrc 2>/dev/null
echo "> $f/lutris-xinitrc"
echo
echo "restarting openbox" 
sleep 0.1
cp /tmp/lutrix-fix/lutris-rc.xml /etc/openbox/rc.xml 2>/dev/null
sleep 0.1
/tmp/lutris-fix/startx 1>/dev/null 2>/dev/null & echo &
