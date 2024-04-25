#!/usr/bin/env bash 
######################################################################
# BATOCERA.PRO/DISCORD INSTALLER
######################################################################
# --------------------------------------------------------------------
# --------------------------------------------------------------------
# --------------------------------------------------------------------
APPNAME=DISCORD # for installer info
appname=discord # directory name /userdata/system/pro/...
APPPATH=/userdata/system/pro/discord/Discord.AppImage
APPLINK=$(curl -s https://api.github.com/repos/srevinsaju/discord-appimage/releases | grep "download/ptb" | grep AppImage | grep "browser_download_url" | awk '{print $2}' | sed 's,",,g' | head -n1)
ORIGIN=GITHUB.COM/SREVINSAJU/DISCORD-APPIMAGE # credit & info 
# --------------------------------------------------------------------
killall -9 discord Discord discord.AppImage Discord.AppImage DiscordPTB 2>/dev/null
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
mkdir -p ~/pro/.dep 2>/dev/null && cd ~/pro/.dep && wget --tries=10 --no-check-certificate --no-cache --no-cookies -q -O ~/pro/.dep/dep.zip https://github.com/uureel/batocera.pro/raw/main/.dep/dep.zip && yes "y" | unzip -oq ~/pro/.dep/dep.zip && cd ~/
wget --tries=10 --no-check-certificate --no-cache --no-cookies -q -O $pro/$appname/extra/icon.png https://github.com/uureel/batocera.pro/raw/main/$appname/extra/icon.png; chmod a+x $dep/* 2>/dev/null; cd ~/
chmod 777 ~/pro/.dep/* && for file in /userdata/system/pro/.dep/lib*; do sudo ln -s "$file" "/usr/lib/$(basename $file)"; done
# --------------------------------------------------------------------
# // end of dependencies 
# --------------------------------------------------------------------
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
#/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
#
# THIS WILL BE SHOWN ON MAIN BATOCERA DISPLAY:   
function batocera-pro-installer {
APPNAME="$1"
appname="$2"
APPPATH="$3"
APPLINK="$4"
ORIGIN="$5"
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
# get latest appimage version:
echo
echo -e "${G}DOWNLOADING${W} $APPNAME . . ."
sleep 1
echo -e "${T}$APPLINK" | sed 's,https://,> ,g' | sed 's,http://,> ,g' 2>/dev/null
cd $temp
curl --progress-bar --remote-name --location "$APPLINK"
chmod 777 $temp/*.AppImage 2>/dev/null
$temp/*.AppImage --appimage-extract 1>/dev/null 2>/dev/null
rm $temp/*.AppImage 2>/dev/null
mv $temp/squashfs-root $temp/discord
a=$temp/discord/AppRun
f=$temp/discord/discord
rm $f 2>/dev/null
nr=$(cat "$a" | wc -l) && n=1
while [[ "$n" -le "$nr" ]]; do
  l=$(cat "$a" | sed ''$n'q;d')
    if [[ "$(echo "$l" | grep 'set -e')" != "" ]]; then
      echo 'set -e' >> "$f"
      echo 'export DBUS_SESSION_BUS_ADDRESS=unix:path=/run/dbus/system_bus_socket' >> "$f"
      echo 'export XDG_MENU_PREFIX=batocera-' >> "$f"
      echo 'export XDG_CONFIG_DIRS=/etc/xdg' >> "$f"
      echo 'export XDG_CURRENT_DESKTOP=XFCE' >> "$f"
      echo 'export DESKTOP_SESSION=XFCE' >> "$f"
    else
      echo "$l" >> "$f"
    fi
  n=$(($n+1))
done
dos2unix "$f" 2>/dev/null
chmod 777 "$f" 2>/dev/null
cp -r $temp/discord ~/pro/$appname/ 2>/dev/null
rm -rf $temp/* 2>/dev/null
cd $HOME
#
# get latest official version
rm -rf $temp/* 2>/dev/null
mkdir -p $temp 2>/dev/null
n=81
f=0
while [[ "$f" = "0" ]]; 
do
  APPLINK="https://dl-ptb.discordapp.net/apps/linux/0.0.$n/discord-ptb-0.0.$n.tar.gz"
  r=$(curl -sI "$APPLINK")
  if [[ "$(echo "$r" | grep 'HTTP/2 200')" != "" ]]; then
    n=$(($n + 1))
  fi
    if [[ "$(echo "$r" | grep 'HTTP/2 403')" != "" ]]; then
      n=$(($n - 1))
      APPLINK="https://dl-ptb.discordapp.net/apps/linux/0.0.$n/discord-ptb-0.0.$n.tar.gz"
      echo "> $APPLINK"
      f=1
      break
    fi
if [[ "$f" = "1" ]]; then break; fi
done
cd $temp
curl --progress-bar --remote-name --location "$APPLINK"
LD_LIBRARY_PATH="/userdata/system/pro/.dep:${LD_LIBRARY_PATH}" /userdata/system/pro/.dep/tar -xf $temp/*.tar.gz
rm -rf $temp/*.tar.gz
mv $temp/* $temp/discordapp
cp -r $temp/discordapp/* ~/pro/$appname/discord/
rm -rf $temp/*
cd $HOME
#
#
SIZE=$(du -h ~/pro/$appname | tail -n1 | awk '{print $1}')
echo -e "${T}  /userdata/system/pro/$appname  ${T}$SIZE( )" | sed 's/( )//g'
echo -e "${G}> ${W}DONE"
echo
echo -e "${L}- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -"
#
# --------------------------------------------------------------------
#
echo
echo -e "${G}INSTALLING ${W}. . ."
# -- prepare launcher to solve dependencies on each run and avoid overlay, 
launcher=/userdata/system/pro/$appname/Launcher
rm -rf $launcher
echo '#!/bin/bash ' >> $launcher
echo 'unclutter-remote -s' >> $launcher
## -- APP SPECIFIC LAUNCHER COMMAND: 
######################################################################
######################################################################
###################################################################### 
######################################################################
######################################################################
echo 'if [ "$(pidof Discord)" != "" ]; then killall Discord 2>/dev/null && killall Discord 2>/dev/null && killall Discord 2>/dev/null; fi' >> $launcher
echo 'DISPLAY=:0.0 LD_LIBRARY_PATH="/userdata/system/pro/.dep:${LD_LIBRARY_PATH}" /userdata/system/pro/discord/discord/discord --no-sandbox --test-type "${@}"' >> $launcher
#echo 'DISPLAY=:0.0 QT_SCALE_FACTOR=1.50 GDK_SCALE=1.50 DISPLAY=:0.0 /userdata/system/pro/discord/Discord.AppImage --no-sandbox &' >> $launcher
######################################################################
######################################################################
######################################################################
######################################################################
######################################################################
dos2unix $launcher
chmod a+x $launcher
# //
# -- prepare f1 - applications - app shortcut, 
shortcut=/userdata/system/pro/$appname/extra/$appname.desktop
rm -rf $shortcut 2>/dev/null
echo "[Desktop Entry]" >> $shortcut
echo "Version=1.0" >> $shortcut
echo "Icon=/userdata/system/pro/$appname/extra/icon.png" >> $shortcut
echo "Exec=/userdata/system/pro/$appname/Launcher %U" >> $shortcut
echo "Terminal=false" >> $shortcut
echo "Type=Application" >> $shortcut
echo "Categories=Game;batocera.linux;" >> $shortcut
echo "Name=$appname" >> $shortcut
f1shortcut=/usr/share/applications/$appname.desktop
dos2unix $shortcut
chmod a+x $shortcut
cp $shortcut $f1shortcut 2>/dev/null
# //
#
# -- prepare prelauncher to avoid overlay and start discord minimized on system launch,
pre=/userdata/system/pro/$appname/extra/startup
rm -rf $pre 2>/dev/null
echo "#!/usr/bin/env bash" >> $pre
echo "cp /userdata/system/pro/$appname/extra/$appname.desktop /usr/share/applications/ 2>/dev/null" >> $pre
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
dos2unix $csh 2>/dev/null
# //
#
# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
# PATCHES FOR CHOSEN APPS: 
# =================================================================================
# DISCORD PATCH FOR BATOCERA-SWITCH / YUZU
file=/userdata/system/switch/configgen/generators/yuzu/yuzuMainlineGenerator.py
text="enable_discord_presence"
if [[ -e "$file" ]]; then
temp=/userdata/system/switch/configgen/generators/yuzu/yuzuMainlineGenerator_tmp.py
rm $temp 2>/dev/null
nl=$(cat $file | wc -l)
l=1; while [[ $l -le $nl ]]; do
ln=$(cat $file | sed ""$l"q;d")
if [[ "$(echo $ln | grep "$text")" != "" ]]; then echo "#$ln" >> $temp; else echo "$ln" >> $temp; fi
((l++))
done
timestamp=$(date +"%y%m%d-%H%M%S")
mv $file $file-backup$timestamp 2>/dev/null
mv $temp $file 2>/dev/null
fi
# =================================================================================
# DISCORD PATCH FOR BATOCERA-SWITCH / RYUJINX 
file=/userdata/system/switch/configgen/generators/ryujinx/ryujinxMainlineGenerator.py
text="enable_discord_integration"
if [[ -e "$file" ]]; then
temp=/userdata/system/switch/configgen/generators/ryujinx/ryujinxMainlineGenerator_tmp.py
rm $temp 2>/dev/null
nl=$(cat $file | wc -l)
l=1; while [[ $l -le $nl ]]; do
ln=$(cat $file | sed ""$l"q;d")
if [[ "$(echo $ln | grep "$text")" != "" ]]; then echo "#$ln" >> $temp; else echo "$ln" >> $temp; fi
((l++))
done
timestamp=$(date +"%y%m%d-%H%M%S")
mv $file $file-backup$timestamp 2>/dev/null
mv $temp $file 2>/dev/null
fi
# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
# -- done. 
echo -e "${G}> ${W}DONE"
echo
echo -e "${L}-----------------------------------------------------------------------"
echo -e "${W}> $APPNAME INSTALLED ${G}OK"
echo -e "${L}-----------------------------------------------------------------------"
}
export -f batocera-pro-installer
# --------------------------------------------------------------------
# RUN:
  batocera-pro-installer "$APPNAME" "$appname" "$APPPATH" "$APPLINK" "$ORIGIN"
# --------------------------------------------------------------------
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
