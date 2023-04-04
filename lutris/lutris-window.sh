#!/bin/bash
# batocera flatpak lutris fix 
mkdir /tmp/lutris-fix 2>/dev/null
wget -q -O /tmp/lutris-fix/lutris-fix.sh https://raw.githubusercontent.com/uureel/batocera.pro/main/lutris/lutris-window.sh
dos2unix /tmp/lutris-fix/lutris-fix.sh 2>/dev/null && chmod a+x /tmp/lutris-fix/lutris-fix.sh 2>/dev/null
wget -q -O /tmp/lutris-fix/lutris-rc.xml https://raw.githubusercontent.com/uureel/batocera.pro/main/lutris/lutris-rc.xml
dos2unix /tmp/lutris-fix/lutris-rc.xml 2>/dev/null && chmod a+x /tmp/lutris-fix/lutris-rc.xml 2>/dev/null
wget -q -O /tmp/lutris-fix/startx https://raw.githubusercontent.com/uureel/batocera.pro/main/lutris/lutris-startx
chmod a+x /tmp/lutris-fix/lutris-startx 2>/dev/null
wget -q -O /tmp/lutris-fix/xinitrc https://raw.githubusercontent.com/uureel/batocera.pro/main/lutris/lutris-xinitrc
chmod a+x /tmp/lutris-fix/lutris-xinitrc 2>/dev/null
wait 
sleep 0.01
if [[ -e /tmp/lutris-fix/lutris-window.sh ]] && [[ `cat /tmp/lutris-fix/lutris-window.sh` > "0" ]] \
[[ -e /tmp/lutris-fix/lutris-rc.xml ]] && [[ `cat /tmp/lutris-fix/lutris-rc.xml` > "0" ]] \
[[ -e /tmp/lutris-fix/startx ]] && [[ `cat /tmp/lutris-fix/startx` > "0" ]] \
[[ -e /tmp/lutris-fix/xinitrc ]] && [[ `cat /tmp/lutris-fix/xinitrc` > "0" ]]; then 
cp /tmp/lutrix-fix/lutris-rc.xml /etc/openbox/rc.xml 2>/dev/null
sleep 0.01
	if [[ -e /bin/su ]]; then 
		su -c "/tmp/lutris-fix/startx &" root & 
	else 
		/tmp/lutris-fix/startx & echo & 
	fi
else 
echo "Missing files? Run the script again.."
fi
