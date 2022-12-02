#!/usr/bin/env bash 
######################################################################
# BATOCERA.PRO INSTALLER
######################################################################
# --------------------------------------------------------------------
# --------------------------------------------------------------------
# --------------------------------------------------------------------
APPNAME=MINECRAFT # for installer info
appname=minecraft # directory name in /userdata/system/pro/...
AppName=Minecraft # App.AppImage name
APPPATH=/userdata/system/pro/$appname/$AppName
APPLINK=https://github.com/uureel/batocera.pro/raw/main/minecraft/extra/Minecraft
ORIGIN="OFFICIAL MINECRAFT.NET LAUNCHER" # credit & info 
# --------------------------------------------------------------------
# --------------------------------------------------------------------
# --------------------------------------------------------------------
# --------------------------------------------------------------------
# show console/ssh info: 
clear
echo
echo
echo
echo -e "${X}PREPARING $APPNAME INSTALLER, PLEASE WAIT . . . ${X}"
echo
echo
echo
echo
# --------------------------------------------------------------------
# -- output colors:
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
# --------------------------------------------------------------------
# -- prepare dependencies for this app and the installer: 
url=https://github.com/uureel/batocera.pro/raw/main/.dep
depfile=dependencies.txt; dep=$pro/.dep; mkdir $pro/.dep 2>/dev/null; cd $dep
wget -q -O $dep/$depfile $url/$depfile 2>/dev/null; dos2unix $dep/$depfile;
nl=$(cat $dep/$depfile | wc -l); l=1; while [[ "$l" -le "$((nl+2))" ]]; do
d=$(cat $dep/$depfile | sed ""$l"q;d"); wget -q -O $dep/$d $url/$d 2>/dev/null; 
if [[ "$(echo $d | grep "lib")" != "" ]]; then ln -s $dep/$d /lib/$d 2>/dev/null; fi; ((l++)); done
wget -q -O $pro/$appname/extra/icon.png https://github.com/uureel/batocera.pro/raw/main/$appname/extra/icon.png; chmod a+x $dep/tput; cd ~/
# --------------------------------------------------------------------
# // end of dependencies 
#
# RUN BEFORE INSTALLER: 
######################################################################
killall wget 2>/dev/null && killall $AppName 2>/dev/null && killall $AppName 2>/dev/null && killall $AppName 2>/dev/null
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
echo
# // end of console info. 
#
#/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
#
# THIS WILL BE SHOWN ON MAIN BATOCERA DISPLAY:   
function batocera-pro-installer {
# --batocera-pro-discord-isntaller DISCORD_LINK DISCORD_PATH
APPNAME="$1"
appname="$2"
AppName="$3"
APPPATH="$4"
APPLINK="$5"
ORIGIN="$6"
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
if [[ "$(uname -a | grep "x86_64")" != "" ]]; then 
:
else
echo -e "${RED}ERROR: SYSTEM NOT SUPPORTED"
echo -e "${RED}YOU NEED BATOCERA X86_64${X}"
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
echo -e "${G}DOWNLOADING${W} $APPNAME LAUNCHER COMPONENTS [3/3]. . ."
#
# ----------------------------
# liblauncher.so
dep=/userdata/system/pro/minecraft/extra
cd /userdata/system/pro/minecraft/extra
d1=liblauncher.so
 p1=liblauncher.tar.bz2.partaa
 p2=liblauncher.tar.bz2.partab
 p3=liblauncher.tar.bz2.partac
curl --progress-bar --remote-name --location "https://github.com/uureel/batocera.pro/raw/main/$appname/extra/$p1"
curl --progress-bar --remote-name --location "https://github.com/uureel/batocera.pro/raw/main/$appname/extra/$p2"
curl --progress-bar --remote-name --location "https://github.com/uureel/batocera.pro/raw/main/$appname/extra/$p3"
# libselinux.so.1
d2=libselinux.so.1
wget -q -O /userdata/system/pro/minecraft/extra/$d2 https://github.com/uureel/batocera.pro/raw/main/$appname/extra/$d2
ln -s /userdata/system/pro/minecraft/extra/$d2 /lib/$d2 2>/dev/null
# tar
d3=tar
wget -q -O /userdata/system/pro/minecraft/extra/$d3 https://github.com/uureel/batocera.pro/raw/main/$appname/extra/$d3
chmod a+x $d3 
#
d4=libsecret-1.so.0
wget -q -O /userdata/system/pro/minecraft/extra/$d4 https://github.com/uureel/batocera.pro/raw/main/$appname/extra/$d4
# --- join liblauncher
cat /userdata/system/pro/minecraft/extra/liblauncher.tar.bz2.parta* >/userdata/system/pro/minecraft/extra/liblauncher.tar.gz
pro=/userdata/system/pro; chmod a+x $pro/.dep/tar; $pro/.dep/tar -xf /userdata/system/pro/minecraft/extra/liblauncher.tar.gz
chmod a+x /userdata/system/pro/minecraft/extra/liblauncher.so
chmod a+x /userdata/system/pro/minecraft/extra/libsecret-1.so.0
rm -rf /userdata/system/pro/minecraft/extra/liblauncher.tar* 2>/dev/null
#
SIZE=$(($(wc -c $dep/$d1 | awk '{print $1}')/1048576)) 2>/dev/null
echo -e "${T}$dep/$d1  (${T}$SIZE( )MB)  ${G}OK${W}" | sed 's/( )//g'
cd ~/
sleep 2
# ----------------------------
echo
echo -e "${G}DOWNLOADING${W} $APPNAME LAUNCHER. . ."
sleep 1
#echo -e "${T}$APPLINK" | sed 's,https://,> ,g' | sed 's,http://,> ,g' 2>/dev/null
cd $temp
curl --progress-bar --remote-name --location "$APPLINK"
cd ~/
mv $temp/* $APPPATH 2>/dev/null
chmod a+x $APPPATH 2>/dev/null
rm -rf $temp/*.AppImage
SIZE=$(($(wc -c $APPPATH | awk '{print $1}')/1048576)) 2>/dev/null
echo -e "${T}$APPPATH  (${T}$SIZE( )MB)  ${G}OK${W}" | sed 's/( )//g'
#
sleep 1
echo
#
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
launcher=/userdata/system/pro/minecraft/Launcher
rm -rf $launcher
echo '#!/bin/bash ' >> $launcher
echo ' dep=/userdata/system/pro/.dep; depfile=$dep/dependencies.txt; ' >> $launcher
echo ' nl=$(cat $depfile | wc -l); l=1; while [[ "$l" -le "$((nl+2))" ]]; do ' >> $launcher
echo ' d=$(cat $depfile | sed ""$l"q;d"); if [[ "$(echo $d | grep "lib")" != "" ]]; then ' >> $launcher
echo ' cp $dep/$d /lib/$d 2>/dev/null; fi; ((l++)); done ' >> $launcher
echo 'unclutter-remote -s' >> $launcher
## -- APP SPECIFIC LAUNCHER COMMAND: 
######################################################################
######################################################################
###################################################################### 
######################################################################
######################################################################
echo 'HOME=/userdata/system/pro/minecraft/home DISPLAY=:0.0 /userdata/system/pro/minecraft/Minecraft' >> $launcher
######################################################################
######################################################################
######################################################################
######################################################################
######################################################################
dos2unix $launcher
chmod a+x $launcher
# //
# -- get icon for shortcut,
icon=/userdata/system/pro/minecraft/extra/icon.png
wget -q -O $icon https://github.com/uureel/batocera.pro/raw/main/$appname/extra/icon.png
# //
# -- prepare f1 - applications - app shortcut, 
shortcut=/userdata/system/pro/minecraft/extra/minecraft-launcher.desktop
rm -rf $shortcut 2>/dev/null
echo "[Desktop Entry]" >> $shortcut
echo "Version=1.0" >> $shortcut
echo "Icon=/userdata/system/pro/minecraft/extra/icon.png" >> $shortcut
echo "Exec=/userdata/system/pro/minecraft/Launcher" >> $shortcut
echo "Terminal=false" >> $shortcut
echo "Type=Application" >> $shortcut
echo "Categories=Game;batocera.linux;" >> $shortcut
echo "Name=minecraft" >> $shortcut
f1shortcut=/usr/share/applications/minecraft-launcher.desktop
dos2unix $shortcut
cp $shortcut $f1shortcut 2>/dev/null
# //
# -- prepare Ports file, 
rm /userdata/roms/ports/Minecraft.sh 2>/dev/null
cp $pro/$appname/Launcher /userdata/roms/ports/Minecraft.sh
#
# -- prepare prelauncher to avoid overlay,
pre=/userdata/system/pro/minecraft/extra/startup
rm -rf $pre 2>/dev/null
echo "#!/usr/bin/env bash" >> $pre
echo "cp /userdata/system/pro/minecraft/extra/minecraft-launcher.desktop /usr/share/applications/minecraft-launcher.desktop 2>/dev/null" >> $pre
echo "mv /userdata/system/.minecraft /userdata/system/.minecraft0 2>/dev/null; rm -rf /userdata/system/.minecraft0 2>/dev/null" >> $pre
echo "mkdir /userdata/system/pro/minecraft/home 2>/dev/null; mkdir /userdata/system/pro/minecraft/config 2>/dev/null" >> $pre
echo "mkdir -p /userdata/system/pro/minecraft/home/launcher" >> $pre 
echo "cp /userdata/system/pro/minecraft/extra/liblauncher.so /userdata/system/pro/minecraft/home/launcher/liblauncher.so 2>/dev/null" >> $pre
echo "cp /userdata/system/pro/minecraft/extra/libsecret-1.so.0 /userdata/system/pro/minecraft/home/launcher/libsecret-1.so.0 2>/dev/null" >> $pre
echo "ln -s /userdata/system/pro/minecraft/extra/libsecret-1.so.0 /lib64/libsecret-1.so.0 2>/dev/null" >> $pre
#echo "ln -s /userdata/system/pro/minecraft/home /userdata/system/.minecraft 2>/dev/null" >> $pre
# -- dependencies linker: 
echo 'dep=/userdata/system/pro/minecraft/extra; cd $dep; rm -rf $dep/dep 2>/dev/null' >> $pre
echo 'ls -l ./lib* | awk "{print $9}" | cut -d "/" -f2 >> $dep/dep 2>/dev/null' >> $pre
echo 'nl=$(cat $dep/dep | wc -l); l=1; while [[ $l -le $nl ]]; do' >> $pre
echo 'lib=$(cat $dep/dep | sed ""$l"q;d"); ln -s $dep/$lib /lib/$lib 2>/dev/null; ((l++)); done' >> $pre
dos2unix $pre
chmod a+x $pre
/userdata/system/pro/minecraft/extra/startup
# // 
# 
# -- add prelauncher to custom.sh to run @ reboot
customsh=/userdata/system/custom.sh
if [[ -e $customsh ]] && [[ "$(cat $customsh | grep "/userdata/system/pro/$appname/extra/startup")" = "" ]]; then
echo -e "\n/userdata/system/pro/$appname/extra/startup" >> $customsh
fi
if [[ -e $customsh ]] && [[ "$(cat $customsh | grep "/userdata/system/pro/$appname/extra/startup" | grep "#")" != "" ]]; then
echo -e "\n/userdata/system/pro/$appname/extra/startup" >> $customsh
fi
if [[ -e $customsh ]]; then :; else
echo -e "\n/userdata/system/pro/$appname/extra/startup" >> $customsh
fi
dos2unix $customsh 2>/dev/null
# //
#
# -- done. 
sleep 1
echo -e "${G}> ${W}DONE"
echo
sleep 1
echo -e "${L}-----------------------------------------------------------------------"
echo -e "${W}> $APPNAME INSTALLED ${G}OK"
echo -e "${L}-----------------------------------------------------------------------"
sleep 4
}
export -f batocera-pro-installer 2>/dev/null
# --------------------------------------------------------------------
# include display output: 
function get-xterm-fontsize {
tput=/userdata/system/pro/.dep/tput; chmod a+x $tput; 
cp /userdata/system/pro/.dep/libtinfo.so.6 /lib/libtinfo.so.6 2>/dev/null
cfg=/userdata/system/pro/.dep/display.cfg; rm $cfg 2>/dev/null
DISPLAY=:0.0 xterm -fullscreen -bg "black" -fa "Monospace" -e bash -c "$tput cols >> $cfg" 2>/dev/null
cols=$(cat $cfg | tail -n 1) 2>/dev/null
TEXT_SIZE=$(bc <<<"scale=0;$cols/16") 2>/dev/null
}
export -f get-xterm-fontsize 2>/dev/null
get-xterm-fontsize 2>/dev/null
cfg=/userdata/system/pro/.dep/display.cfg
cols=$(cat $cfg | tail -n 1) 2>/dev/null
until [[ "$cols" != "80" ]] 
do
get-xterm-fontsize 2>/dev/null
cols=$(cat $cfg | tail -n 1) 2>/dev/null
done 
TEXT_SIZE=$(bc <<<"scale=0;$cols/16") 2>/dev/null
# --------------------------------------------------------------------
# RUN ALL:
  DISPLAY=:0.0 xterm -fullscreen -bg black -fa 'Monospace' -fs $TEXT_SIZE -e bash -c "batocera-pro-installer '$APPNAME' '$appname' '$AppName' '$APPPATH' '$APPLINK' '$ORIGIN'" 2>/dev/null
# --------------------------------------------------------------------
# version 1.0.3
# glhf
exit 0