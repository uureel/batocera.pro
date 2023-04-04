#!/bin/bash
# batocera flatpak lutris fix 
echo
# get files 
url=https://raw.githubusercontent.com/uureel/batocera.pro/main/lutris
f=/tmp/lutris-fix ; mkdir $f 2>/dev/null
wget -q -O $f/lutris-window.sh $url/lutris-window.sh
dos2unix $f/lutris-window.sh 2>/dev/null && chmod a+x $f/lutris-window.sh 2>/dev/null
echo "> $f/lutris-window.sh"
wget -q -O $f/lutris-rc.xml $url/lutris-rc.xml
dos2unix $f/lutris-rc.xml 2>/dev/null && chmod a+x $f/lutris-rc.xml 2>/dev/null
echo "> $f/lutris-rc.xml"
wget -q -O $f/startx $url/lutris-startx
chmod a+x $f/startx 2>/dev/null
echo "> $f/startx"
wget -q -O $f/xinitrc $url/lutris-xinitrc
chmod a+x $f/xinitrc 2>/dev/null
echo "> $f/xinitrc"
echo
# fix dbus
sed -i 's,<deny ,<allow ,g' /usr/share/dbus-1/session.conf 2>/dev/null
sed -i 's,<deny ,<allow ,g' /usr/share/dbus-1/system.conf 2>/dev/null
rm /run/messagebus.pid 2>/dev/null && dbus-daemon --system --nofork & echo & 
# re o/b
echo "restarting openbox" 
sleep 0.1
rm /etc/openbox/rc.xml 2>/dev/null
cp -rL /tmp/lutrix-fix/lutris-rc.xml /etc/openbox/rc.xml 2>/dev/null
sleep 0.1
/tmp/lutris-fix/startx 1>/dev/null 2>/dev/null & echo &
echo "now you can run lutris . . ." 
