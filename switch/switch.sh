#!/usr/bin/env bash 
# BATOCERA.PRO INSTALLER
######################################################################
#--------------------------------------------------------------------- 
APPNAME="SWITCH-EMULATION" 
APPLINK=github.com/ordovice/batocera-switch
ORIGIN="github.com/ordovice/batocera-switch" 
#---------------------------------------------------------------------
######################################################################
ORIGIN="${ORIGIN^^}"
extra=/userdata/system/switch/extra 
mkdir -p $extra 2>/dev/null 
# -- output colors:
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
# --------------------------------------------------------------------
# -- console theme
L=$X
R=$X
# --------------------------------------------------------------------
# -- show console/ssh info:
clear
echo
echo
echo
echo -e "${X}BATOCERA.PRO/$APPNAME INSTALLER${X}"
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
sleep 0.33

clear
echo
echo -e "${W}- - - - - - -"
echo
echo -e "${X}BATOCERA.PRO/$APPNAME INSTALLER${X}"
echo
echo -e "${W}- - - - - - -"
echo
sleep 0.33

clear
echo -e "${W}- - - - - - -"
echo
echo
echo -e "${X}BATOCERA.PRO/$APPNAME INSTALLER${X}"
echo
echo
echo -e "${W}- - - - - - -"
sleep 0.33

clear
echo
echo
echo
echo -e "${X}BATOCERA.PRO/$APPNAME INSTALLER${X}"
echo
echo
echo
sleep 0.33

echo -e "${X}THIS WILL INSTALL $APPNAME FOR BATOCERA"
echo -e "${X}USING $ORIGIN"
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
APPNAME=$1
ORIGIN=$2
# --------------------------------------------------------------------
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
# --------------------------------------------------------------------
#cols=$(cat /userdata/system/switch/extra/display.cfg | tail -n 1) 2>/dev/null
#cols=$(bc <<<"scale=0;$cols/1.3") 2>/dev/null
#cols=$(cat /userdata/system/pro/$appname/extra/cols | tail -n 1)
#line(){
#  local start=1
#  local end=${1:-80}
#  local str="${2:-=}"
#  local range=$(seq $start $end)
#  for i in $range ; do echo -n "${str}"; done
#}
clear
echo
echo
echo
echo -e "${W}BATOCERA.PRO/${G}$APPNAME${W} INSTALLER ${W}"
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
sleep 0.33

clear
echo
echo
echo -e "${W}- - - - - - -"
echo -e "${W}BATOCERA.PRO/${G}$APPNAME${W} INSTALLER ${W}"
echo -e "${W}- - - - - - -"
echo
echo
sleep 0.33
clear

echo
echo -e "${W}- - - - - - -"
echo
echo -e "${W}BATOCERA.PRO/${W}$APPNAME${W} INSTALLER ${W}"
echo 
echo -e "${W}- - - - - - -"
echo
sleep 0.33

clear
echo -e "${W}- - - - - - -"
echo 
echo 
echo -e "${W}BATOCERA.PRO/${G}$APPNAME${W} INSTALLER ${W}"
echo 
echo 
echo -e "${W}- - - - - - -"
sleep 0.33

clear
echo
echo
echo 
echo -e "${W}BATOCERA.PRO/${G}$APPNAME${W} INSTALLER ${W}"
echo 
echo 
echo
sleep 0.33

