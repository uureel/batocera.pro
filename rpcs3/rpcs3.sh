#!/usr/bin/env bash 
# 
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
# theme
X='\033[0m' # / resetcolor 
L=$X
R=$X
G=$GREEN
# -----------------------------------------------------------------------------------------
# show console/ssh info: 
clear 
echo 
echo 
echo 
echo -e "${X}PREPARING RPCS3 UPDATER, PLEASE WAIT . . . ${X}"
echo 
echo 
echo 
# -----------------------------------------------------------------------------------------
# paths:
pro=/userdata/system/pro
mkdir -p $pro 2>/dev/null
mkdir -p $pro/rpcs3 2>/dev/null
mkdir -p $pro/rpcs3/extra 2>/dev/null
extra=$pro/rpcs3/extra 
# prepare dependencies: 
wget -q -O /userdata/system/pro/rpcs3/extra/tput https://github.com/uureel/batocera.pro/raw/main/rpcs3/extra/tput
chmod +x $pro/rpcs3/extra/tput
wget -q -O /userdata/system/pro/rpcs3/extra/libtinfo.so.6 https://github.com/uureel/batocera.pro/raw/main/rpcs3/extra/libtinfo.so.6
rm /lib/libtinfo.so.6 2>/dev/null; ln -s /userdata/system/pro/rpcs3/extra/libtinfo.so.6 /lib/libtinfo.so.6 2>/dev/null
# -----------------------------------------------------------------------------------------
clear
echo
echo
echo
echo -e "${R}BATOCERA.PRO/RPCS3 UPDATER${W}"
echo
echo
echo
echo
######################################################################
sleep 0.33
######################################################################
clear
echo
echo
echo -e "${L}--------------------------------------------------------"
echo -e "${R}BATOCERA.PRO/RPCS3 UPDATER${W}"
echo -e "${L}--------------------------------------------------------"
echo
echo
echo
######################################################################
sleep 0.33
######################################################################
clear
echo
echo -e "${L}--------------------------------------------------------"
echo
echo -e "${R}BATOCERA.PRO/RPCS3 UPDATER${W}"
echo
echo -e "${L}--------------------------------------------------------"
echo
echo
######################################################################
sleep 0.33
######################################################################
clear
echo -e "${L}--------------------------------------------------------"
echo
echo
echo -e "${R}BATOCERA.PRO/RPCS3 UPDATER${W}"
echo
echo
echo -e "${L}--------------------------------------------------------"
echo
######################################################################
sleep 0.33
echo -e "${R}THIS WILL INSTALL THE LATEST RPCS3 FOR BATOCERA"
echo 
echo -e "${R}BACKUP WILL BE MADE IN /USERDATA/SYSTEM/PRO/RPCS3/"
echo 
echo -e "${R}YOU'LL BE ABLE TO CHOOSE RPCS3 VERSIONS FROM PORTS"
echo
echo
echo -e "${R}> FOLLOW THE BATOCERA DISPLAY . . ."
echo
echo
# -----------------------------------------------------------------------------------------
function batocera-pro-rpcs3updater {
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
# theme
T=$W
B=$BLUE
P=$PURPLE
G=$GREEN
L=$W
######################################################################
clear
echo
echo
echo
echo -e "${W}BATOCERA.PRO"
echo
echo
echo
echo
######################################################################
sleep 0.33
######################################################################
clear
echo
echo
echo
echo -e "${W}BATOCERA.PRO/${G}RPCS3 UPDATER ${W}"
echo
echo
echo
echo
######################################################################
sleep 0.33
######################################################################
clear
echo
echo
echo -e "${L}-------------------------------------------------------"
echo -e "${W}BATOCERA.PRO/${G}RPCS3 UPDATER ${W}"
echo -e "${L}-------------------------------------------------------"
echo
echo
echo
######################################################################
sleep 0.33
######################################################################
clear
echo
echo -e "${L}-------------------------------------------------------"
echo
echo -e "${W}BATOCERA.PRO/${G}RPCS3 UPDATER ${W}"
echo
echo -e "${L}-------------------------------------------------------"
echo
echo
######################################################################
sleep 0.33
######################################################################
clear
echo -e "${L}-------------------------------------------------------"
echo
echo
echo -e "${W}BATOCERA.PRO/${G}RPCS3 UPDATER ${W}"
echo
echo
echo -e "${L}-------------------------------------------------------"
echo
######################################################################
sleep 0.33
echo -e "${R}THIS WILL INSTALL THE LATEST RPCS3 FOR BATOCERA"
echo 
echo -e "${R}BACKUP WILL BE MADE IN /USERDATA/SYSTEM/PRO/RPCS3/"
echo 
echo -e "${R}YOU'LL BE ABLE TO CHOOSE RPCS3 VERSIONS FROM PORTS"
echo 
echo -e "${G}> ${W}PRESS ENTER TO CONTINUE"
read -p ""
echo -e "${L}- - - - - - - - - - - - - - - - - - - - - - - - - - - - "
# -----------------------------------------------------------------------------------------
echo
# -----------------------------------------------------------------------------------------
# check system before proceeding
if [[ "$(uname -a | grep "x86_64")" != "" ]] && [[ "$(uname -a | awk '{print $3}')" > "5.19.17" ]]; then	
:
else
echo
echo -e "${RED}ERROR: THIS SYSTEM IS NOT SUPPORTED"
echo -e "${RED}YOU NEED X86_64 BATOCERA VERSION 35+"
echo
sleep 3
exit 0
# quit
exit 0
fi
sleep 1
echo -e "${T}PREPARING BACKUP . . .${WHITE}"
# -----------------------------------------------------------------------------------------
# prepare directories for newrpcs3
mkdir /userdata/system/pro 2>/dev/null
mkdir /userdata/system/pro/rpcs3 2>/dev/null
mkdir /userdata/system/pro/rpcs3/backup 2>/dev/null
mkdir /userdata/system/pro/rpcs3/backup/saves 2>/dev/null
mkdir /userdata/system/pro/rpcs3/backup/saves-$timestamp 2>/dev/null
timestamp=$(date +"%y%m%d-%H%M%S")
# -----------------------------------------------------------------------------------------
# backup original /usr/bin/rpcs3 to /userdata/system/pro/rpcs3/backup/rpcs3
rpcs3backup=0
batorpcs3version=$(/usr/bin/rpcs3 --version 2>/dev/null | grep RPCS3 | grep "local_build" | cut -d " " -f 2 | tr -d \")
if [ "$batorpcs3version" = "" ]; then
 batorpcs3version=$(/userdata/system/pro/rpcs3/backup/rpcs3 --version 2>/dev/null | grep RPCS3 | cut -d " " -f 2 | tr -d \")
  if [ "$batorpcs3version" = "" ]; then
  batorpcs3version="not found"
  else
  rpcs3backup=1
  rm -rf /userdata/system/pro/rpcs3/extra/rpcs3backup.txt
  echo "1" >> /userdata/system/pro/rpcs3/extra/rpcs3backup.txt
  fi
batorpcs3version="not found"
else
  cp /usr/bin/rpcs3 /userdata/system/pro/rpcs3/backup/ 2>/dev/null
  rm -rf /userdata/system/pro/rpcs3/extra/rpcs3backup.txt
  echo "1" >> /userdata/system/pro/rpcs3/extra/rpcs3backup.txt
fi 
cp /usr/bin/batocera-config-rpcs3 /userdata/system/pro/rpcs3/backup/ 2>/dev/null
# -----------------------------------------------------------------------------------------
# backup savedata to /userdata/system/pro/rpcs3/backup/savedata
cp -r /userdata/saves/ps3/* /userdata/system/pro/rpcs3/backup/saves-$timestamp 2>/dev/null
# -----------------------------------------------------------------------------------------
# link all savedatas into /userdata/saves/ps3 
if [[ -e "/userdata/system/configs/rpcs3/dev_hdd0/savedata" ]] && [[ "$(du -sh /userdata/system/configs/rpcs3/dev_hdd0/savedata/ | awk '{print $1}')" != "8.0K" ]]; then 
mkdir /userdata/system/pro/rpcs3/backup/savedata 2>/dev/null
cp -rL /userdata/system/configs/rpcs3/dev_hdd0/savedata/* /userdata/system/pro/rpcs3/backup/savedata/ 2>/dev/null
fi
if [[ -e "/userdata/system/.config/rpcs3/dev_hdd0/savedata" ]] && [[ "$(du -sh /userdata/system/.config/rpcs3/dev_hdd0/savedata/ | awk '{print $1}')" != "8.0K" ]]; then 
mkdir /userdata/system/pro/rpcs3/backup/.savedata 2>/dev/null
cp -rL /userdata/system/.config/rpcs3/dev_hdd0/savedata/* /userdata/system/pro/rpcs3/backup/.savedata/ 2>/dev/null
fi
rm -r /userdata/system/configs/rpcs3/dev_hdd0/savedata 2>/dev/null
rm -r /userdata/system/.config/rpcs3/dev_hdd0/savedata 2>/dev/null
ln -s /userdata/saves/ps3 /userdata/system/configs/rpcs3/dev_hdd0/savedata 2>/dev/null
ln -s /userdata/saves/ps3 /userdata/system/.config/rpcs3/dev_hdd0/savedata 2>/dev/null
cp -r /userdata/system/pro/rpcs3/backup/saves-$timestamp/* /userdata/saves/ps3/ 2>/dev/null
sleep 1
# -----------------------------------------------------------------------------------------
# show backup info
if [[ "$(cat /userdata/system/pro/rpcs3/extra/rpcs3backup.txt | tail -n 1)" = "1" ]]; then
echo -e "${W}/userdata/system/pro/rpcs3/backup/rpcs3"
sleep 1
fi
echo -e "${W}/userdata/system/pro/rpcs3/backup/batocera-config-rpcs3"
sleep 1
echo -e "${W}/userdata/system/pro/rpcs3/backup/saves-$timestamp"
sleep 1
echo -e "${G}> ${W}DONE"
echo
echo -e "${L}- - - - - - - - - - - - - - - - - - - - - - - - - - - - "
# -----------------------------------------------------------------------------------------
# download latest rpcs3 to /userdata/system/pro/rpcs3/newrpcs3
sleep 1
echo
echo -e "${T}DOWNLOADING LATEST RPCS3 . . .${T}"
#wget -q --show-progress -O /userdata/system/pro/rpcs3/newrpcs3 $(curl -s https://rpcs3.net/download | grep rpcs3-binaries-linux | grep "<a href" | cut -d " -f 2 | cut -d " -f 2 | cut -d = -f 2 | tr -d \") 
appname=rpcs3
APPLINK=$(curl -s https://rpcs3.net/download | grep rpcs3-binaries-linux | grep "<a href" | cut -d " -f 2 | cut -d " -f 2 | cut -d = -f 2 | tr -d \")
APPPATH=/userdata/system/pro/rpcs3/newrpcs3
temp=/userdata/system/pro/$appname/extra/downloads
rm -rf $temp 2>/dev/null
mkdir -p $temp 2>/dev/null
# --------------------------------------------------------------------
echo -e "${T}$APPLINK" | sed 's,https://,> ,g' | sed 's,http://,> ,g' | sed 's,^.*github.com/,,g' 2>/dev/null
cd $temp
curl --progress-bar --remote-name --location "$APPLINK"
cd ~/
mv $temp/* $APPPATH 2>/dev/null
chmod a+x $APPPATH 2>/dev/null
rm -rf $temp
newrpcs3size=$(($(wc -c /userdata/system/pro/rpcs3/newrpcs3 | awk '{print $1}')/1048576)) 2>/dev/null
newrpcs3version=$(curl -s https://rpcs3.net/download | grep rpcs3-binaries-linux | grep "<a href" | cut -d " -f 2 | cut -d " -f 2 | cut -d = -f 2 | sed 's/rpcs3-v//g' | tr -d \" | cut -d / -f 9 | cut -d _ -f 1)
batorpcs3version=$(/userdata/system/pro/rpcs3/backup/rpcs3 --version 2>/dev/null | grep RPCS3 | cut -d " " -f 2 | tr -d \")
if [ "$batorpcs3version" = "" ]; then
batorpcs3version="not found"
fi 
echo -e "${W}BATOCERA ${W}$batorpcs3version"
echo -e "${W}LATEST   ${G}$newrpcs3version"
echo -e "${G}> ${W}DONE"
echo
echo -e "${L}- - - - - - - - - - - - - - - - - - - - - - - - - - - - "
# -----------------------------------------------------------------------------------------
# prepare roms/ports launchers
sleep 1
echo
# delete old ports
rm -rf "/userdata/roms/ports/RPCS3 Updater.sh" 2>/dev/null
rm -rf "/userdata/roms/ports/RPCS3 use Batocera.sh" 2>/dev/null
rm -rf "/userdata/roms/ports/RPCS3 use Latest.sh" 2>/dev/null
# prepare ports updater
echo "#!/usr/bin/env bash" >> "/userdata/roms/ports/RPCS3 Updater.sh" 2>/dev/null
echo "curl -L rpcs3.batocera.pro | bash" >> "/userdata/roms/ports/RPCS3 Updater.sh" 2>/dev/null
chmod a+x "/userdata/roms/ports/RPCS3 Updater.sh" 2>/dev/null
# prepare ports 'use batocera version' 
wget -q -O "/userdata/roms/ports/RPCS3 use Batocera.sh" https://github.com/uureel/batocera.pro/raw/main/rpcs3/extra/rpcs3-use-batocera.sh
dos2unix "/userdata/roms/ports/RPCS3 use Batocera.sh" && chmod a+x "/userdata/roms/ports/RPCS3 use Batocera.sh"
# prepare ports 'use latest version'
wget -q -O "/userdata/roms/ports/RPCS3 use Latest.sh" https://github.com/uureel/batocera.pro/raw/main/rpcs3/extra/rpcs3-use-latest.sh
dos2unix "/userdata/roms/ports/RPCS3 use Latest.sh" && chmod a+x "/userdata/roms/ports/RPCS3 use Latest.sh"
#
echo -e "${T}ADDING PORTS . . ." 
echo -e "${G}1${W} RPCS3 Updater" 
sleep 1 
echo -e "${G}2${W} RPCS3 use Batocera" 
sleep 1 
echo -e "${G}3${W} RPCS3 use Latest" 
sleep 1 
# -----------------------------------------------------------------------------------------
# prepare launchers for chosen rpcs3 version:
wget -q -O "/userdata/system/pro/rpcs3/backup/batocera-config-rpcs3" https://github.com/uureel/batocera.pro/raw/main/rpcs3/extra/batocera-config-rpcs3.sh
dos2unix "/userdata/system/pro/rpcs3/backup/batocera-config-rpcs3" && chmod a+x "/userdata/system/pro/rpcs3/backup/batocera-config-rpcs3"
# 
if [[ -e "/userdata/system/pro/rpcs3/backup/rpcs3" ]] && [[ -e "/userdata/system/pro/rpcs3/backup/batocera-config-rpcs3" ]]; then 
wget -q -O "/userdata/system/pro/rpcs3/extra/usrbinrpcs3" https://github.com/uureel/batocera.pro/raw/main/rpcs3/extra/rpcs3-usrbinrpcs3.sh
dos2unix "/userdata/system/pro/rpcs3/extra/usrbinrpcs3" && chmod a+x "/userdata/system/pro/rpcs3/extra/usrbinrpcs3"
fi
# 
if [[ -e "/userdata/system/pro/rpcs3/backup/batocera-config-rpcs3" ]]; then 
wget -q -O "/usr/bin/batocera-config-rpcs3" https://github.com/uureel/batocera.pro/raw/main/rpcs3/extra/rpcs3-usrbinrpcs3.sh
dos2unix "/usr/bin/batocera-config-rpcs3" && chmod a+x "/usr/bin/batocera-config-rpcs3"
else
wget -q -O "/usr/bin/batocera-config-rpcs3" https://github.com/uureel/batocera.pro/raw/main/rpcs3/extra/rpcs3-usrbinrpcs3.sh
dos2unix "/usr/bin/batocera-config-rpcs3" && chmod a+x "/usr/bin/batocera-config-rpcs3"
fi
# 
echo -e "${G}> ${W}DONE"
echo
echo -e "${L}- - - - - - - - - - - - - - - - - - - - - - - - - - - - "
sleep 2
echo
echo -e "${T}PREPARING SYSTEM . . . "
sleep 0.5
# -----------------------------------------------------------------------------------------
# set rpcs3 to use latest version: 
rm /userdata/system/pro/rpcs3/extra/whichrpcs3.cfg 2>/dev/null
echo "/userdata/system/pro/rpcs3/newrpcs3" >> /userdata/system/pro/rpcs3/extra/whichrpcs3.cfg 2>/dev/null
cp /userdata/system/pro/rpcs3/extra/usrbinrpcs3 /usr/bin/rpcs3 2>/dev/null
# -----------------------------------------------------------------------------------------
# prepare prelauncher for startup to avoid overlay:
pre=/userdata/system/pro/rpcs3/extra/startup
rm -rf $pre 2>/dev/null
echo "#!/usr/bin/env bash" >> $pre
echo "cp /userdata/system/pro/rpcs3/extra/usrbinrpcs3 /usr/bin/rpcs3 2>/dev/null" >> $pre
dos2unix $pre
chmod a+x $pre
# -- add prelauncher to custom.sh to run @ reboot
csh=/userdata/system/custom.sh 
startup=$pre 
if [[ -e $csh ]]; 
then 
   tmp=/userdata/system/customsh.tmp
   remove=$pre
   rm $tmp 2>/dev/null
   nl=$(cat $csh | wc -l)
   l=1; while [[ $l -le $nl ]]; do
   ln=$(cat $csh | sed ""$l"q;d")
   if [[ "$(echo $ln | grep "$remove")" != "" ]]; then :; else echo "$ln" >> $tmp; fi
   ((l++))
   done
   cp $tmp $csh 2>/dev/null
   rm $tmp 2>/dev/null
   echo -e "\n$startup \n" >> $csh   
   dos2unix $csh 
   chmod a+x $csh 
else 
   echo -e "\n$startup \n" >> $csh
fi 
dos2unix $csh 2>/dev/null
chmod a+x $csh
# -----------------------------------------------------------------------------------------
echo -e "${G}> ${W}DONE"
echo
sleep 1
#echo -e "${L}--------------------------------------------------------"
#echo -e "${L}--------------------------------------------------------"
echo -e "${L}-------------------------------------------------------"
echo -e "${G}> NEW RPCS3 INSTALLED OK ${W}"
echo -e "${L}-------------------------------------------------------"
#echo -e "${L}--------------------------------------------------------"
#echo -e "${L}--------------------------------------------------------"
echo
rm -rf /userdata/system/pro/rpcs3/extra/installation.txt 2>/dev/null
echo "done" >> /userdata/system/pro/rpcs3/extra/installation.txt 2>/dev/null
sleep 3
curl http:/127.0.0.1:1234/reloadgames 2>/dev/null 
sleep 0.1
}
# --------------------------------------------------------------------
export -f batocera-pro-rpcs3updater 2>/dev/null
# --------------------------------------------------------------------
# include display output: 
function get-xterm-fontsize { 
# prepare dependencies: 
tput=/userdata/system/pro/rpcs3/extra/tput; chmod a+x $tput 2>/dev/null 
cp /userdata/system/pro/rpcs3/extra/libtinfo.so.6 /lib/libtinfo.so.6 2>/dev/null
cfg=/userdata/system/pro/rpcs3/extra/display.cfg; rm $cfg 2>/dev/null
DISPLAY=:0.0 xterm -fullscreen -bg "black" -fa "Monospace" -e bash -c "$tput cols >> $cfg" 2>/dev/null
cols=$(cat $cfg | tail -n 1) 2>/dev/null
TEXT_SIZE=$(bc <<<"scale=0;$cols/16") 2>/dev/null
} 
export -f get-xterm-fontsize 2>/dev/null 
get-xterm-fontsize 2>/dev/null 
cfg=/userdata/system/pro/rpcs3/extra/display.cfg 
cols=$(cat $cfg | tail -n 1) 2>/dev/null 
until [[ "$cols" != "80" ]] 
do 
get-xterm-fontsize 2>/dev/null 
cols=$(cat $cfg | tail -n 1) 2>/dev/null 
done 
TEXT_SIZE=$(bc <<<"scale=0;$cols/16") 2>/dev/null 
# -------------------------------------------------------------------- 
DISPLAY=:0.0 xterm -fullscreen -bg black -fa "Monospace" -fs $TEXT_SIZE -e bash -c "batocera-pro-rpcs3updater" 2>/dev/null 
# -------------------------------------------------------------------- 
if [[ "$(cat /userdata/system/pro/rpcs3/extra/installation.txt | tail -n 1)" = "done" ]]; then 
clear 
echo 
echo 
echo -e "${L}-------------------------------------------------------" 
echo -e "${G}> NEW RPCS3 INSTALLED OK ${W}" 
echo -e "${L}-------------------------------------------------------" 
echo 
echo 
rm -rf /userdata/system/pro/rpcs3/extra/installation.txt 2>/dev/null 
fi 
# --------------------------------------------------------------------
# BATOCERA.PRO INSTALLER // 
########################## 
exit 0 