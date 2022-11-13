#!/usr/bin/env bash 
######################################################################
# BATOCERA.PRO/CEMU INSTALLER-UPDATER
######################################################################
# --------------------------------------------------------------------
# --------------------------------------------------------------------
# --------------------------------------------------------------------
######################################################################
APPNAME=CEMU.APPIMAGE # for installer info
appname=cemu # directory name /userdata/system/pro/...
APPPATH=/userdata/system/pro/cemu/Cemu
APPLINK=$(curl -s https://api.github.com/repos/cemu-project/Cemu/releases | grep AppImage | grep "browser_download_url" | awk '{print $2}' | sed 's,",,g' | head -n 1)
ORIGIN=GITHUB.COM/CEMU-PROJECT # credit & info 
# --------------------------------------------------------------------
# --------------------------------------------------------------------
# --------------------------------------------------------------------
# output colors:
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
# console theme
L=$X
R=$X
# --------------------------------------------------------------------
# prepare paths and files for installation 
# paths:
cd /userdata/system/
pro=/userdata/system/pro
mkdir $pro 2>/dev/null
mkdir $pro/extra 2>/dev/null
mkdir $pro/backups 2>/dev/null
mkdir $pro/$appname 2>/dev/null
mkdir $pro/$appname/extra 2>/dev/null
######################################################################
# prepare the dependencies for this app: 
dep=$pro/$appname/extra
d1=libthai.so.0
wget -q -O $dep/$d1 https://github.com/uureel/batocera.pro/raw/main/cemu/extra/$d1
cp $dep/$d1 /lib/ 2>/dev/null
######################################################################
# paths for installer dependencies: 
dep=$pro/$appname/extra
d1=tput
d2=libtinfo.so.6
wget -q -O $dep/$d1 https://github.com/uureel/batocera.pro/raw/main/cemu/extra/$d1
cp $dep/$d1 /usr/bin/ 2>/dev/null
wget -q -O $dep/$dep2 https://github.com/uureel/batocera.pro/raw/main/cemu/extra/$d2
cp $dep/$d2 /lib/ 2>/dev/null
cp $dep/$d2 /lib64/ 2>/dev/null
# --------------------------------------------------------------------
# --------------------------------------------------------------------
# // end of dependencies 
#
# RUN APP SPECIFIC FIXES FOR INSTALLER: 
######################################################################
######################################################################
######################################################################
######################################################################
######################################################################
killall Cemu 2>/dev/null && killall cemu 2>/dev/null && sleep 0.5 
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
# 
# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
# check system before proceeding
if [[ "$(uname -a | grep "x86_64")" != "" ]] && [[ "$(uname -a | awk '{print $3}')" > "6.0" ]]; then  
echo -e "${X}THIS WILL REPLACE BATOCERA CEMU VERSION WITH"
echo -e "${X}THE LATEST OFFICIAL APPIMAGE RELEASE: $LATEST"
echo
echo -e "${X}...INSTALLED IN /USERDATA/SYSTEM/PRO/CEMU"
echo
echo -e "${X}TO UNINSTALL:"
echo -e "${X}REMOVE FOLDER /USERDATA/SYSTEM/PRO/CEMU & RESTART"
echo
echo
echo -e "${X}FOLLOW THE BATOCERA DISPLAY"
echo
echo
echo -e "${X}. . .${X}" 
echo
else
echo -e "${RED}--------------------------------------------------------"
echo -e "${RED}ERROR: SYSTEM NOT SUPPORTED"
echo -e "${RED}--------------------------------------------------------"
echo
echo -e "${X}YOU NEED X86_64 BATOCERA V36+${X}"
echo -e "${X}TO USE LINUX CEMU BUILDS${X}"
echo
echo
echo
fi
# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
# --------------------------------------------------------------------
# --------------------------------------------------------------------
# // end of console info. 
#
#/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
#
# --------------------------------------------------------------------
# --------------------------------------------------------------------
# THIS WILL BE SHOWN ON BATOCERA DISPLAY:   
function batocera-pro-installer {
APPNAME=$1
appname=$2
APPPATH=$3
APPLINK=$4
ORIGIN=$5
LATEST=$6
# colors: 
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
# display theme:
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
#
# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
# check system before proceeding
if [[ "$(uname -a | grep "x86_64")" != "" ]] && [[ "$(uname -a | awk '{print $3}')" > "6.0" ]]; then  
echo -e "${W}THIS WILL REPLACE BATOCERA CEMU VERSION WITH"
echo -e "${W}THE LATEST OFFICIAL APPIMAGE RELEASE: ${G}$LATEST"
echo
echo -e "${W}THIS SCRIPT IS ALSO AN UPDATER"
echo
echo -e "${R}- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -"
echo
echo -e "${R}WARNING: THIS IS EXPERIMENTAL"
echo -e "${R}-----------------------------"
echo
echo -e "${W}BACKUP WILL BE MADE IN /USERDATA/SYSTEM/PRO/BACKUPS"
echo
echo -e "${W}TO UNINSTALL AND RESTORE BATOCERA CEMU:"
echo -e "${W}REMOVE /USERDATA/SYSTEM/PRO/CEMU FOLDER & RESTART"
echo
echo -e "${R}- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -"
echo
echo -e "${R}> > > ${W}PRESS ENTER TO CONTINUE"
read -p ""
echo -e "${L}- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -"
else
echo
echo -e "${R}- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -"
echo
echo -e "${R}ERROR: SYSTEM NOT SUPPORTED"
echo -e "${R}---------------------------"
echo
echo -e "${R}TO USE LINUX CEMU BUILDS${X}"
echo -e "${R}YOU NEED X86_64 BATOCERA V36+${X}"
echo
echo -e "${R}- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -"
echo
echo
echo
sleep 5
exit 0
# quit
exit 0
fi
# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#
# temp for curl download
temp=/userdata/system/pro/$appname/extra/downloads
rm -rf $temp 2>/dev/null
mkdir $temp 2>/dev/null
#
# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
  echo
  echo -e "${G}PREPARING${W} . . ."
  # --------------------------------------------------------------------
  timestamp=$(date +"%y%m%d-%H%M%S") 2>/dev/null
  if [[ "$(ls -s /usr/bin/cemu/cemu | awk '{print $1}')" > "9000" ]]; then
  mkdir /userdata/system/pro/backups 2>/dev/null
  mkdir /userdata/system/pro/backups/cemu-backup-$timestamp 2>/dev/null
  cp -rL /usr/bin/cemu/* /userdata/system/pro/backups/cemu-backup-$timestamp/ 2>/dev/null
  fi
  sleep 1.333
  echo -e "${G}> ${W}DONE"
  echo
  echo -e "${L}- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -"
  sleep 1.333
#
# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#
echo
echo -e "${G}DOWNLOADING${G} $APPNAME $LATEST . . .${W}"
sleep 1
echo -e "${T}$APPLINK" | sed 's,https://,> ,g' | sed 's,http://,> ,g' 2>/dev/null
# --------------------------------------------------------------------
rm /usr/bin/cemu/cemu 2>/dev/null
mkdir /userdata/system/pro/cemu/extra/downloads 2>/dev/null
cd /userdata/system/pro/cemu/extra/downloads
curl --progress-bar --remote-name --location "$APPLINK"
cd /userdata/system/
mv /userdata/system/pro/cemu/extra/downloads/* /userdata/system/pro/cemu/Cemu 2>/dev/null
rm -rf /userdata/system/pro/cemu/extra/downloads 2>/dev/null
chmod a+x /userdata/system/pro/cemu/Cemu 
SIZE=$(($(wc -c $APPPATH | awk '{print $1}')/1048576)) 2>/dev/null
echo -e "${T}$APPPATH ${T}($SIZE( )MB) ${G}OK${W}" | sed 's/( )//g'
echo
echo -e "${L}- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -"
sleep 1.333
#
# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#
echo
echo -e "${G}INSTALLING${W} . . ."
# --------------------------------------------------------------------
mv /userdata/saves/wiiu/shaderCache /userdata/saves/wiiu/.shaderCache 2>/dev/null
rm -rf /userdata/system/cache/Cemu/shaderCache 2>/dev/null
mv /userdata/saves/wiiu/.shaderCache /userdata/saves/wiiu/shaderCache 2>/dev/null
ln -s /userdata/saves/wiiu/shaderCache /userdata/system/cache/Cemu/shaderCache 2>/dev/null
ln -s /userdata/system/pro/cemu/Cemu /usr/bin/cemu/cemu 2>/dev/null
# --------------------------------------------------------------------
# make startup launcher to solve dependencies and avoid overlay, 
launcher=/userdata/system/pro/$appname/extra/startup
rm -rf $launcher
echo "#!/bin/bash" >> $launcher
echo "cp /userdata/system/pro/$appname/extra/lib* /lib/" >> $launcher
echo "mv /userdata/system/pro/cemu/Cemu /userdata/system/pro/cemu/.Cemu" >> $launcher
echo "rm /usr/bin/cemu/cemu" >> $launcher
echo "mv /userdata/system/pro/cemu/.Cemu /userdata/system/pro/cemu/Cemu" >> $launcher
echo "ln -s /userdata/system/pro/cemu/Cemu /usr/bin/cemu/cemu" >> $launcher
dos2unix $launcher
chmod a+x $launcher
# --------------------------------------------------------------------
# add prelauncher to custom.sh to run @ reboot / systemstart
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
dos2unix $csh 2>/dev/null
#///
# --------------------------------------------------------------------
sleep 1.333
echo -e "${G}> ${W}DONE"
echo
#
# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#
sleep 1.333
echo -e "${L}-----------------------------------------------------------------------"
echo -e "${W}$APPNAME $LATEST ${G}INSTALLED OK"
echo -e "${L}-----------------------------------------------------------------------"
sleep 3
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
export -f get-xterm-fontsize
# --------------------------------------------------------------------
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
# |
  DISPLAY=:0.0 xterm -fullscreen -bg black -fa 'Monospace' -fs $TEXT_SIZE -e bash -c "batocera-pro-installer $APPNAME $appname $APPPATH $APPLINK $ORIGIN $LATEST" 2>/dev/null
# --------------------------------------------------------------------
# BATOCERA.PRO/CEMU INSTALLER-UPDATER //
#######################################
exit 0
