#!/usr/bin/env bash 
# BATOCERA.PRO INSTALLER
######################################################################
######################################################################
######################################################################
######################################################################
######################################################################
######################################################################
######################################################################
######################################################################
######################################################################
######################################################################
######################################################################
######################################################################
######################################################################
#--------------------------------------------------------------------- 
#       DEFINE APP INFO >> 
APPNAME=itch
APPLINK=https://itch.io/app/download?platform=linux
APPHOME='itch.io/ official linux app'
#---------------------------------------------------------------------
#       DEFINE LAUNCHER COMMAND >>
COMMAND='mkdir /userdata/system/pro/'$APPNAME'/home 2>/dev/null; mkdir /userdata/system/pro/'$APPNAME'/config 2>/dev/null; mkdir /userdata/system/pro/'$APPNAME'/roms 2>/dev/null; LD_LIBRARY_PATH="/userdata/system/pro/.dep:${LD_LIBRARY_PATH}" HOME=/userdata/system/pro/'$APPNAME'/home XDG_CONFIG_HOME=/userdata/system/pro/'$APPNAME'/config XDG_DATA_HOME=/userdata/system/pro/'$APPNAME'/home LATEST=$(ls -td ~/.itch/app* | head -n 1 | sed 's,^.*/app,app,g') DISPLAY=:0.0 "/userdata/system/pro/'$APPNAME'/home/$LATEST/itch" "$1" "$2" "$3" "$4" "$5" "$6" "$7" "$8" "$9" --no-sandbox'
#--------------------------------------------------------------------- 
######################################################################
######################################################################
######################################################################
######################################################################
######################################################################
######################################################################
######################################################################
######################################################################
######################################################################
######################################################################
######################################################################
######################################################################
######################################################################
# --------------------------------------------------------------------
APPNAME="${APPNAME^^}"; ORIGIN="${APPHOME^^}"; appname=$(echo "$APPNAME" | awk '{print tolower($0)}'); AppName=$appname; APPPATH=/userdata/system/pro/$appname/$AppName.AppImage
# --------------------------------------------------------------------
# --------------------------------------------------------------------
# show console/ssh info: 
clear 
echo 
echo 
echo 
echo -e "${X}PREPARING $APPNAME INSTALLER . . . ${X}"
echo 
echo 
echo 
# --------------------------------------------------------------------
# -- output colors:
###########################
X='\033[0m'               # 
W='\033[0m'               # 
#-------------------------#
RED='\033[0m'             # 
BLUE='\033[0m'            # 
GREEN='\033[0m'           # 
PURPLE='\033[0m'          # 
DARKRED='\033[0m'         # 
DARKBLUE='\033[0m'        # 
DARKGREEN='\033[0m'       # 
DARKPURPLE='\033[0m'      # 
###########################
# --------------------------------------------------------------------
# -- console theme
L=$X
R=$X
# --------------------------------------------------------------------
# -- prepare paths and files for installation: 
cd ~/
pro=/userdata/system/pro
mkdir $pro 2>/dev/null
mkdir $pro/extra 2>/dev/null
rm -rf $pro/$appname 2>/dev/null
mkdir $pro/$appname 2>/dev/null
mkdir $pro/$appname/extra 2>/dev/null
# --------------------------------------------------------------------
# -- pass launcher command as cookie for main function: 
command=$pro/$appname/extra/command; rm $command 2>/dev/null;
echo "$COMMAND" >> $command 2>/dev/null 
# --------------------------------------------------------------------
# -- prepare dependencies for this app and the installer: 
url=https://github.com/uureel/batocera.pro/raw/main/.dep
depfile=dependencies.txt; dep=$pro/.dep; mkdir $pro/.dep 2>/dev/null; cd $dep
wget -q -O $dep/$depfile $url/$depfile 2>/dev/null; dos2unix $dep/$depfile 1>/dev/null 2>/dev/null;
rm /userdata/system/pro/.dep/libtinfo.so.6 2>/dev/null
nl=$(cat $dep/$depfile | wc -l); l=1; while [[ "$l" -le "$((nl+2))" ]]; do
d=$(cat $dep/$depfile | sed ""$l"q;d"); wget -q -O $dep/$d $url/$d 2>/dev/null; 
if [[ "$(echo $d | grep "lib")" != "" ]]; then ln -s $dep/$d /lib/$d 2>/dev/null; fi; ((l++)); done
wget -q -O $pro/$appname/extra/icon.png https://github.com/uureel/batocera.pro/raw/main/$appname/extra/icon.png; chmod a+x $dep/tput; cd ~/
# --------------------------------------------------------------------
# // end of dependencies 
#
# --------------------------------------------------------------------
# -- run before installer:  
#killall wget 2>/dev/null && killall $AppName 2>/dev/null && killall $AppName 2>/dev/null && killall $AppName 2>/dev/null
# --------------------------------------------------------------------
cols=$($dep/tput cols); rm -rf /userdata/system/pro/$appname/extra/cols
echo $cols >> /userdata/system/pro/$appname/extra/cols
line(){
  local start=1
  local end=${1:-80}
  local str="${2:-=}"
  local range=$(seq $start $end)
  for i in $range ; do echo -n "${str}"; done
}
# -- show console/ssh info: 
clear
echo
echo
echo
echo -e "${X}BATOCERA.PRO/$APPNAME INSTALLER${X}"
echo
echo
echo
echo
sleep 0.33
clear
echo
echo
echo -e "${W}- - - - - - -"
echo -e "${X}BATOCERA.PRO/$APPNAME INSTALLER${X}"
echo -e "${W}- - - - - - -"
echo
echo
echo
sleep 0.33
clear
echo
echo -e "${W}- - - - - - -"
line $cols ' '; echo
echo -e "${X}BATOCERA.PRO/$APPNAME INSTALLER${X}"
line $cols ' '; echo
echo -e "${W}- - - - - - -"
echo
echo
sleep 0.33
clear
line $cols '\'; echo
line $cols '/'; echo
line $cols ' '; echo
echo -e "${X}BATOCERA.PRO/$APPNAME INSTALLER${X}"
line $cols ' '; echo
line $cols '/'; echo
line $cols '\'; echo
echo
sleep 0.33
echo -e "${X}THIS WILL INSTALL $APPNAME FOR BATOCERA"
echo -e "${X}USING $ORIGIN"
echo
echo -e "${X}$APPNAME WILL BE AVAILABLE F1->APPLICATIONS"
echo -e "${X}AND INSTALLED IN /USERDATA/SYSTEM/PRO/$APPNAME"
echo
echo -e "${X}FOLLOW THE BATOCERA DISPLAY"
echo
echo -e "${X}. . .${X}" 
echo
#/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
# --------------------------------------------------------------------
#\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
# -- THIS WILL BE SHOWN ON MAIN BATOCERA DISPLAY:   
function batocera-pro-installer {
APPNAME="$1"
appname="$2"
AppName="$3"
APPPATH="$4"
APPLINK="$5"
ORIGIN="$6"
# --------------------------------------------------------------------
# -- colors: 
###########################
X='\033[0m'               # 
W='\033[0m'               # 
#-------------------------#
RED='\033[0m'             # 
BLUE='\033[0m'            # 
GREEN='\033[0m'           # 
PURPLE='\033[0m'          # 
DARKRED='\033[0m'         # 
DARKBLUE='\033[0m'        # 
DARKGREEN='\033[0m'       # 
DARKPURPLE='\033[0m'      # 
###########################
# -- display theme:
L=$W
T=$W
R=$RED
B=$BLUE
G=$GREEN
P=$PURPLE
# --------------------------------------------------------------------
cols=$(cat /userdata/system/pro/.dep/display.cfg | tail -n 1)
cols=$(bc <<<"scale=0;$cols/1.3") 2>/dev/null
#cols=$(cat /userdata/system/pro/$appname/extra/cols | tail -n 1)
line(){
  local start=1
  local end=${1:-80}
  local str="${2:-=}"
  local range=$(seq $start $end)
  for i in $range ; do echo -n "${str}"; done
}
clear
echo
echo
echo
echo -e "${W}BATOCERA.PRO/${G}$APPNAME${W} INSTALLER ${W}"
echo
echo
echo
echo
sleep 0.33
clear
echo
echo
echo
echo -e "${W}BATOCERA.PRO/${W}$APPNAME${W} INSTALLER ${W}"
echo
echo
echo
echo
sleep 0.33
clear
echo
echo
echo -e "${W}- - - - - - -"
echo -e "${W}BATOCERA.PRO/${G}$APPNAME${W} INSTALLER ${W}"
echo -e "${W}- - - - - - -"
echo
echo
echo
sleep 0.33
clear
echo
echo -e "${W}- - - - - - -"
echo; #echo -e "${W}- - -"
echo -e "${W}BATOCERA.PRO/${W}$APPNAME${W} INSTALLER ${W}"
echo; #echo -e "${W}- - -"
echo -e "${W}- - - - - - -"
echo
echo
sleep 0.33
clear
echo -e "${W}- - - - - - -"
echo; #echo -e "${W}- - -"
echo; #echo -e "${W}- - -"
echo -e "${W}BATOCERA.PRO/${G}$APPNAME${W} INSTALLER ${W}"
echo; #echo -e "${W}- - -"
echo; #echo -e "${W}- - -"
echo -e "${W}- - - - - - -"
echo
sleep 0.33

clear
echo;
echo; #echo -e "${W}- - -"
echo; #echo -e "${W}- - -"
echo -e "${W}BATOCERA.PRO/${G}$APPNAME${W} INSTALLER ${W}"
echo; #echo -e "${W}- - -"
echo; #echo -e "${W}- - -"
echo;
echo -e "${W}THIS WILL INSTALL $APPNAME FOR BATOCERA"
echo -e "${W}USING $ORIGIN"
echo
echo -e "${W}$APPNAME WILL BE AVAILABLE F1->APPLICATIONS"
echo -e "${W}AND INSTALLED IN /USERDATA/SYSTEM/PRO/$APPNAME"
echo 
#echo -e "${G}> > > ${W}PRESS ENTER TO CONTINUE" 
#read -p ""
sleep 4
echo; #echo -e "${W}- - -"
# --------------------------------------------------------------------
# -- check system before proceeding
if [[ "$(uname -a | grep "x86_64")" != "" ]]; then 
:
else
echo
echo -e "${RED}ERROR: SYSTEM NOT SUPPORTED"
echo -e "${RED}YOU NEED BATOCERA X86_64${X}"
echo
sleep 5
exit 0
# quit
exit 0
fi
# --------------------------------------------------------------------
# -- temp for curl download
pro=/userdata/system/pro
temp=$pro/$appname/extra/downloads
rm -rf $temp 2>/dev/null 
mkdir -p $temp 2>/dev/null
# --------------------------------------------------------------------
echo 
echo -e "${G}DOWNLOADING${W}" 
cd $temp 
echo -e "${T}$APPLINK" | sed 's,https://,> ,g' | sed 's,http://,> ,g' 2>/dev/null 
curl --progress-bar --remote-name --location "$APPLINK"
SIZE=$(du -sh $temp | awk '{print $1}') 2>/dev/null 
echo -e "${T}$temp  ${T}$SIZE( )  ${G}OK${W}" | sed 's/( )//g' 
echo 
echo; #echo -e "${W}- - -" 
sleep 1.333 
# --------------------------------------------------------------------
echo -e "${G}INSTALLING${W}" 
# --------------------------------------------------------------------
mkdir $pro/$appname/home 2>/dev/null
# clear ~/.itch folder for seamless install
cp -rL ~/.itch/* $pro/$appname/home/ 2>/dev/null
mv $pro/$appname/home $pro/$appname/home_tmp 2>/dev/null
rm -rf ~/.itch 2>/dev/null
mv $pro/$appname/home_tmp $pro/$appname/home 2>/dev/null
# clear //
#
cd $temp
chmod a+x $temp/* 2>/dev/null
$temp/download 2>/dev/null
wait
#
# move default ~/.itch installdir & link it with pro/itch
# -- link folders \
mkdir $pro/$appname/home 2>/dev/null
cp -rL ~/.itch/* $pro/$appname/home/ 2>/dev/null
mv $pro/$appname/home $pro/$appname/home_tmp 2>/dev/null
rm -rf ~/.itch 2>/dev/null
mv $pro/$appname/home_tmp $pro/$appname/home 2>/dev/null
ln -s $pro/$appname/home ~/.itch 2>/dev/null
# -- link folders // 
#
cd $pro
#rm -rf $temp
SIZE=$(du -sh $pro/$appname | awk '{print $1}') 2>/dev/null
echo -e "${T}$pro/$appname  ${T}$SIZE( )  ${G}OK${W}" | sed 's/( )//g'
# --------------------------------------------------------------------
# -- prepare launcher to solve dependencies on each run and avoid overlay, 
launcher=/userdata/system/pro/$appname/Launcher
rm -rf $launcher
echo '#!/bin/bash ' >> $launcher
echo 'unclutter-remote -s' >> $launcher 
echo 'pro=/userdata/system/pro; APPNAME=itch; appname=itch' >> $launcher
echo 'mkdir $pro/$appname/home 2>/dev/null' >> $launcher 
echo 'cp -rL ~/.itch $pro/$appname/home 2>/dev/null' >> $launcher 
echo 'mv $pro/$appname/home $pro/$appname/home_tmp 2>/dev/null' >> $launcher 
echo 'rm -rf ~/.itch 2>/dev/null' >> $launcher 
echo 'mv $pro/$appname/home_tmp $pro/$appname/home 2>/dev/null' >> $launcher 
echo 'ln -s $pro/$appname/home ~/.itch 2>/dev/null' >> $launcher 
## -- GET APP SPECIFIC LAUNCHER COMMAND: 
######################################################################
echo "$(cat /userdata/system/pro/$appname/extra/command)" >> $launcher
######################################################################
dos2unix $launcher
chmod a+x $launcher
rm /userdata/system/pro/$appname/extra/command 2>/dev/null
# --------------------------------------------------------------------
# get icon
extra=https://github.com/uureel/batocera.pro/raw/main/$appname/extra
wget -q -O $pro/$appname/extra/icon.png $extra/icon.png
# --------------------------------------------------------------------
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
dos2unix $shortcut 
chmod a+x $shortcut 
cp $shortcut $f1shortcut 2>/dev/null
# --------------------------------------------------------------------
# -- prepare Ports file, 
#port="/userdata/roms/ports/itch.io.sh" 
#rm "$port" 2>/dev/null
#echo '#!/bin/bash ' >> $port
#echo 'killall -9 itch' >> $port
#echo '/userdata/system/pro/'$appname'/Launcher' >> $port
#dos2unix "$port" 
#chmod a+x "$port" 
# --------------------------------------------------------------------
# -- prepare prelauncher to avoid overlay,
pre=/userdata/system/pro/$appname/extra/startup
rm -rf $pre 2>/dev/null
echo "#!/usr/bin/env bash" >> $pre
echo "cp /userdata/system/pro/$appname/extra/$appname.desktop /usr/share/applications/ 2>/dev/null" >> $pre
dos2unix $pre
chmod a+x $pre
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
# -- done. 
sleep 1
echo -e "${G}> ${W}DONE${W}"
echo
sleep 1
echo; #echo -e "${W}- - -"
echo
echo -e "${G}> ${W}$APPNAME INSTALLED ${G}OK${W}"
#echo -e "${W}- - -"
echo
R='\033[1;31m'
echo
#echo -e "${R}----${W}" 
#echo -e "${R}NOTE   ${W}STARTING ITCH FROM PORTS CAN OPEN IT IN BACKGROUND! (USE ALT+TAB) ${W}"
#echo -e "${R}----${W}" 
sleep 5
# reaload for ports file
curl http://127.0.0.1:1234/reloadgames
}
export -f batocera-pro-installer 2>/dev/null
# --------------------------------------------------------------------
# RUN:
# |
  batocera-pro-installer "$APPNAME" "$appname" "$AppName" "$APPPATH" "$APPLINK" "$ORIGIN" 2>/dev/null
# --------------------------------------------------------------------
# BATOCERA.PRO INSTALLER //
##########################
exit 0