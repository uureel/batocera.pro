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
APPNAME=java
APPLINK=$(curl -s https://api.github.com/repos/Heroic-Games-Launcher/HeroicGamesLauncher/releases | grep AppImage | grep "browser_download_url" | head -n 1 | sed 's,^.*https://,https://,g' | cut -d \" -f1) 2>/dev/null
APPHOME=azul.com
#---------------------------------------------------------------------
#       DEFINE LAUNCHER COMMAND >>
COMMAND='mkdir /userdata/system/pro/'$APPNAME'/home 2>/dev/null; mkdir /userdata/system/pro/'$APPNAME'/config 2>/dev/null; mkdir /userdata/system/pro/'$APPNAME'/roms 2>/dev/null; HOME=/userdata/system/pro/'$APPNAME'/home XDG_CONFIG_HOME=/userdata/system/pro/'$APPNAME'/config QT_SCALE_FACTOR="1" GDK_SCALE="1" XDG_DATA_HOME=/userdata/system/pro/'$APPNAME'/home DISPLAY=:0.0 /userdata/system/pro/'$APPNAME'/'$APPNAME'.AppImage --no-sandbox'
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
echo -e "${X}PREPARING $APPNAME RUNTIMES INSTALLER, PLEASE WAIT . . . ${X}"
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
mkdir -p ~/pro/.dep 2>/dev/null && cd ~/pro/.dep && wget --tries=10 --no-check-certificate --no-cache --no-cookies -q -O ~/pro/.dep/dep.zip https://github.com/uureel/batocera.pro/raw/main/.dep/dep.zip && yes "y" | unzip -oq ~/pro/.dep/dep.zip && cd ~/
wget --tries=10 --no-check-certificate --no-cache --no-cookies -q -O $pro/$appname/extra/icon.png https://github.com/uureel/batocera.pro/raw/main/$appname/extra/icon.png; chmod a+x $dep/* 2>/dev/null; cd ~/
for file in /userdata/system/pro/.dep/lib*; do sudo ln -s "$file" "/usr/lib/$(basename $file)"; done
# --------------------------------------------------------------------
# // end of dependencies 
#
# --------------------------------------------------------------------
# -- run before installer:  
#killall wget 2>/dev/null && killall $AppName 2>/dev/null && killall $AppName 2>/dev/null && killall $AppName 2>/dev/null
# --------------------------------------------------------------------
cols=$($dep/tput cols) 2>/dev/null; rm -rf /userdata/system/pro/$appname/extra/cols 2>/dev/null
echo $cols >> /userdata/system/pro/$appname/extra/cols 2>/dev/null
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
echo -e "${X}THIS WILL INSTALL JAVA RUNTIMES FOR BATOCERA" 
echo -e "${X}USING $ORIGIN JAVA JRE PACKAGES" 
echo -e "${X}VERSIONS: 19, 17, 15, 13, 11, 8"  
echo
echo -e "${X}$APPNAME RUNTIMES WILL BE INSTALLED IN:"
echo -e "${X}/USERDATA/SYSTEM/PRO/$APPNAME" 
echo
#/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
# --------------------------------------------------------------------
#\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
# -- THIS WILL BE SHOWN ON MAIN BATOCERA DISPLAY:   
function batocera-pro-installer {
APPNAME=$1
appname=$2
AppName=$3
APPPATH=$4
APPLINK=$5
ORIGIN=$6
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
cols=$(cat /userdata/system/pro/.dep/display.cfg | tail -n 1) 2>/dev/null
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
echo -e "${W}THIS WILL INSTALL JAVA RUNTIMES FOR BATOCERA" 
echo -e "${W}USING $ORIGIN JAVA JRE PACKAGES" 
echo -e "${W}VERSIONS: ${G}19, 17, 15, 13, 11, 8${W}"  
echo
echo -e "${W}$APPNAME RUNTIMES WILL BE INSTALLED IN:"
echo -e "${W}/USERDATA/SYSTEM/PRO/$APPNAME"
echo; #line $cols '='; echo
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
echo -e "${G}DOWNLOADING${W} [6] JAVA RUNTIME PACKAGES . . ."
url=https://github.com/uureel/batocera.pro/raw/main/
cd $temp
curl --progress-bar --remote-name --location "$url/$appname/extra/java19.tar.gz"
curl --progress-bar --remote-name --location "$url/$appname/extra/java17.tar.gz"
curl --progress-bar --remote-name --location "$url/$appname/extra/java15.tar.gz"
curl --progress-bar --remote-name --location "$url/$appname/extra/java13.tar.gz"
curl --progress-bar --remote-name --location "$url/$appname/extra/java11.tar.gz"
curl --progress-bar --remote-name --location "$url/$appname/extra/java8.tar.gz"
SIZE=$(du -sh $temp | awk '{print $1}') 2>/dev/null
echo -e "${T}$temp  ${T}$SIZE( )  ${G}OK${W}" | sed 's/( )//g' 2>/dev/null
echo
echo; #line $cols '='; echo
sleep 1.333 
# --------------------------------------------------------------------
echo -e "${G}INSTALLING${W} . . ." 
# --------------------------------------------------------------------
# get tar 
wget -q -O $pro/.dep/tar $url/.dep/tar 2>/dev/null
chmod a+x $pro/.dep/tar
# --------------------------------------------------------------------
# java19
$pro/.dep/tar -xf $temp/java19.tar.gz 2>/dev/null
mv $temp/java19 $pro/$appname/ 2>/dev/null
# --------------------------------------------------------------------
# java17
$pro/.dep/tar -xf $temp/java17.tar.gz 2>/dev/null
    # --------------------------------------------------------------------
    # -- make this version the default system java version: 
    cp -r $temp/java17/* $pro/$appname/ 2>/dev/null
    # --------------------------------------------------------------------
mv $temp/java17 $pro/$appname/ 2>/dev/null
# --------------------------------------------------------------------
# java15
$pro/.dep/tar -xf $temp/java15.tar.gz 2>/dev/null
mv $temp/java15 $pro/$appname/ 2>/dev/null
# --------------------------------------------------------------------
# java13
$pro/.dep/tar -xf $temp/java13.tar.gz 2>/dev/null
mv $temp/java13 $pro/$appname/ 2>/dev/null
# --------------------------------------------------------------------
# java11
$pro/.dep/tar -xf $temp/java11.tar.gz 2>/dev/null
mv $temp/java11 $pro/$appname/ 2>/dev/null
# --------------------------------------------------------------------
# java17
$pro/.dep/tar -xf $temp/java8.tar.gz 2>/dev/null
mv $temp/java8 $pro/$appname/ 2>/dev/null
# --------------------------------------------------------------------
chmod a+x $pro/java/bin/* 2>/dev/null
chmod a+x $pro/java19/bin/* 2>/dev/null
chmod a+x $pro/java17/bin/* 2>/dev/null
chmod a+x $pro/java15/bin/* 2>/dev/null
chmod a+x $pro/java13/bin/* 2>/dev/null
chmod a+x $pro/java11/bin/* 2>/dev/null
chmod a+x $pro/java8/bin/* 2>/dev/null
cd ~/
#rm -rf $temp
SIZE=$(du -sh $pro/$appname | awk '{print $1}') 2>/dev/null
echo -e "${T}$pro/$appname  ${T}$SIZE( )  ${G}OK${W}" | sed 's/( )//g' 2>/dev/null
# --------------------------------------------------------------------
export='export PATH=/userdata/system/pro/java/bin:$PATH'
find="system/pro/java"
# --------------------------------------------------------------------
# attach java runtime to ~/.profile
file=/userdata/system/.profile
  if [[ -e "$file" ]]; then
temp=/userdata/system/.profile.tmp
rm $temp 2>/dev/null
nl=$(cat $file | wc -l)
l=1; while [[ $l -le $nl ]]; do
ln=$(cat $file | sed ""$l"q;d")
if [[ "$(echo $ln | grep "$find")" != "" ]]; then :; else echo "$ln" >> $temp; fi
((l++))
done
echo -e '\nexport PATH=/userdata/system/pro/java/bin:$PATH && export JAVA_HOME=/userdata/system/pro/java' >> $temp
cp $temp $file 2>/dev/null; rm $temp 2>/dev/null
  else
echo -e '\nexport PATH=/userdata/system/pro/java/bin:$PATH && export JAVA_HOME=/userdata/system/pro/java' >> $file
  fi
dos2unix /userdata/system/.profile 2>/dev/null
#source ~/.profile 
export PATH="/userdata/system/pro/java/bin:${PATH}" && export JAVA_HOME=/userdata/system/pro/java
# --------------------------------------------------------------------
# attach java runtime to ~/.bashrc
file=/userdata/system/.bashrc
  if [[ -e "$file" ]]; then
temp=/userdata/system/.bashrc.tmp
rm $temp 2>/dev/null
nl=$(cat $file | wc -l)
l=1; while [[ $l -le $nl ]]; do
ln=$(cat $file | sed ""$l"q;d")
if [[ "$(echo $ln | grep "$find")" != "" ]]; then :; else echo "$ln" >> $temp; fi
((l++))
done
echo -e '\nexport PATH=/userdata/system/pro/java/bin:$PATH && export JAVA_HOME=/userdata/system/pro/java' >> $temp
cp $temp $file 2>/dev/null; rm $temp 2>/dev/null
  else
echo -e '\nexport PATH=/userdata/system/pro/java/bin:$PATH && export JAVA_HOME=/userdata/system/pro/java' >> $file
  fi
dos2unix /userdata/system/.bashrc 2>/dev/null
# --------------------------------------------------------------------
# run export: 
export PATH=/userdata/system/pro/java/bin:$PATH
export JAVA_HOME=/userdata/system/pro/java
# -- prepare launcher to solve dependencies on each run and avoid overlay, 
launcher=/userdata/system/pro/$appname/Launcher
rm -rf $launcher
echo '#!/bin/bash ' >> $launcher
echo 'export PATH=/userdata/system/pro/java/bin:$PATH && export JAVA_HOME=/userdata/system/pro/java' >> $launcher
echo 'function get-java-version {' >> $launcher
echo 'W="\033[0;37m" ' >> $launcher
echo 'G="\033[1;32m" ' >> $launcher
# 
echo 'java=/userdata/system/pro/java/bin/java' >> $launcher
echo 'if [[ -e "$java" ]]; then echo -e "${G}> DEFAULT JAVA RUNTIME${W}"; $java --version | grep openjdk; sleep 0.33; echo; echo' >> $launcher
echo 'else echo -e "${W}DEFAULT JAVA RUNTIME NOT FOUND"; sleep 0.33; echo; echo; fi' >> $launcher
echo 'java19=/userdata/system/pro/java/java19/bin/java' >> $launcher
echo 'if [[ -e "$java19" ]]; then echo -e "${G}~/pro/java/java19${W}"; $java19 --version | grep openjdk; sleep 0.33; echo' >> $launcher
echo 'else echo -e "${W}JAVA 19 NOT FOUND"; echo; sleep 0.33; echo; fi' >> $launcher
echo 'java17=/userdata/system/pro/java/java17/bin/java' >> $launcher
echo 'if [[ -e "$java17" ]]; then echo -e "${G}~/pro/java/java17${W}"; $java17 --version | grep openjdk; sleep 0.33; echo' >> $launcher
echo 'else echo -e "${W}JAVA 17 NOT FOUND"; echo; sleep 0.33; echo; fi' >> $launcher
echo 'java15=/userdata/system/pro/java/java15/bin/java' >> $launcher
echo 'if [[ -e "$java15" ]]; then echo -e "${G}~/pro/java/java15${W}"; $java15 --version | grep openjdk; sleep 0.33; echo' >> $launcher
echo 'else echo -e "${W}JAVA 15 NOT FOUND"; echo; sleep 0.33; echo; fi' >> $launcher
echo 'java13=/userdata/system/pro/java/java13/bin/java' >> $launcher
echo 'if [[ -e "$java13" ]]; then echo -e "${G}~/pro/java/java13${W}"; $java13 --version | grep openjdk; sleep 0.33; echo' >> $launcher
echo 'else echo -e "${W}JAVA 13 NOT FOUND"; echo; sleep 0.33; echo; fi' >> $launcher
echo 'java11=/userdata/system/pro/java/java11/bin/java' >> $launcher
echo 'if [[ -e "$java11" ]]; then echo -e "${G}~/pro/java/java11${W}"; $java11 --version | grep openjdk; sleep 0.33; echo' >> $launcher
echo 'else echo -e "${W}JAVA 11 NOT FOUND"; echo; sleep 0.33; echo; fi' >> $launcher
echo 'java8=/userdata/system/pro/java/java8/bin/java' >> $launcher
echo 'if [[ -e "$java8" ]]; then echo -e "${G}~/pro/java/java8${W}"; $java8 --version | grep openjdk; sleep 0.33; echo' >> $launcher
echo 'else echo -e "${W}JAVA 8 NOT FOUND"; echo; sleep 0.33; echo; fi' >> $launcher
echo 'echo ' >> $launcher
echo 'echo "will close after 10 seconds"' >> $launcher
echo 'sleep 10' >> $launcher
#
echo '}' >> $launcher
echo 'export -f get-java-version 2>/dev/null' >> $launcher
echo 'function get-xterm-fontsize {' >> $launcher
echo 'tput=/userdata/system/pro/.dep/tput; chmod a+x $tput;' >> $launcher 
echo 'ln -s /userdata/system/pro/.dep/libtinfo.so.6 /usr/lib/libtinfo.so.6 2>/dev/null' >> $launcher
echo 'cfg=/userdata/system/pro/.dep/display.cfg; rm $cfg 2>/dev/null' >> $launcher
echo 'DISPLAY=:0.0 xterm -fullscreen -bg "black" -fa "Monospace" -e bash -c "$tput cols >> $cfg" 2>/dev/null' >> $launcher
echo 'cols=$(cat $cfg | tail -n 1) 2>/dev/null' >> $launcher
echo 'TEXT_SIZE=$(bc <<<"scale=0;$cols/16") 2>/dev/null' >> $launcher
echo '}' >> $launcher
echo 'export -f get-xterm-fontsize 2>/dev/null' >> $launcher
echo 'get-xterm-fontsize 2>/dev/null' >> $launcher
echo 'cfg=/userdata/system/pro/.dep/display.cfg' >> $launcher
echo 'cols=$(cat $cfg | tail -n 1) 2>/dev/null' >> $launcher
echo 'until [[ "$cols" != "80" ]] ' >> $launcher
echo 'do' >> $launcher
echo 'get-xterm-fontsize 2>/dev/null' >> $launcher
echo 'cols=$(cat $cfg | tail -n 1) 2>/dev/null' >> $launcher
echo 'done ' >> $launcher
echo 'TEXT_SIZE=$(bc <<<"scale=0;$cols/16") 2>/dev/null' >> $launcher
echo 'DISPLAY=:0.0 xterm -fullscreen -bg black -fa 'Monospace' -fs $TEXT_SIZE -e bash -c "get-java-version" 2>/dev/null' >> $launcher
dos2unix $launcher 2>/dev/null
chmod a+x $launcher 2>/dev/null
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
dos2unix $shortcut 2>/dev/null
chmod a+x $shortcut 2>/dev/null
cp $shortcut $f1shortcut 2>/dev/null
# --------------------------------------------------------------------
# -- prepare prelauncher to avoid overlay,
pre=/userdata/system/pro/$appname/extra/startup
rm -rf $pre 2>/dev/null
echo "#!/usr/bin/env bash" >> $pre
echo "cp /userdata/system/pro/$appname/extra/$appname.desktop /usr/share/applications/ 2>/dev/null" >> $pre
#echo "cp /userdata/system/pro/$appname/bin/java /usr/bin/java 2>/dev/null" >> $pre
echo "ln -sf /userdata/system/pro/$appname/bin/java /usr/bin/java 2>/dev/null" >> $pre
echo "ln -s /userdata/system/pro/.dep/libselinux.so.1 /usr/lib/libselinux.so.1 2>/dev/null" >> $pre
echo "ln -s /userdata/system/pro/.dep/tar /bin/tar 2>/dev/null" >> $pre
dos2unix $pre 2>/dev/null
chmod a+x $pre 2>/dev/null
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
chmod a+x $csh 2>/dev/null
# -- done. 
sleep 1
echo -e "${G}> ${W}DONE${W}"
echo
sleep 1
echo
echo -e "${G}> $APPNAME INSTALLED ${G}OK${W}"
sleep 0.5
echo -e "${W}TO CHANGE THE DEFAULT JAVA VERSION: COPY CONTENTS OF"
echo -e "${W}~/pro/java/java[VER] TO THE MAIN ~/pro/java FOLDER"
echo
line $cols '='; echo
sleep 10
}
export -f batocera-pro-installer 2>/dev/null
# --------------------------------------------------------------------
# RUN:
# |
  batocera-pro-installer "$APPNAME" "$appname" "$AppName" "$APPPATH" "$APPLINK" "$ORIGIN"
# --------------------------------------------------------------------
# BATOCERA.PRO INSTALLER //
##########################
clear
if [[ -e "/userdata/pro/java/java19/bin/java" ]] && [[ -e "/userdata/pro/java/java17/bin/java" ]] && [[ -e "/userdata/pro/java/java15/bin/java" ]] && [[ -e "/userdata/pro/java/java13/bin/java" ]] && [[ -e "/userdata/pro/java/java11/bin/java" ]] && [[ -e "/userdata/pro/java/java8/bin/java" ]]; then
echo
echo
echo -e "${W}> $APPNAME INSTALLED ${G}OK${W}"
echo 
echo 
echo -e "${W}TO CHANGE THE DEFAULT JAVA VERSION: COPY CONTENTS OF"
echo -e "${W}~/pro/java/java[VER] TO THE MAIN ~/pro/java FOLDER"
echo
echo
fi