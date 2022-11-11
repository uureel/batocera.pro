#!/usr/bin/env bash 
######################################################################
# BATOCERA.PRO DISCORD INSTALLER
######################################################################
# --------------------------------------------------------------------
# --------------------------------------------------------------------
# --------------------------------------------------------------------
APPNAME=DISCORD # for installer info
appname=discord # directory name /userdata/system/pro/...
APPPATH=/userdata/system/pro/discord/Discord.AppImage
APPLINK=https://github.com/srevinsaju/discord-appimage/releases/download/stable/Discord-0.0.21-x86_64.AppImage
ORIGIN=GITHUB.COM/SREVINSAJU/DISCORD-APPIMAGE # credit & info 
# --------------------------------------------------------------------
# --------------------------------------------------------------------
# --------------------------------------------------------------------
# output colors:
###########################
W='\033[0;37m'            # white
#-------------------------#
RED='\033[1;31m'          # red
BLUE='\033[1;34m'         # blue
GREEN='\033[1;32m'        # green
PURPLE='\033[1;35m'       # purple
DARKRED='\033[0;31m'      # darkred
DARKBLUE='\033[0;34m'     # darkblue
DARKGREEN='\033[0;32m'    # darkgreen
DARKPURPLE='\033[0;35m'   # darkpurple
###########################
# console theme
X='\033[0m' # / resetcolor
L=$X
R=$X
# --------------------------------------------------------------------
# prepare paths and files for installation 
# paths:
cd ~/
pro=/userdata/system/pro
mkdir $pro 2>/dev/null
mkdir $pro/extra 2>/dev/null
mkdir $pro/$appname 2>/dev/null
mkdir $pro/$appname/extra 2>/dev/null
######################################################################
######################################################################
######################################################################
######################################################################
######################################################################
# prepare the dependencies for this app: 
dep=$pro/$appname/extra
libatk=$dep/libatk-bridge-2.0.so.0
libatspi=$dep/libatspi.so.0
libcups=$dep/libcups.so.2
libdbus=$dep/libdbus-glib-1.so.2
wget -q -O $libatk https://github.com/uureel/batocera.pro/raw/main/discord/extra/libatk-bridge-2.0.so.0
wget -q -O $libatspi https://github.com/uureel/batocera.pro/raw/main/discord/extra/libatspi.so.0
wget -q -O $libcups https://github.com/uureel/batocera.pro/raw/main/discord/extra/libcups.so.2
wget -q -O $libdbus https://github.com/uureel/batocera.pro/raw/main/discord/extra/libdbus-glib-1.so.2
######################################################################
######################################################################
######################################################################
######################################################################
######################################################################
# paths for installer dependencies: 
dep=$pro/$appname/extra
tput=$dep/tput
libtinfo=$dep/libtinfo.so.6
wget -q -O $tput https://github.com/uureel/batocera.pro/raw/main/discord/extra/tput
chmod +x $tput
wget -q -O $libtinfo https://github.com/uureel/batocera.pro/raw/main/discord/extra/libtinfo.so.6
# --------------------------------------------------------------------
# link dependencies: 
cd $dep; rm -rf $dep/dep 2>/dev/null
ls -l ./lib* | awk '{print $9}' | cut -d "/" -f2 >> $dep/dep 2>/dev/null
nl=$(cat $dep/dep | wc -l); l=1; while [[ $l -le $nl ]]; do
lib=$(cat $dep/dep | sed ""$l"q;d"); ln -s $dep/$lib /lib/$lib 2>/dev/null; ((l++)); done
cd ~/
# --------------------------------------------------------------------
# // end of dependencies 
#
# RUN APP SPECIFIC FIXES FOR INSTALLER: 
######################################################################
######################################################################
######################################################################
######################################################################
######################################################################
killall wget 2>/dev/null && killall Discord 2>/dev/null && killall Discord 2>/dev/null && killall Discord 2>/dev/null
######################################################################
######################################################################
######################################################################
######################################################################
######################################################################
#
# --------------------------------------------------------------------
# show console/ssh info: 
clear
echo
echo
echo
echo -e "${X}BATOCERA.PRO/$APPNAME INSTALLER${X}"
echo
echo
echo
echo
# --------------------------------------------------------------------
sleep 0.33
# --------------------------------------------------------------------
clear
echo
echo
echo -e "${X}--------------------------------------------------------"
echo -e "${X}BATOCERA.PRO/$APPNAME INSTALLER${X}"
echo -e "${X}--------------------------------------------------------"
echo
echo
echo
# --------------------------------------------------------------------
sleep 0.33
# --------------------------------------------------------------------
clear
echo
echo -e "${X}--------------------------------------------------------"
echo -e "${X}--------------------------------------------------------"
echo -e "${X}BATOCERA.PRO/$APPNAME INSTALLER${X}"
echo -e "${X}--------------------------------------------------------"
echo -e "${X}--------------------------------------------------------"
echo
echo
# --------------------------------------------------------------------
sleep 0.33
# --------------------------------------------------------------------
clear
echo -e "${X}--------------------------------------------------------"
echo -e "${X}--------------------------------------------------------"
echo -e "${X}--------------------------------------------------------"
echo -e "${X}BATOCERA.PRO/$APPNAME INSTALLER${X}"
echo -e "${X}--------------------------------------------------------"
echo -e "${X}--------------------------------------------------------"
echo -e "${X}--------------------------------------------------------"
echo
# --------------------------------------------------------------------
sleep 0.33
echo -e "${X}THIS WILL INSTALL $APPNAME FOR BATOCERA"
echo -e "${X}USING $ORIGIN"
echo
echo -e "${X}$APPNAME WILL BE AVAILABLE IN F1->APPLICATIONS "
echo -e "${X}AND INSTALLED IN /USERDATA/SYSTEM/PRO/$APPNAME"
echo
echo -e "${X}FOLLOW THE BATOCERA DISPLAY"
echo
echo -e "${X}. . .${X}" 
echo
# // end of console info. 
#
#/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
#
# THIS WILL BE SHOWN ON MAIN BATOCERA DISPLAY:   
function batocera-pro-installer {
# --batocera-pro-discord-isntaller DISCORD_LINK DISCORD_PATH
APPNAME=$1
appname=$2
APPPATH=$3
APPLINK=$4
ORIGIN=$5
# -- colors: 
###########################
X='\033[0m'               # / resetcolor
W='\033[0;37m'            # white
#-------------------------#
RED='\033[1;31m'          # red
BLUE='\033[1;34m'         # blue
GREEN='\033[1;32m'        # green
PURPLE='\033[1;35m'       # purple
DARKRED='\033[0;31m'      # darkred
DARKBLUE='\033[0;34m'     # darkblue
DARKGREEN='\033[0;32m'    # darkgreen
DARKPURPLE='\033[0;35m'   # darkpurple
###########################
# -- display theme:
L=$W
T=$W
R=$RED
B=$BLUE
G=$GREEN
P=$PURPLE
# .
######################################################################
clear
echo
echo
echo
echo -e "${W}BATOCERA.PRO/${G}$APPNAME${W} INSTALLER ${W}"
echo
echo
echo
echo
# --------------------------------------------------------------------
sleep 0.33
# --------------------------------------------------------------------
clear
echo
echo
echo
echo -e "${W}BATOCERA.PRO/${W}$APPNAME${W} INSTALLER ${W}"
echo
echo
echo
echo
# --------------------------------------------------------------------
sleep 0.33
# --------------------------------------------------------------------
clear
echo
echo
echo -e "${L}-----------------------------------------------------------------------"
echo -e "${W}BATOCERA.PRO/${G}$APPNAME${W} INSTALLER ${W}"
echo -e "${L}-----------------------------------------------------------------------"
echo
echo
echo
# --------------------------------------------------------------------
sleep 0.33
# --------------------------------------------------------------------
clear
echo
echo -e "${L}-----------------------------------------------------------------------"
echo -e "${L}-----------------------------------------------------------------------"
echo -e "${W}BATOCERA.PRO/${W}$APPNAME${W} INSTALLER ${W}"
echo -e "${L}-----------------------------------------------------------------------"
echo -e "${L}-----------------------------------------------------------------------"
echo
echo
# --------------------------------------------------------------------
sleep 0.33
# --------------------------------------------------------------------
clear
echo -e "${L}-----------------------------------------------------------------------"
echo -e "${L}-----------------------------------------------------------------------"
echo -e "${L}-----------------------------------------------------------------------"
echo -e "${W}BATOCERA.PRO/${G}$APPNAME${W} INSTALLER ${W}"
echo -e "${L}-----------------------------------------------------------------------"
echo -e "${L}-----------------------------------------------------------------------"
echo -e "${L}-----------------------------------------------------------------------"
echo
# --------------------------------------------------------------------
sleep 0.33
echo -e "${W}THIS WILL INSTALL $APPNAME FOR BATOCERA"
echo -e "${W}USING $ORIGIN"
echo
echo -e "${W}$APPNAME WILL BE AVAILABLE IN F1->APPLICATIONS "
echo -e "${W}AND INSTALLED IN /USERDATA/SYSTEM/PRO/$APPNAME"
echo
echo -e "${G}> > > ${W}PRESS ENTER TO CONTINUE"
read -p ""
echo -e "${L}- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -"
# -- check system before proceeding
if [[ "$(uname -a | grep "x86_64")" != "" ]] && [[ "$(uname -a | awk '{print $3}')" > "5.19.17" ]] && [[ "$(uname -a | awk '{print $2}')" = "BATOCERA" ]]; then 
:
else
echo -e "${RED}ERROR: SYSTEM NOT SUPPORTED"
echo -e "${RED}YOU NEED BATOCERA 35+ X86_64${X}"
sleep 5
exit 0
# quit
exit 0
fi
#
# -- temp for curl download
temp=/userdata/system/pro/$appname/extra/downloads
rm -rf $temp 2>/dev/null
mkdir $temp 2>/dev/null
#
# --------------------------------------------------------------------
#
echo
echo -e "${G}DOWNLOADING${W} $APPNAME . . ."
sleep 1
echo -e "${T}$APPLINK" | sed 's,https://,> ,g' | sed 's,http://,> ,g' 2>/dev/null
cd $temp
curl --progress-bar --remote-name --location "$APPLINK"
cd ~/
mv $temp/* $APPPATH 2>/dev/null
chmod a+x $APPPATH 2>/dev/null
rm -rf $temp/*.AppImage
SIZE=$(($(wc -c $APPPATH | awk '{print $1}')/1048576)) 2>/dev/null
echo -e "${T}$APPPATH ${T}$SIZE( )MB ${G}OK${W}" | sed 's/( )//g'
echo -e "${G}> ${W}DONE"
echo
echo -e "${L}- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -"
sleep 1.333
#
# --------------------------------------------------------------------
#
echo
echo -e "${G}INSTALLING ${W}. . ."
# -- prepare launcher to solve dependencies on each run and avoid overlay, 
launcher=/userdata/system/pro/$appname/Launcher
rm -rf $launcher
echo "#!/bin/bash" >> $launcher
echo "cp /userdata/system/pro/$appname/extra/* /lib/ 2>dev/null && rm /lib/tput" >> $launcher
# -- APP SPECIFIC LAUNCHER COMMAND: 
######################################################################
######################################################################
###################################################################### 
######################################################################
######################################################################
echo 'if [ "$(pidof Discord)" != "" ]; then killall Discord 2>/dev/null && killall Discord 2>/dev/null && killall Discord 2>/dev/null; fi' >> $launcher
echo 'mkdir /userdata/system/pro/discord/home 2>/dev/null; mkdir /userdata/system/pro/discord/config 2>/dev/null; DISPLAY=:0.0 HOME=/userdata/system/pro/discord/home XDG_CONFIG_HOME=/userdata/system/pro/discord/config /userdata/system/pro/discord/Discord.AppImage --no-sandbox' >> $launcher
#echo 'DISPLAY=:0.0 QT_SCALE_FACTOR=1.50 GDK_SCALE=1.50 DISPLAY=:0.0 /userdata/system/pro/discord/Discord.AppImage --no-sandbox &' >> $launcher
######################################################################
######################################################################
######################################################################
######################################################################
######################################################################
chmod a+x $launcher
# //
# -- get icon for shortcut,
icon=/userdata/system/pro/$appname/extra/icon.png
if [[ -e "$icon" ]] && [[ $(wc -c "$icon" | awk '{print $1}') != "0" ]]; then
:
else 
wget -q -O $icon http://batocera.pro/$appname/extra/icon.png
fi
# //
# -- prepare f1 - applications - app shortcut, 
shortcut=/userdata/system/pro/$appname/extra/$appname.desktop
rm -rf $shortcut 2>/dev/null
echo "[Desktop Entry]" >> $shortcut
echo "Version=1.0" >> $shortcut
echo "Icon=/userdata/system/pro/$appname/extra/icon.png" >> $shortcut
echo "Exec=/userdata/system/pro/$appname/Launcher" >> $shortcut
echo "Terminal=false" >> $shortcut
echo "Type=Application" >> $shortcut
echo "Categories=Game;batocera.linux;" >> $shortcut
echo "Name=$appname" >> $shortcut
f1shortcut=/usr/share/applications/$appname.desktop
cp $shortcut $f1shortcut 2>/dev/null
# //
#
# -- prepare prelauncher to avoid overlay and start discord minimized on system launch,
pre=/userdata/system/pro/$appname/extra/startup
rm -rf $pre 2>/dev/null
echo "#!/usr/bin/env bash" >> $pre
echo "cp /userdata/system/pro/$appname/extra/$appname.desktop /usr/share/applications/ 2>/dev/null" >> $pre
# -- link dependencies: 
echo 'dep=/userdata/system/pro/'$appname'/extra; cd $dep; rm -rf $dep/dep 2>/dev/null' >> $pre
echo 'ls -l ./lib* | awk "{print $9}" | cut -d "/" -f2 >> $dep/dep 2>/dev/null' >> $pre
echo 'nl=$(cat $dep/dep | wc -l); l=1; while [[ $l -le $nl ]]; do' >> $pre
echo 'lib=$(cat $dep/dep | sed ""$l"q;d"); ln -s $dep/$lib /lib/$lib 2>/dev/null; ((l++)); done' >> $pre
# -- autostart minimized on systemlaunch (currently not working)
# echo 'sleep 20; mkdir /userdata/system/pro/discord/home 2>/dev/null; mkdir /userdata/system/pro/discord/config 2>/dev/null;' >> $pre
# echo "HOME=/userdata/system/pro/discord/home XDG_CONFIG_HOME=/userdata/system/pro/discord/config DISPLAY=:0.0 /userdata/system/pro/discord/Discord.AppImage --start-minimized --no-sandbox 2>/dev/null &" >> $pre
# echo 'su -c "HOME=/userdata/system/pro/discord/home XDG_CONFIG_HOME=/userdata/system/pro/discord/config DISPLAY=:0.0 /userdata/system/pro/discord/Discord.AppImage --start-minimized --no-sandbox 2>/dev/null &" root' >> $pre
chmod a+x $pre
# // 
# 
# -- add prelauncher to custom.sh to run @ reboot
customsh=/userdata/system/custom.sh
if [[ "$(cat $customsh | grep "/userdata/system/pro/$appname/extra/startup")" = "" ]]; then
echo "/userdata/system/pro/$appname/extra/startup" >> $customsh
else
if [[ "$(cat $customsh | grep "/userdata/system/pro/$appname/extra/startup" | grep "#")" != "" ]]; then
echo "/userdata/system/pro/$appname/extra/startup" >> $customsh
fi
fi
# //
#
# -- done. 
sleep 1
echo -e "${G}> ${W}DONE"
echo
sleep 1
echo -e "${L}-----------------------------------------------------------------------"
echo -e "${W}> $APPNAME ${G}INSTALLED OK"
echo -e "${L}-----------------------------------------------------------------------"
sleep 4
#
# -- reloadgames
curl http://127.0.0.1:1234/reloadgames
#
# -- end of batocera-pro-discord-installer.
# .
}
export -f batocera-pro-installer 2>/dev/null
# --------------------------------------------------------------------
# include display output: 
function get-xterm-fontsize {
appname=$1
#\
  tput=/userdata/system/pro/$appname/extra/tput
  chmod a+x $tput
  cfg=/userdata/system/pro/$appname/extra/display.settings
  rm $cfg 2>/dev/null
  DISPLAY=:0.0 xterm -fullscreen -bg "black" -fa "Monospace" -e bash -c "sleep 0.042 && $tput cols >> $cfg" 2>/dev/null
  cols=$(cat $cfg | tail -1) 2>/dev/null
  TEXT_SIZE=$(bc <<<"scale=0;$cols/16") 2>/dev/null
#/
}
export -f get-xterm-fontsize discord 2>/dev/null
# --------------------------------------------------------------------
# run until proper size is found (quick fix for a very long story): 
get-xterm-fontsize $appname 2>/dev/null
cfg=/userdata/system/pro/$appname/extra/display.settings
cols=$(cat $cfg | tail -1) 2>/dev/null
until [[ "$cols" != "80" ]] 
do 
get-xterm-fontsize $appname 2>/dev/null
cols=$(cat $cfg | tail -1) 2>/dev/null
done 
# --------------------------------------------------------------------
# RUN ALL:
  DISPLAY=:0.0 xterm -fullscreen -bg black -fa 'Monospace' -fs $TEXT_SIZE -e bash -c "batocera-pro-installer $APPNAME $appname $APPPATH $APPLINK $ORIGIN" 2>/dev/null
# --------------------------------------------------------------------
# version 1.0.3
# glhf
exit 0
