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
APPNAME=heroic
APPLINK=$(curl -s https://api.github.com/repos/Heroic-Games-Launcher/HeroicGamesLauncher/releases | grep AppImage | grep "browser_download_url" | head -n 1 | sed 's,^.*https://,https://,g' | cut -d \" -f1)
APPHOME="github.com/Heroic-Games-Launcher" 
#---------------------------------------------------------------------
#       DEFINE LAUNCHER COMMAND >>
#COMMAND='mkdir /userdata/system/pro/'$APPNAME'/home 2>/dev/null; mkdir /userdata/system/pro/'$APPNAME'/config 2>/dev/null; mkdir /userdata/system/pro/'$APPNAME'/roms 2>/dev/null; LD_LIBRARY_PATH="/userdata/system/pro/.dep:${LD_LIBRARY_PATH}" HOME=/userdata/system/pro/'$APPNAME'/home XDG_CONFIG_HOME=/userdata/system/pro/'$APPNAME'/config QT_SCALE_FACTOR="1" GDK_SCALE="1" XDG_DATA_HOME=/userdata/system/pro/'$APPNAME'/home DISPLAY=:0.0 /userdata/system/pro/'$APPNAME'/'$APPNAME'.AppImage --no-sandbox --disable-gpu "$1" "$2" "$3" "$4" "$5" "$6" "$7" "$8" "$9"'
COMMAND='LD_LIBRARY_PATH="/userdata/system/pro/.dep:${LD_LIBRARY_PATH}" DISPLAY=:0.0 /userdata/system/pro/'$APPNAME'/'$APPNAME'.AppImage --no-sandbox --disable-gpu "$1" "$2" "$3" "$4" "$5" "$6" "$7" "$8" "$9"'
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
echo -e "${X}PREPARING $APPNAME INSTALLER, PLEASE WAIT . . . ${X}"
echo
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
mkdir $pro/$appname 2>/dev/null
mkdir $pro/$appname/extra 2>/dev/null
# --------------------------------------------------------------------
# -- pass launcher command as cookie for main function: 
command=$pro/$appname/extra/command; rm $command 2>/dev/null;
echo "$COMMAND" >> $command 2>/dev/null 
# --------------------------------------------------------------------
# -- prepare dependencies for this app and the installer: 
mkdir -p ~/pro/.dep 2>/dev/null && cd ~/pro/.dep && wget --tries=10 --no-check-certificate --no-cache --no-cookies -q -O ~/pro/.dep/dep.zip https://github.com/uureel/batocera.pro/raw/main/.dep/dep.zip && yes "y" | unzip -oq ~/pro/.dep/dep.zip && cd ~/
wget --tries=10 --no-check-certificate --no-cache --no-cookies -q -O $pro/$appname/extra/icon.png https://github.com/uureel/batocera.pro/raw/main/$appname/extra/icon.png; chmod a+x $dep/* 2>/dev/null; cd ~/
for file in /userdata/system/pro/.dep/lib*; do sudo ln -s "$file" "/usr/lib/$(basename $file)"; done
# --------------------------------------------------------------------
# // end of dependencies 
#
# --------------------------------------------------------------------
# -- run before installer:  
killall wget 2>/dev/null && killall $AppName 2>/dev/null && killall $AppName 2>/dev/null && killall $AppName 2>/dev/null
# --------------------------------------------------------------------
cols=$($dep/tput cols); rm -rf /userdata/system/pro/$appname/extra/cols
echo $cols >> /userdata/system/pro/$appname/extra/cols
line(){
echo 1>/dev/null
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
line $cols '-'; echo
echo -e "${X}BATOCERA.PRO/$APPNAME INSTALLER${X}"
line $cols '-'; echo
echo
echo
echo
sleep 0.33
clear
echo
line $cols '-'; echo
line $cols ' '; echo
echo -e "${X}BATOCERA.PRO/$APPNAME INSTALLER${X}"
line $cols ' '; echo
line $cols '-'; echo
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
echo -e "${X}THIS WILL INSTALL HEROIC-LAUNCHER FOR BATOCERA"
echo -e "${X}USING $ORIGIN"
echo
echo -e "${X}$APPNAME WILL BE AVAILABLE IN PORTS"
echo -e "${X}AND ALSO IN THE F1->APPLICATIONS MENU"
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
echo 1>/dev/null
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
line $cols '-'; echo
echo -e "${W}BATOCERA.PRO/${G}$APPNAME${W} INSTALLER ${W}"
line $cols '-'; echo
echo
echo
echo
sleep 0.33
clear
echo
line $cols '-'; echo
echo; #line $cols '-'; echo
echo -e "${W}BATOCERA.PRO/${W}$APPNAME${W} INSTALLER ${W}"
echo; #line $cols '-'; echo
line $cols '-'; echo
echo
echo
sleep 0.33
clear
line $cols '='; echo
echo; #line $cols '-'; echo
echo; #line $cols '-'; echo
echo -e "${W}BATOCERA.PRO/${G}$APPNAME${W} INSTALLER ${W}"
echo; #line $cols '-'; echo
echo; #line $cols '-'; echo
line $cols '='; echo
echo
sleep 0.33
echo -e "${W}THIS WILL INSTALL HEROIC-LAUNCHER FOR BATOCERA"
echo -e "${W}USING $ORIGIN"
echo
echo -e "${W}$APPNAME WILL BE AVAILABLE IN PORTS"
echo -e "${W}AND ALSO IN THE F1->APPLICATIONS MENU"
echo -e "${W}AND INSTALLED IN /USERDATA/SYSTEM/PRO/$APPNAME"
echo
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
temp=/userdata/system/pro/$appname/extra/downloads
rm -rf $temp 2>/dev/null
mkdir -p $temp 2>/dev/null
# --------------------------------------------------------------------
echo -e "${G}DOWNLOADING${W} HEROIC LAUNCHER"
sleep 1
echo -e "${T}$APPLINK" | sed 's,https://,> ,g' | sed 's,http://,> ,g' 2>/dev/null
cd $temp
script -q -c "curl --progress-bar --remote-name --location "$APPLINK"" /dev/null
cd ~/
mv $temp/* $APPPATH 2>/dev/null
chmod a+x $APPPATH 2>/dev/null
rm -rf $temp/*.AppImage
SIZE=$(($(wc -c $APPPATH | awk '{print $1}')/1048576)) 2>/dev/null
echo -e "${T}$APPPATH   ${T}$SIZE( )MB   ${G}OK${W}" | sed 's/( )//g'
#echo -e "${G}> ${W}DONE"
echo
echo; #line $cols '='; echo
sleep 1.333
# --------------------------------------------------------------------
echo -e "${G}DOWNLOADING${W} PROTON-GE-7.42 [3/3]"
sleep 1
echo -e "${T}https://github.com/uureel/batocera.pro/raw/main/heroic/extra/Proton-GE-Proton7-42.tar.xz" | sed 's,https://,> ,g' | sed 's,http://,> ,g' 2>/dev/null
cd $temp
p1=https://github.com/uureel/batocera.pro/raw/main/heroic/extra/Proton-GE-Proton7-42.tar.xz.partaa
p2=https://github.com/uureel/batocera.pro/raw/main/heroic/extra/Proton-GE-Proton7-42.tar.xz.partab
p3=https://github.com/uureel/batocera.pro/raw/main/heroic/extra/Proton-GE-Proton7-42.tar.xz.partac
curl --progress-bar --remote-name --location "$p1"
curl --progress-bar --remote-name --location "$p2"
curl --progress-bar --remote-name --location "$p3"
cat $temp/Proton-GE-Proton7-42.tar.xz.parta* >$temp/Proton-GE-Proton7-42.tar.xz
mkdir -p /userdata/system/.config/heroic/tools/proton 2>/dev/null
cp -rL $temp/Proton-GE-Proton7-42.tar.xz /userdata/system/.config/heroic/tools/proton/Proton-GE-Proton7-42.tar.xz 2>/dev/null
SIZE=$(($(wc -c /userdata/system/.config/heroic/tools/proton/Proton-GE-Proton7-42.tar.xz | awk '{print $1}')/1048576)) 2>/dev/null
echo -e "${T}PROTON-GE-7.42   ${T}$SIZE( )MB   ${G}OK${W}" | sed 's/( )//g'
#echo -e "${G}> ${W}DONE"
echo
echo; #line $cols '='; echo
sleep 1.333
# --------------------------------------------------------------------
echo -e "${G}INSTALLING${W}"
# --------------------------------------------------------------------
cd ~/
# --------------------------------------------------------------------
# prepare dependencies
cp /userdata/system/pro/.dep/libselinux.so.1 /lib/libselinux.so.1 2>/dev/null
cp /userdata/system/pro/.dep/tar /bin/tar 2>/dev/null
chmod a+x /bin/tar 2>/dev/null
chmod a+x ~/pro/.dep/* 2>/dev/null
# --------------------------------------------------------------------
# unpack proton
cd /userdata/system/.config/heroic/tools/proton
tar -xf /userdata/system/.config/heroic/tools/proton/Proton-GE-Proton7-42.tar.xz
sleep 0.1
rm -rf /userdata/system/.config/heroic/tools/proton/Proton-GE-Proton7-42.tar.xz 2>/dev/null
rm -rf $temp/* 2>/dev/null
# --------------------------------------------------------------------
# get heroic-sync.sh 
wget -q -O /userdata/system/pro/$appname/extra/heroic-sync.sh https://raw.githubusercontent.com/uureel/batocera.pro/main/heroic/extra/heroic-sync.sh
dos2unix /userdata/system/pro/$appname/extra/heroic-sync.sh 2>/dev/null
chmod a+x /userdata/system/pro/$appname/extra/heroic-sync.sh 2>/dev/null
# --------------------------------------------------------------------
# -- prepare launcher to solve dependencies on each run and avoid overlay, 
launcher=/userdata/system/pro/$appname/Launcher
rm -rf $launcher
echo '#!/bin/bash ' >> $launcher
echo " cp /userdata/system/pro/.dep/libselinux.so.1 /lib/libselinux.so.1 2>/dev/null" >> $launcher
echo " cp /userdata/system/pro/.dep/tar /bin/tar 2>/dev/null" >> $launcher
echo '/userdata/system/pro/'$appname'/extra/heroic-sync.sh' >> $launcher
echo 'unclutter-remote -s' >> $launcher
## -- GET APP SPECIFIC LAUNCHER COMMAND: 
######################################################################
echo "$(cat /userdata/system/pro/$appname/extra/command)" >> $launcher
######################################################################
dos2unix $launcher
chmod a+x $launcher
rm /userdata/system/pro/$appname/extra/command 2>/dev/null
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
# -- prepare SystemLauncher for integration, 
sl=/userdata/system/pro/$appname/SystemLauncher
rm -rf $sl 2>/dev/null
echo '#!/bin/bash ' >> $sl
echo "#FILE=\$(echo "\"\$\1\"" | sed 's,\s,\ ,g')" >> $sl
echo '#ID=$(cat $FILE)' >> $sl
echo 'ID=$(cat "$1" | head -n 1)' >> $sl
echo " cp /userdata/system/pro/.dep/libselinux.so.1 /lib/libselinux.so.1 2>/dev/null" >> $sl
echo " cp /userdata/system/pro/.dep/tar /bin/tar 2>/dev/null" >> $sl
echo '/userdata/system/pro/'$appname'/extra/heroic-sync.sh' >> $sl
echo 'unclutter-remote -s' >> $sl
echo 'mkdir /userdata/system/pro/'$appname'/home 2>/dev/null' >> $sl
echo 'mkdir /userdata/system/pro/'$appname'/config 2>/dev/null' >> $sl
echo 'mkdir /userdata/system/pro/'$appname'/roms 2>/dev/null' >> $sl
echo 'HOME=/userdata/system/pro/'$appname'/home \' >> $sl
echo 'XDG_DATA_HOME=/userdata/system/pro/'$appname'/home \' >> $sl
echo 'XDG_CONFIG_HOME=/userdata/system/pro/'$appname'/config \' >> $sl
echo 'LD_LIBRARY_PATH="/userdata/system/pro/.dep:${LD_LIBRARY_PATH}" DISPLAY=:0.0 /userdata/system/pro/'$appname'/'$appname'.AppImage --no-sandbox --no-gui --disable-gpu "heroic://launch/$ID"' >> $sl
dos2unix $sl 
chmod a+x $sl 
# --------------------------------------------------------------------
# -- get es_systems_heroic.cfg for integration, 
wget -q -O $pro/$appname/es_systems_heroic.cfg https://github.com/uureel/batocera.pro/raw/main/$appname/extra/es_systems_heroic.cfg
dos2unix $pro/$appname/es_systems_heroic.cfg
cp $pro/$appname/es_systems_heroic.cfg /userdata/system/configs/emulationstation/es_systems_heroic.cfg 2>/dev/null
# -- create example rom, 
mkdir -p /userdata/roms/heroic 2>/dev/null
wget -q -O "/userdata/roms/heroic/Fall Guys.txt" "https://github.com/uureel/batocera.pro/raw/main/$appname/extra/FallGuys.txt"
dos2unix "/userdata/roms/heroic/Fall Guys.txt" 2>/dev/null
# --------------------------------------------------------------------
# -- prepare Ports file, 
portname=Heroic
version=$(echo $APPLINK | sed 's,^.*'$portname'-,,g' | sed 's,.AppImage,,g')
port=/userdata/system/pro/$appname/$portname.sh
rm -rf $port 2>/dev/null
echo '#!/bin/bash ' >> $port
echo " cp /userdata/system/pro/.dep/libselinux.so.1 /lib/libselinux.so.1 2>/dev/null" >> $port
echo " cp /userdata/system/pro/.dep/tar /bin/tar 2>/dev/null" >> $port
echo '/userdata/system/pro/'$appname'/extra/heroic-sync.sh' >> $port
echo 'unclutter-remote -s' >> $port
echo 'mkdir /userdata/system/pro/'$appname'/home 2>/dev/null' >> $port
echo 'mkdir /userdata/system/pro/'$appname'/config 2>/dev/null' >> $port
echo 'mkdir /userdata/system/pro/'$appname'/roms 2>/dev/null' >> $port
echo 'HOME=/userdata/system/pro/'$appname'/home \' >> $port
echo 'XDG_DATA_HOME=/userdata/system/pro/'$appname'/home \' >> $port
echo 'XDG_CONFIG_HOME=/userdata/system/pro/'$appname'/config \' >> $port
echo 'QT_SCALE_FACTOR="1" GDK_SCALE="1" \' >> $port
echo 'LD_LIBRARY_PATH="/userdata/system/pro/.dep:${LD_LIBRARY_PATH}" DISPLAY=:0.0 /userdata/system/pro/'$appname'/'$appname'.AppImage --no-sandbox --disable-gpu' >> $port
dos2unix $port 
chmod a+x $port 
ports=/userdata/roms/ports 
if [[ -e "$ports/$portname.sh" ]]; 
then 
  if [[ "$(cat "$ports/$portname.sh" | grep "/userdata/system/pro/$appname" | tail -n 1)" != "" ]]; 
  then 
  cp $port "$ports/$portname.sh"
  else
  cp $port "$ports/$portname $version.sh";
  fi
else cp $port "$ports/$portname.sh"; 
fi
# --------------------------------------------------------------------
# -- prepare prelauncher to avoid overlay,
pre=/userdata/system/pro/$appname/extra/startup
rm -rf $pre 2>/dev/null
echo "#!/usr/bin/env bash" >> $pre
echo "cp /userdata/system/pro/$appname/extra/$appname.desktop /usr/share/applications/ 2>/dev/null" >> $pre
echo "cp /userdata/system/pro/.dep/libselinux.so.1 /lib/libselinux.so.1 2>/dev/null" >> $pre
echo "cp /userdata/system/pro/.dep/tar /bin/tar 2>/dev/null" >> $pre
dos2unix $pre
chmod a+x $pre
/userdata/system/pro/$appname/extra/startup
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
echo; #line $cols '='; echo
echo -e "${W}> $APPNAME INSTALLED ${G}OK${W}"
line $cols '='; echo
echo "1" >> /userdata/system/pro/$appname/extra/status 2>/dev/null
sleep 3
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
function autostart() {
  csh="/userdata/system/custom.sh"
  pcsh="/userdata/system/pro-custom.sh"
  pro="/userdata/system/pro"
  rm -f $pcsh
  temp_file=$(mktemp)
  find $pro -type f \( -path "*/extra/startup" -o -path "*/extras/startup.sh" \) > $temp_file
  echo "#!/bin/bash" > $pcsh
  sort $temp_file >> $pcsh
  rm $temp_file
  chmod a+x $pcsh
  temp_csh=$(mktemp)
  grep -vxFf $pcsh $csh > $temp_csh
  mapfile -t lines < $temp_csh
  if [[ "${lines[0]}" != "#!/bin/bash" ]]; then
    lines=( "#!/bin/bash" "${lines[@]}" )
  fi
  if ! grep -Fxq "$pcsh &" $temp_csh; then
    lines=( "${lines[0]}" "$pcsh &" "${lines[@]:1}" )
  fi
  printf "%s\n" "${lines[@]}" > $csh
  chmod a+x $csh
  rm $temp_csh
}
export -f autostart
autostart
exit 0
