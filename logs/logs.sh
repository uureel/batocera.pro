#!/bin/bash
clear 
echo
echo
echo "installing batocera-logs"
echo
echo "this script will be available in ports: Batocera Logs.sh"
echo "and also in F1->Applications: logs"
echo "also as a system command: logs"
echo "or: batocera-logs"
echo
echo ". . . "
echo
echo
#
sleep 5
appname=logs
mkdir -p /userdata/system/pro/logs/extra 2>/dev/null
#
url=https://raw.githubusercontent.com/uureel/batocera.pro/main/logs/extra
logs=/userdata/system/pro/logs
wget -q -O $logs/batocera-logs.sh $url/batocera-logs.sh 2>/dev/null
wget -q -O $logs/batocera-logs-port.sh $url/batocera-logs-port.sh 2>/dev/null
wget -q -O $logs/batocera-logs-port.sh.keys $url/batocera-logs-port.sh.keys 2>/dev/null
chmod a+x $logs/batocera-logs-port.sh 2>/dev/null
chmod a+x $logs/batocera-logs.sh 2>/dev/null
#
if [[ ! -e /usr/bin/batocera-logs ]] || [[ ! -e /usr/bin/logs ]]; 
then 
	cp $logs/batocera-logs.sh /usr/bin/batocera-logs 2>/dev/null 
	cp $logs/batocera-logs.sh /usr/bin/logs 2>/dev/null
	cp $logs/batocera-logs-port.sh "/userdata/roms/ports/Batocera Logs.sh" 2>/dev/null
	cp $logs/batocera-logs-port.sh.keys "/userdata/roms/ports/Batocera Logs.sh.keys" 2>/dev/null
fi
#
# -- prepare launcher to solve dependencies on each run and avoid overlay, 
launcher=/userdata/system/pro/logs/Launcher
rm -rf $launcher
echo '#!/bin/bash ' >> $launcher
echo 'unclutter-remote -s' >> $launcher
echo 'DISPLAY=:0.0 xterm -en en_US.UTF-8 -u8 -bg black -fg white -fa Monospace -fs 4 -sb -e bash -c "/usr/bin/logs 2>/dev/null" 2>/dev/null &' >> $launcher
dos2unix $launcher
chmod a+x $launcher
rm /userdata/system/pro/$appname/extra/command 2>/dev/null
#
# -- prepare f1 - applications - app shortcut, 
shortcut=/userdata/system/pro/logs/extra/logs.desktop
rm -rf $shortcut 2>/dev/null
echo "[Desktop Entry]" >> $shortcut
echo "Version=1.0" >> $shortcut
echo "Icon=/userdata/system/pro/logs/extra/icon.png" >> $shortcut
echo "Exec=/userdata/system/pro/logs/Launcher" >> $shortcut
echo "Terminal=false" >> $shortcut
echo "Type=Application" >> $shortcut
echo "Categories=Game;batocera.linux;" >> $shortcut
echo "Name=logs" >> $shortcut
f1shortcut=/usr/share/applications/$appname.desktop
dos2unix $shortcut
chmod a+x $shortcut
cp $shortcut $f1shortcut 2>/dev/null
#
# -- prepare prelauncher to avoid overlay,
pre=/userdata/system/pro/logs/extra/startup
rm -rf $pre 2>/dev/null
echo "#!/bin/bash" >> $pre
echo 'if [[ ! -e /usr/bin/batocera-logs]] || [[ ! -e /usr/bin/logs ]] || [[ ! -e "/userdata/roms/ports/Batocera Logs.sh" ]]; then' >> $pre
echo "cp /userdata/system/pro/logs/batocera-logs.sh /usr/bin/batocera-logs 2>/dev/null" >> $pre
echo "cp /userdata/system/pro/logs/batocera-logs.sh /usr/bin/logs 2>/dev/null" >> $pre
echo "cp /userdata/system/pro/logs/batocera-logs-port.sh '/userdata/roms/ports/Batocera Logs.sh' 2>/dev/null" >> $pre
echo "cp /userdata/system/pro/logs/batocera-logs-port.sh.keys '/userdata/roms/ports/Batocera Logs.sh.keys' 2>/dev/null" >> $pre
echo "cp /userdata/system/pro/logs/logs.desktop /usr/share/applications/ 2>/dev/null" >> $pre
echo "fi" >> $pre
dos2unix $pre
chmod a+x $pre
# // 
# 
# -- add prelauncher to custom.sh to run @ reboot
csh=/userdata/system/custom.sh
if [[ -e $csh ]] && [[ "$(cat $csh | grep "/userdata/system/pro/$appname/extra/startup")" = "" ]]; then
echo -e "\n/userdata/system/pro/$appname/extra/startup" >> $csh
fi
if [[ -e $csh ]] && [[ "$(cat $csh | grep "/userdata/system/pro/$appname/extra/startup" | grep "#")" != "" ]]; then
echo -e "\n/userdata/system/pro/$appname/extra/startup" >> $csh
fi
if [[ -e $csh ]]; then :; else
echo -e "\n/userdata/system/pro/$appname/extra/startup" >> $csh
fi
dos2unix $csh
# //
#
echo ">> batocera-logs installed"
echo
echo
curl http://127.0.0.1:1234/reloadgames
# -- done. 