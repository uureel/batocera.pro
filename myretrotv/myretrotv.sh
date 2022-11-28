#!/usr/bin/env bash 
######################################################################
# BATOCERA.PRO/CHROME INSTALLER
######################################################################
# --------------------------------------------------------------------
# --------------------------------------------------------------------
# --------------------------------------------------------------------
APPNAME=CHROME # for installer info
appname=chrome # directory name in /userdata/system/pro/...
AppName=Chrome # App.AppImage name
APPPATH="/userdata/system/pro/chrome/Chrome.AppImage"
APPLINK="https://apprepo.de/appimage/download/google-chrome"
ORIGIN="@JOEYCATO'S MYRETROTV"                          # credit & info
# --------------------------------------------------------------------
# --------------------------------------------------------------------
# --------------------------------------------------------------------
# --------------------------------------------------------------------
# show console/ssh info: 
clear
echo
echo
echo
echo -e "${X}PREPARING MYRETROTV INSTALLER. . . ${X}"
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
#url=https://github.com/uureel/batocera.pro/raw/main/.dep
#depfile=dependencies.txt; dep=$pro/.dep; mkdir $pro/.dep 2>/dev/null; cd $dep
#wget -q -O $dep/$depfile $url/$depfile 2>/dev/null; dos2unix $dep/$depfile;
#nl=$(cat $dep/$depfile | wc -l); l=1; while [[ "$l" -le "$((nl+2))" ]]; do
#d=$(cat $dep/$depfile | sed ""$l"q;d"); wget -q -O $dep/$d $url/$d 2>/dev/null; 
#if [[ "$(echo $d | grep "lib")" != "" ]]; then ln -s $dep/$d /lib/$d 2>/dev/null; fi; ((l++)); done
#wget -q -O $pro/$appname/extra/icon.png https://github.com/uureel/batocera.pro/raw/main/$appname/extra/icon.png; chmod a+x $dep/tput; cd ~/
# --------------------------------------------------------------------
# // end of dependencies 
#
# RUN BEFORE INSTALLER: 
######################################################################
#killall wget 2>/dev/null && killall $AppName 2>/dev/null && killall $AppName 2>/dev/null && killall $AppName 2>/dev/null
######################################################################
#
# --------------------------------------------------------------------
# show console/ssh info: 
clear
echo
echo
echo
echo -e "${X}BATOCERA.PRO/MYRETROTV INSTALLER${X}"
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
echo -e "${X}BATOCERA.PRO/MYRETROTV INSTALLER${X}"
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
echo -e "${X}BATOCERA.PRO/MYRETROTV INSTALLER${X}"
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
echo -e "${X}BATOCERA.PRO/MYRETROTV INSTALLER${X}"
echo -e "${X}--------------------------------------------------------"
echo -e "${X}--------------------------------------------------------"
echo -e "${X}--------------------------------------------------------"
echo
# --------------------------------------------------------------------
sleep 0.33
echo -e "${X}THIS WILL INSTALL MYRETROTV FOR BATOCERA"
echo -e "${X}USING GOOGLE CHROME BROWSER "
echo -e "${X}& $ORIGIN "
echo
echo -e "${X}MYRETROTV AND CHROME WILL BE AVAILABLE IN PORTS "
echo -e "${X}AND ALSO IN THE F1->APPLICATIONS MENU"
echo -e "${X}AND INSTALLED INTO /USERDATA/SYSTEM/PRO/$APPNAME"
echo
echo -e "${X}PAD2KEY PROFILES ARE INCLUDED"
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
function batoceraproinstaller {
APPNAME=CHROME # for installer info
appname=chrome # directory name in /userdata/system/pro/...
AppName=Chrome # App.AppImage name
APPPATH="/userdata/system/pro/chrome/Chrome.AppImage"
APPLINK="https://apprepo.de/appimage/download/google-chrome"
ORIGIN="@JOEYCATO'S MYRETROTV" # credits
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
echo -e "${W}BATOCERA.PRO/${G}MYRETROTV${W} INSTALLER ${W}"
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
echo -e "${W}BATOCERA.PRO/${W}MYRETROTV${W} INSTALLER ${W}"
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
echo -e "${W}BATOCERA.PRO/${G}MYRETROTV${W} INSTALLER ${W}"
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
echo -e "${W}BATOCERA.PRO/${W}MYRETROTV${W} INSTALLER ${W}"
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
echo -e "${W}BATOCERA.PRO/${G}MYRETROTV${W} INSTALLER ${W}"
echo -e "${L}-----------------------------------------------------------------------"
echo -e "${L}-----------------------------------------------------------------------"
echo -e "${L}-----------------------------------------------------------------------"
echo
# --------------------------------------------------------------------
sleep 0.33
echo -e "${W}THIS WILL INSTALL MYRETROTV FOR BATOCERA"
echo -e "${W}USING GOOGLE CHROME BROWSER "
echo -e "${W}& $ORIGIN "
echo
echo -e "${W}MYRETROTV AND CHROME WILL BE AVAILABLE IN PORTS "
echo -e "${W}AND ALSO IN THE F1->APPLICATIONS MENU"
echo -e "${W}AND INSTALLED INTO /USERDATA/SYSTEM/PRO/$APPNAME"
echo 
echo -e "${W}PAD2KEY PROFILES ARE INCLUDED"
echo 
#echo -e "${G}> > > ${W}PRESS ENTER TO CONTINUE"
#read -p ""
sleep 4
echo -e "${L}- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -"
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
#
# -- temp for curl download
temp=/userdata/system/pro/$appname/extra/downloads
rm -rf $temp 2>/dev/null
mkdir $temp 2>/dev/null
#
# --------------------------------------------------------------------
#
echo
echo -e "${G}DOWNLOADING${W} GOOGLE-CHROME . . ."
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
echo -e "${G}INSTALLING${W} CHROME & MYRETROTV . . ."
# -- prepare google-chrome launcher, 
launcher=/userdata/system/pro/$appname/Launcher
rm -rf $launcher
echo '#!/bin/bash ' >> $launcher
echo ' dep=/userdata/system/pro/.dep; depfile=$dep/dependencies.txt; ' >> $launcher
echo ' nl=$(cat $depfile | wc -l); l=1; while [[ "$l" -le "$((nl+2))" ]]; do ' >> $launcher
echo ' d=$(cat $depfile | sed ""$l"q;d"); if [[ "$(echo $d | grep "lib")" != "" ]]; then ' >> $launcher
echo ' cp $dep/$d /lib/$d 2>/dev/null; fi; ((l++)); done ' >> $launcher
echo 'unclutter-remote -s; killall -9 chrome' >> $launcher
echo 'mkdir /userdata/system/pro/'$appname'/home 2>/dev/null; mkdir /userdata/system/pro/'$appname'/config 2>/dev/null; DISPLAY=:0.0 HOME=/userdata/system/pro/'$appname'/home XDG_CONFIG_HOME=/userdata/system/pro/'$appname'/config /userdata/system/pro/'$appname'/'$AppName'.AppImage "$1" "$2" "$3" "$4" "$5" "$6" "$7" "$8" "$9" --start-fullscreen --no-sandbox' >> $launcher
dos2unix $launcher
chmod a+x $launcher
# //
# -- prepare myretrotvs launcher, 
#launcher=/userdata/system/pro/$appname/MyRetroTVs.sh
#rm -rf $launcher
#echo '#!/bin/bash ' >> $launcher
#echo 'unclutter-remote -s ' >> $launcher
#echo '/userdata/system/pro/'$appname'/Launcher my00stv.com my90stv.com my80stv.com my70stv.com my60stv.com' >> $launcher
#dos2unix $launcher; chmod a+x $launcher; cp $launcher /userdata/roms/ports/ 2>/dev/null
# //
# -- prepare myretrotvs launcher, 
launcher=/userdata/system/pro/$appname/My00sTV.sh
rm -rf $launcher
echo '#!/bin/bash ' >> $launcher
echo 'unclutter-remote -s ' >> $launcher
echo '/userdata/system/pro/'$appname'/Launcher my00stv.com' >> $launcher
dos2unix $launcher; chmod a+x $launcher; cp $launcher /userdata/roms/ports/ 2>/dev/null
# //
# -- prepare myretrotvs launcher, 
launcher=/userdata/system/pro/$appname/My90sTV.sh
rm -rf $launcher
echo '#!/bin/bash ' >> $launcher
echo 'unclutter-remote -s ' >> $launcher
echo '/userdata/system/pro/'$appname'/Launcher my90stv.com' >> $launcher
dos2unix $launcher; chmod a+x $launcher; cp $launcher /userdata/roms/ports/ 2>/dev/null
# //
# -- prepare myretrotvs launcher, 
launcher=/userdata/system/pro/$appname/My80sTV.sh
rm -rf $launcher
echo '#!/bin/bash ' >> $launcher
echo 'unclutter-remote -s ' >> $launcher
echo '/userdata/system/pro/'$appname'/Launcher my80stv.com' >> $launcher
dos2unix $launcher; chmod a+x $launcher; cp $launcher /userdata/roms/ports/ 2>/dev/null
# //
# -- prepare myretrotvs launcher, 
launcher=/userdata/system/pro/$appname/My70sTV.sh
rm -rf $launcher
echo '#!/bin/bash ' >> $launcher
echo 'unclutter-remote -s ' >> $launcher
echo '/userdata/system/pro/'$appname'/Launcher my70stv.com' >> $launcher
dos2unix $launcher; chmod a+x $launcher; cp $launcher /userdata/roms/ports/ 2>/dev/null
# //
# -- prepare myretrotvs launcher, 
launcher=/userdata/system/pro/$appname/My60sTV.sh
rm -rf $launcher
echo '#!/bin/bash ' >> $launcher
echo 'unclutter-remote -s ' >> $launcher
echo '/userdata/system/pro/'$appname'/Launcher my60stv.com' >> $launcher
dos2unix $launcher; chmod a+x $launcher; cp $launcher /userdata/roms/ports/ 2>/dev/null
# //
# -- get assets: 
icon=/userdata/system/pro/$appname/extra/icon.png
rm -rf /userdata/system/pro/$appname/extra/chrome.png
rm -rf /userdata/system/pro/$appname/extra/myretrotvs.png
rm -rf /userdata/system/pro/$appname/extra/my00stv.png
rm -rf /userdata/system/pro/$appname/extra/my90stv.png
rm -rf /userdata/system/pro/$appname/extra/my80stv.png
rm -rf /userdata/system/pro/$appname/extra/my70stv.png
rm -rf /userdata/system/pro/$appname/extra/my60stv.png
rm -rf /userdata/system/pro/$appname/extra/myretrotv.sh.keys
# 
wget -q -O $icon https://github.com/uureel/batocera.pro/raw/main/$appname/extra/icon.png
wget -q -O /userdata/system/pro/$appname/extra/chrome.png https://github.com/uureel/batocera.pro/raw/main/myretrotv/extra/chrome.png
wget -q -O /userdata/system/pro/$appname/extra/myretrotvs.png https://github.com/uureel/batocera.pro/raw/main/myretrotv/extra/myretrotvs.png
wget -q -O /userdata/system/pro/$appname/extra/my00stv.png https://github.com/uureel/batocera.pro/raw/main/myretrotv/extra/my00stv.png
wget -q -O /userdata/system/pro/$appname/extra/my90stv.png https://github.com/uureel/batocera.pro/raw/main/myretrotv/extra/my90stv.png
wget -q -O /userdata/system/pro/$appname/extra/my80stv.png https://github.com/uureel/batocera.pro/raw/main/myretrotv/extra/my80stv.png
wget -q -O /userdata/system/pro/$appname/extra/my70stv.png https://github.com/uureel/batocera.pro/raw/main/myretrotv/extra/my70stv.png
wget -q -O /userdata/system/pro/$appname/extra/my60stv.png https://github.com/uureel/batocera.pro/raw/main/myretrotv/extra/my60stv.png
wget -q -O /userdata/system/pro/$appname/extra/myretrotv.sh.keys https://raw.githubusercontent.com/uureel/batocera.pro/main/myretrotv/extra/myretrotv.sh.keys
# //
# PREPARE GOOGLE-CHROME SHORTCUT:
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
# MYRETROTVS: 
# -- prepare f1 - applications - app shortcut, 
#shortcut=/userdata/system/pro/$appname/extra/MyRetroTVs.desktop
#rm -rf $shortcut 2>/dev/null
#echo "[Desktop Entry]" >> $shortcut
#echo "Version=1.0" >> $shortcut
#echo "Icon=/userdata/system/pro/$appname/extra/myretrotvs.png" >> $shortcut
#echo "Exec=/userdata/system/pro/$appname/MyRetroTVs.sh" >> $shortcut
#echo "Terminal=false" >> $shortcut
#echo "Type=Application" >> $shortcut
#echo "Categories=Game;batocera.linux;" >> $shortcut
#echo "Name=MyRetroTVs" >> $shortcut
#f1shortcut=/usr/share/applications/$appname.desktop
#cp $shortcut $f1shortcut 2>/dev/null
# //
# MY00STV: 
# -- prepare f1 - applications - app shortcut, 
shortcut=/userdata/system/pro/$appname/extra/My00sTV.desktop
rm -rf $shortcut 2>/dev/null
echo "[Desktop Entry]" >> $shortcut
echo "Version=1.0" >> $shortcut
echo "Icon=/userdata/system/pro/$appname/extra/my00stv.png" >> $shortcut
echo "Exec=/userdata/system/pro/$appname/My00sTV.sh" >> $shortcut
echo "Terminal=false" >> $shortcut
echo "Type=Application" >> $shortcut
echo "Categories=Game;batocera.linux;" >> $shortcut
echo "Name=My00sTV" >> $shortcut
f1shortcut=/usr/share/applications/$appname.desktop
cp $shortcut $f1shortcut 2>/dev/null
# //
# MY90STV: 
# -- prepare f1 - applications - app shortcut, 
shortcut=/userdata/system/pro/$appname/extra/My90sTV.desktop
rm -rf $shortcut 2>/dev/null
echo "[Desktop Entry]" >> $shortcut
echo "Version=1.0" >> $shortcut
echo "Icon=/userdata/system/pro/$appname/extra/my90stv.png" >> $shortcut
echo "Exec=/userdata/system/pro/$appname/My90sTV.sh" >> $shortcut
echo "Terminal=false" >> $shortcut
echo "Type=Application" >> $shortcut
echo "Categories=Game;batocera.linux;" >> $shortcut
echo "Name=My90sTV" >> $shortcut
f1shortcut=/usr/share/applications/$appname.desktop
cp $shortcut $f1shortcut 2>/dev/null
# //
# MY80STV: 
# -- prepare f1 - applications - app shortcut, 
shortcut=/userdata/system/pro/$appname/extra/My80sTV.desktop
rm -rf $shortcut 2>/dev/null
echo "[Desktop Entry]" >> $shortcut
echo "Version=1.0" >> $shortcut
echo "Icon=/userdata/system/pro/$appname/extra/my80stv.png" >> $shortcut
echo "Exec=/userdata/system/pro/$appname/My80sTV.sh" >> $shortcut
echo "Terminal=false" >> $shortcut
echo "Type=Application" >> $shortcut
echo "Categories=Game;batocera.linux;" >> $shortcut
echo "Name=My80sTV" >> $shortcut
f1shortcut=/usr/share/applications/$appname.desktop
cp $shortcut $f1shortcut 2>/dev/null
# //
# MY70STV: 
# -- prepare f1 - applications - app shortcut, 
shortcut=/userdata/system/pro/$appname/extra/My70sTV.desktop
rm -rf $shortcut 2>/dev/null
echo "[Desktop Entry]" >> $shortcut
echo "Version=1.0" >> $shortcut
echo "Icon=/userdata/system/pro/$appname/extra/my70stv.png" >> $shortcut
echo "Exec=/userdata/system/pro/$appname/My70sTV.sh" >> $shortcut
echo "Terminal=false" >> $shortcut
echo "Type=Application" >> $shortcut
echo "Categories=Game;batocera.linux;" >> $shortcut
echo "Name=My70sTV" >> $shortcut
f1shortcut=/usr/share/applications/$appname.desktop
cp $shortcut $f1shortcut 2>/dev/null
# //
# MY60STV: 
# -- prepare f1 - applications - app shortcut, 
shortcut=/userdata/system/pro/$appname/extra/My60sTV.desktop
rm -rf $shortcut 2>/dev/null
echo "[Desktop Entry]" >> $shortcut
echo "Version=1.0" >> $shortcut
echo "Icon=/userdata/system/pro/$appname/extra/my60stv.png" >> $shortcut
echo "Exec=/userdata/system/pro/$appname/My60sTV.sh" >> $shortcut
echo "Terminal=false" >> $shortcut
echo "Type=Application" >> $shortcut
echo "Categories=Game;batocera.linux;" >> $shortcut
echo "Name=My60sTV" >> $shortcut
f1shortcut=/usr/share/applications/$appname.desktop
cp $shortcut $f1shortcut 2>/dev/null
# //
# --------------------------------------------------------------------
cp /userdata/system/pro/$appname/Launcher "/userdata/roms/ports/Google Chrome.sh" 2>/dev/null
dos2unix "/userdata/roms/ports/Google Chrome.sh" 2>/dev/null
chmod a+x "/userdata/roms/ports/Google Chrome.sh" 2>/dev/null
cp /userdata/system/pro/$appname/myretrotv.sh.keys "/userdata/roms/ports/Google Chrome.sh.keys" 2>/dev/null
dos2unix "/userdata/roms/ports/Google Chrome.sh.keys" 2>/dev/null 
# --------------------------------------------------------------------
# -- add pad2keys:
if [[ -e "/userdata/system/pro/chrome/myretrotv.sh.keys" ]]; then 
cp "/userdata/system/pro/chrome/myretrotv.sh.keys" "/userdata/roms/ports/Google Chrome.sh.keys" 2>/dev/null
cp "/userdata/system/pro/chrome/myretrotv.sh.keys" "/userdata/roms/ports/MyRetroTVs.sh.keys" 2>/dev/null
cp "/userdata/system/pro/chrome/myretrotv.sh.keys" "/userdata/roms/ports/My00sTV.sh.keys" 2>/dev/null
cp "/userdata/system/pro/chrome/myretrotv.sh.keys" "/userdata/roms/ports/My90sTV.sh.keys" 2>/dev/null
cp "/userdata/system/pro/chrome/myretrotv.sh.keys" "/userdata/roms/ports/My80sTV.sh.keys" 2>/dev/null
cp "/userdata/system/pro/chrome/myretrotv.sh.keys" "/userdata/roms/ports/My70sTV.sh.keys" 2>/dev/null
cp "/userdata/system/pro/chrome/myretrotv.sh.keys" "/userdata/roms/ports/My60sTV.sh.keys" 2>/dev/null
dos2unix /userdata/roms/ports/MyRetroTVs.sh.keys 2>/dev/null
dos2unix /userdata/roms/ports/My00sTV.sh.keys 2>/dev/null
dos2unix /userdata/roms/ports/My90sTV.sh.keys 2>/dev/null
dos2unix /userdata/roms/ports/My80sTV.sh.keys 2>/dev/null
dos2unix /userdata/roms/ports/My70sTV.sh.keys 2>/dev/null
dos2unix /userdata/roms/ports/My60sTV.sh.keys 2>/dev/null
else 
wget -q -O "/userdata/system/pro/chrome/myretrotv.sh.keys" https://raw.githubusercontent.com/uureel/batocera.pro/main/myretrotv/extra/myretrotv.sh.keys
#cp "/userdata/system/pro/chrome/myretrotv.sh.keys" "/userdata/roms/ports/MyRetroTVs.sh.keys" 2>/dev/null
cp "/userdata/system/pro/chrome/myretrotv.sh.keys" "/userdata/roms/ports/My00sTV.sh.keys" 2>/dev/null
cp "/userdata/system/pro/chrome/myretrotv.sh.keys" "/userdata/roms/ports/My90sTV.sh.keys" 2>/dev/null
cp "/userdata/system/pro/chrome/myretrotv.sh.keys" "/userdata/roms/ports/My80sTV.sh.keys" 2>/dev/null
cp "/userdata/system/pro/chrome/myretrotv.sh.keys" "/userdata/roms/ports/My70sTV.sh.keys" 2>/dev/null
cp "/userdata/system/pro/chrome/myretrotv.sh.keys" "/userdata/roms/ports/My60sTV.sh.keys" 2>/dev/null
#dos2unix /userdata/roms/ports/MyRetroTVs.sh.keys 2>/dev/null
dos2unix /userdata/roms/ports/My00sTV.sh.keys 2>/dev/null
dos2unix /userdata/roms/ports/My90sTV.sh.keys 2>/dev/null
dos2unix /userdata/roms/ports/My80sTV.sh.keys 2>/dev/null
dos2unix /userdata/roms/ports/My70sTV.sh.keys 2>/dev/null
dos2unix /userdata/roms/ports/My60sTV.sh.keys 2>/dev/null
fi
# --------------------------------------------------------------------
# -- prepare prelauncher to add myretrotv and chrome shortcuts to f1, 
pre=/userdata/system/pro/$appname/extra/startup
rm -rf $pre 2>/dev/null
echo "#!/usr/bin/env bash" >> $pre
echo "cp /userdata/system/pro/$appname/extra/$appname.desktop /usr/share/applications/ 2>/dev/null" >> $pre
echo "cp /userdata/system/pro/$appname/extra/My60sTV.desktop /usr/share/applications/ 2>/dev/null" >> $pre
echo "cp /userdata/system/pro/$appname/extra/My70sTV.desktop /usr/share/applications/ 2>/dev/null" >> $pre
echo "cp /userdata/system/pro/$appname/extra/My80sTV.desktop /usr/share/applications/ 2>/dev/null" >> $pre
echo "cp /userdata/system/pro/$appname/extra/My90sTV.desktop /usr/share/applications/ 2>/dev/null" >> $pre
echo "cp /userdata/system/pro/$appname/extra/My00sTV.desktop /usr/share/applications/ 2>/dev/null" >> $pre
#echo "cp /userdata/system/pro/$appname/extra/MyRetroTVs.desktop /usr/share/applications/ 2>/dev/null" >> $pre
dos2unix $pre
chmod a+x $pre
/userdata/system/pro/$appname/extra/startup
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
chmod a+x $customsh 2>/dev/null
# //
#
sleep 1
echo -e "${G}> ${W}DONE"
echo
sleep 1
echo -e "${L}-----------------------------------------------------------------------"
echo -e "${W}> CHROME AND MYRETROTV INSTALLED ${G}OK"
echo -e "${L}-----------------------------------------------------------------------"
sleep 4
curl http://127.0.0.1:1234/reloadgames 
}
export -f batoceraproinstaller
# --------------------------------------------------------------------
function get-xterm-fontsize {
depurl=https://github.com/uureel/batocera.pro/raw/main/.dep; dep=/userdata/system/pro/.dep; mkdir -p $dep 2>/dev/null;
wget -q -O $dep/tput $depurl/tput; wget -q -O $dep/libtinfo.so.6 $depurl/libtinfo.so.6; chmod a+x $dep/tput 2>/dev/null; chmod a+x $dep/libtinfo.so.6 2>/dev/null;
cp $dep/libtinfo.so.6 /lib/libtinfo.so.6 2>/dev/null & cp $dep/libtinfo.so.6 /lib64/libtinfo.so.6 2>/dev/null
cfg=/userdata/system/pro/.dep/display.cfg; rm $cfg 2>/dev/null
DISPLAY=:0.0 xterm -fullscreen -bg "black" -fa "Monospace" -e bash -c "$dep/tput cols >> $cfg" 2>/dev/null
cols=$(cat $cfg | tail -n 1) 2>/dev/null; TEXT_SIZE=$(bc <<<"scale=0;$cols/16") 2>/dev/null
}
export -f get-xterm-fontsize 2>/dev/null; get-xterm-fontsize 2>/dev/null
cfg=/userdata/system/pro/.dep/display.cfg; cols=$(cat $cfg | tail -n 1) 2>/dev/null
until [[ "$cols" != "80" ]]; do get-xterm-fontsize; cols="$(cat $cfg | tail -n 1)"; done 
TEXT_SIZE=$(bc <<<"scale=0;$cols/16") 2>/dev/null 
# --------------------------------------------------------------------
# RUN ALL: 
DISPLAY=:0.0 xterm -fullscreen -bg black -fa "Monospace" -fs $TEXT_SIZE -e bash -c "batoceraproinstaller" 2>/dev/null
# --------------------------------------------------------------------
# BATOCERA.PRO/CHROME INSTALLER //
#################################
exit 0