echo
echo -e "${W}THIS WILL INSTALL $APPNAME FOR BATOCERA"
echo -e "${W}USING $ORIGIN"
echo 
#echo -e "${G}> > > ${W}PRESS ENTER TO CONTINUE" 
#read -p ""
sleep 3
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
# -------------------------------------------------------------------- 
# -------------------------------------------------------------------- 
echo
echo -e "${G}INSTALLING${W} . . ." 
echo -e "${W}PLEASE WAIT${W}" 
# -------------------------------------------------------------------- 
# -------------------------------------------------------------------- 
# -------------------------------------------------------------------- 
# PURGE OLD INSTALLS 
rm -rf /userdata/system/switch 2>/dev/null
rm /userdata/system/configs/emulationstation/add_feat_switch.cfg 2>/dev/null
rm /userdata/system/configs/emulationstation/es_features.cfg 2>/dev/null
# -------------------------------------------------------------------- 
# FILL PATHS
mkdir -p /userdata/roms/ports/images 2>/dev/null
mkdir -p /userdata/roms/switch 2>/dev/null
mkdir -p /userdata/bios/switch 2>/dev/null
mkdir -p /userdata/bios/switch/firmware 2>/dev/null
mkdir -p /userdata/system/configs/emulationstation 2>/dev/null
mkdir -p /userdata/system/configs/evmapy 2>/dev/null
mkdir -p /userdata/system/switch/configgen/generators/yuzu 2>/dev/null
mkdir -p /userdata/system/switch/configgen/generators/ryujinx 2>/dev/null
mkdir -p /userdata/system/switch/extra 2>/dev/null
# -------------------------------------------------------------------- 
# FILL /USERDATA/SYSTEM/SWITCH/EXTRA
path=/userdata/system/switch/extra
url=https://raw.githubusercontent.com/ordovice/batocera-switch/main/system/switch/extra
wget -q -O $path/batocera-config-ryujinx $url/batocera-config-ryujinx
wget -q -O $path/batocera-config-ryujinx-avalonia $url/batocera-config-ryujinx-avalonia
wget -q -O $path/batocera-config-yuzu $url/batocera-config-yuzu
wget -q -O $path/batocera-config-yuzuEA $url/batocera-config-yuzuEA
wget -q -O $path/batocera-switch-libselinux.so.1 $url/batocera-switch-libselinux.so.1
wget -q -O $path/batocera-switch-libthai.so.0.3 $url/batocera-switch-libthai.so.0.3
wget -q -O $path/batocera-switch-libtinfo.so.6 $url/batocera-switch-libtinfo.so.6
wget -q -O $path/batocera-switch-sshupdater.sh $url/batocera-switch-sshupdater.sh
wget -q -O $path/batocera-switch-tar $url/batocera-switch-tar
wget -q -O $path/batocera-switch-tput $url/batocera-switch-tput
wget -q -O $path/batocera-switch-updater.sh $url/batocera-switch-updater.sh
wget -q -O $path/icon_ryujinx.png $url/icon_ryujinx.png
wget -q -O $path/icon_yuzu.png $url/icon_yuzu.png
wget -q -O $path/libthai.so.0.3.1 $url/libthai.so.0.3.1
wget -q -O $path/ryujinx-avalonia.png $url/ryujinx-avalonia.png
wget -q -O $path/ryujinx.png $url/ryujinx.png
wget -q -O $path/yuzu.png $url/yuzu.png
wget -q -O $path/yuzuEA.png $url/yuzuEA.png
# -------------------------------------------------------------------- 
# FILL /USERDATA/SYSTEM/SWITCH/CONFIGGEN/GENERATORS/RYUJINX
path=/userdata/system/switch/configgen/generators/ryujinx
url=https://raw.githubusercontent.com/ordovice/batocera-switch/main/system/switch/configgen/generators/ryujinx
wget -q -O $path/__init__.py $url/__init__.py
wget -q -O $path/ryujinxMainlineGenerator.py $url/ryujinxMainlineGenerator.py
# -------------------------------------------------------------------- 
# FILL /USERDATA/SYSTEM/SWITCH/CONFIGGEN/GENERATORS/YUZU
path=/userdata/system/switch/configgen/generators/yuzu
url=https://raw.githubusercontent.com/ordovice/batocera-switch/main/system/switch/configgen/generators/yuzu
wget -q -O $path/__init__.py $url/__init__.py
wget -q -O $path/yuzuMainlineGenerator.py $url/yuzuMainlineGenerator.py
# -------------------------------------------------------------------- 
# FILL /USERDATA/SYSTEM/SWITCH/CONFIGGEN/GENERATORS
path=/userdata/system/switch/configgen/generators
url=https://raw.githubusercontent.com/ordovice/batocera-switch/main/system/switch/configgen/generators
wget -q -O $path/__init__.py $url/__init__.py
wget -q -O $path/Generator.py $url/Generator.py
# -------------------------------------------------------------------- 
# FILL /USERDATA/SYSTEM/SWITCH/CONFIGGEN
path=/userdata/system/switch/configgen
url=https://raw.githubusercontent.com/ordovice/batocera-switch/main/system/switch/configgen
wget -q -O $path/GeneratorImporter.py $url/GeneratorImporter.py
wget -q -O $path/switchlauncher.py $url/switchlauncher.py
wget -q -O $path/switchlauncher2.py $url/switchlauncher2.py
# -------------------------------------------------------------------- 
# FILL /USERDATA/SYSTEM/CONFIGS/EMULATIONSTATION
path=/userdata/system/configs/emulationstation
url=https://raw.githubusercontent.com/ordovice/batocera-switch/main/system/configs/emulationstation
wget -q -O $path/es_features_switch.cfg $url/es_features_switch.cfg
wget -q -O $path/es_systems_switch.cfg $url/es_systems_switch.cfg
# -------------------------------------------------------------------- 
# FILL /USERDATA/SYSTEM/CONFIGS/EMULATIONSTATION 
path=/userdata/system/configs/evmapy
url=https://raw.githubusercontent.com/ordovice/batocera-switch/main/system/configs/evmapy
wget -q -O $path/switch.keys $url/switch.keys
# -------------------------------------------------------------------- 
# FILL /USERDATA/ROMS/PORTS 
path=/userdata/roms/ports 
url=https://raw.githubusercontent.com/ordovice/batocera-switch/main/roms/ports
wget -q -O "$path/Switch Updater.sh" "$url/Switch Updater.sh"
# -------------------------------------------------------------------- 
# FILL /USERDATA/ROMS/PORTS/IMAGES 
path=/userdata/roms/ports/images
url=https://raw.githubusercontent.com/ordovice/batocera-switch/main/roms/ports/images
wget -q -O "$path/Switch Updater-boxart.png" "$url/Switch Updater-boxart.png"
wget -q -O "$path/Switch Updater-cartridge.png" "$url/Switch Updater-cartridge.png"
wget -q -O "$path/Switch Updater-mix.png" "$url/Switch Updater-mix.png"
wget -q -O "$path/Switch Updater-screenshot.png" "$url/Switch Updater-screenshot.png"
wget -q -O "$path/Switch Updater-wheel.png" "$url/Switch Updater-wheel.png"
# -------------------------------------------------------------------- 
# FILL /USERDATA/ROMS/SWITCH
path=/userdata/roms/switch
url=https://raw.githubusercontent.com/ordovice/batocera-switch/main/roms/switch
wget -q -O "$path/_info.txt" "$url/_info.txt"
# -------------------------------------------------------------------- 
# FILL /USERDATA/BIOS/SWITCH 
path=/userdata/bios/switch
url=https://raw.githubusercontent.com/ordovice/batocera-switch/main/bios/switch
wget -q -O "$path/_info.txt" "$url/_info.txt"
# -------------------------------------------------------------------- 
# REMOVE OLD UPDATERS 
rm /userdata/roms/ports/updateyuzu.sh 2>/dev/null 
rm /userdata/roms/ports/updateyuzuea.sh 2>/dev/null
rm /userdata/roms/ports/updateyuzuEA.sh 2>/dev/null 
rm /userdata/roms/ports/updateryujinx.sh 2>/dev/null
rm /userdata/roms/ports/updateryujinxavalonia.sh 2>/dev/null
# -------------------------------------------------------------------- 
echo -e "${G}INSTALLED OK${W}" 
sleep 2
echo
echo
echo
# restore xterm font
X='\033[0m' # / resetcolor
echo -e "${W}PREPARING TO AUTOMATICALLY RUN ${G}SWITCH UPDATER${X} . . ." 
#echo -e "${W}(THIS WILL TEMPORARILY RETURN TO THE MAIN SCREEN)" 
echo -e "${X} "
#echo -e "${G}> > > ${W}PRESS ENTER TO CONTINUE" 
#read -p ""
sleep 5
rm -rf /userdata/system/switch/extra/installation 2>/dev/null
echo "OK" >> /userdata/system/switch/extra/installation
curl https://raw.githubusercontent.com/ordovice/batocera-switch/main/system/switch/extra/batocera-switch-updater.sh | bash 
}
export -f batocera-pro-installer 2>/dev/null
# --------------------------------------------------------------------
# --- include display output: 
function get-xterm-fontsize {
url_tput=https://github.com/uureel/batocera-switch/raw/main/system/switch/extra/batocera-switch-tput
url_libtinfo=https://github.com/uureel/batocera-switch/raw/main/system/switch/extra/batocera-switch-libtinfo.so.6
extra=/userdata/system/switch/extra; mkdir -p $extra 2>/dev/null 
wget -q -O $extra/batocera-switch-tput $url_tput
wget -q -O $extra/batocera-switch-libtinfo.so.6 $url_libtinfo
cp $extra/batocera-switch-libtinfo.so.6 /lib/libtinfo.so.6 2>/dev/null & cp $extra/batocera-switch-libtinfo.so.6 /lib64/libtinfo.so.6 2>/dev/null
chmod a+x $extra/batocera-switch-tput 2>/dev/null
tput=/userdata/system/switch/extra/batocera-switch-tput
cfg=/userdata/system/switch/extra/display.cfg; rm $cfg 2>/dev/null
DISPLAY=:0.0 xterm -fullscreen -bg "black" -fa "Monospace" -e bash -c "$tput cols >> $cfg" 2>/dev/null
cols=$(cat $cfg | tail -n 1) 2>/dev/null
TEXT_SIZE=$(bc <<<"scale=0;$cols/16") 2>/dev/null
}
export -f get-xterm-fontsize 2>/dev/null
get-xterm-fontsize 2>/dev/null
cfg=/userdata/system/switch/extra/display.cfg
cols=$(cat $cfg | tail -n 1) 2>/dev/null
until [[ "$cols" != "80" ]] 
do
sleep 0.042 && get-xterm-fontsize 2>/dev/null
cols=$(cat $cfg | tail -n 1) 2>/dev/null
done 
TEXT_SIZE=$(bc <<<"scale=0;$cols/16") 2>/dev/null
rm /userdata/system/switch/extra/display.cfg 2>/dev/null
# --------------------------------------------------------------------
# RUN: 
# | 
  DISPLAY=:0.0 xterm -fullscreen -bg black -fa 'Monospace' -fs $TEXT_SIZE -e bash -c "batocera-pro-installer $APPNAME '$ORIGIN'" 2>/dev/null
# &+automatically run switch updater after installation
# --------------------------------------------------------------------
X='\033[0m' # / resetcolor
if [[ -e /userdata/system/switch/extra/installation ]]; then
rm /userdata/system/switch/extra/installation 2>/dev/null
clear
echo
echo
echo
echo -e "${X}$APPNAME INSTALLED AND UPDATED OK${X}" 
echo
echo
echo
else
clear 
echo
echo
echo
echo -e "${X}LOOKS LIKE THE INSTALLATION FAILED . . .${X}" 
echo
echo
echo
sleep 1
exit 0
fi
# done. 
