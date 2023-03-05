#!/usr/bin/env bash 
# BATOCERA.PRO INSTALLER
######################################################################
#--------------------------------------------------------------------- 
APPNAME="SWITCH-EMULATION" 
ORIGIN="github.com/ordovice/batocera-switch" 
#---------------------------------------------------------------------
######################################################################
ORIGIN="${ORIGIN^^}"
extra=/userdata/system/switch/extra 
mkdir /userdata/system/switch 2>/dev/null 
mkdir /userdata/system/switch/extra 2>/dev/null 
#/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
# --------------------------------------------------------------------
#\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\   
function batocera-pro-installer {
APPNAME=$1
ORIGIN=$2
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
W=$X
# --------------------------------------------------------------------
clear
echo
echo
echo
echo -e "${X}${X}$APPNAME${X} INSTALLER ${X}"
echo
echo
echo
sleep 0.33

clear
echo
echo
echo
echo -e "${X}${X}$APPNAME${X} INSTALLER ${X}"
echo
echo
echo
sleep 0.33

clear
echo
echo
echo -e "${X}- - - - - - - - -"
echo -e "${X}${X}$APPNAME${X} INSTALLER ${X}"
echo -e "${X}- - - - - - - - -"
echo
echo
sleep 0.33
clear

echo
echo -e "${X}- - - - - - - - -"
echo
echo -e "${X}${X}$APPNAME${X} INSTALLER ${X}"
echo 
echo -e "${X}- - - - - - - - -"
echo
sleep 0.33

clear
echo -e "${X}- - - - - - - - -"
echo 
echo 
echo -e "${X}${X}$APPNAME${X} INSTALLER ${X}"
echo 
echo 
echo -e "${X}- - - - - - - - -"
sleep 0.33

clear
echo
echo
echo 
echo -e "${X}${X}$APPNAME${X} INSTALLER ${X}"
echo 
echo 
echo
sleep 0.33

echo -e "${X}INSTALLING $APPNAME FOR BATOCERA"
echo -e "${X}USING $ORIGIN"
echo 
echo
echo
sleep 3
# --------------------------------------------------------------------
# -- check system before proceeding
if [[ "$(uname -a | grep "x86_64")" != "" ]]; then 
:
else
echo
echo -e "${X}ERROR: SYSTEM NOT SUPPORTED"
echo -e "${X}YOU NEED BATOCERA X86_64${X}"
echo
sleep 5
exit 0
# quit
exit 0
fi
# --------------------------------------------------------------------
# -------------------------------------------------------------------- 
# -------------------------------------------------------------------- 
echo -e "${X}PLEASE WAIT${X} . . ." 
#echo -e "${X}${X}" 
# -------------------------------------------------------------------- 
# -------------------------------------------------------------------- 
# -------------------------------------------------------------------- 
# PURGE OLD INSTALLS 
rm -rf /userdata/system/switch 2>/dev/null
rm /userdata/system/configs/emulationstation/add_feat_switch.cfg 2>/dev/null
rm /userdata/system/configs/emulationstation/es_features.cfg 2>/dev/null
# -------------------------------------------------------------------- 
# FILL PATHS
#mkdir -p /userdata/roms/ports/images 2>/dev/null
#mkdir -p /userdata/roms/switch 2>/dev/null
#mkdir -p /userdata/bios/switch 2>/dev/null
#mkdir -p /userdata/bios/switch/firmware 2>/dev/null
#mkdir -p /userdata/system/configs/emulationstation 2>/dev/null
#mkdir -p /userdata/system/configs/evmapy 2>/dev/null
#mkdir -p /userdata/system/switch/configgen/generators/yuzu 2>/dev/null
#mkdir -p /userdata/system/switch/configgen/generators/ryujinx 2>/dev/null
#mkdir -p /userdata/system/switch/extra 2>/dev/null

mkdir /userdata/roms/switch 2>/dev/null
mkdir /userdata/roms/ports 2>/dev/null
mkdir /userdata/roms/ports/images 2>/dev/null

mkdir /userdata/bios/switch 2>/dev/null
mkdir /userdata/bios/switch/firmware 2>/dev/null

mkdir /userdata/system/switch 2>/dev/null
mkdir /userdata/system/switch/extra 2>/dev/null
mkdir /userdata/system/switch/configgen 2>/dev/null
mkdir /userdata/system/switch/configgen/generators 2>/dev/null
mkdir /userdata/system/switch/configgen/generators/yuzu 2>/dev/null
mkdir /userdata/system/switch/configgen/generators/ryujinx 2>/dev/null

mkdir /userdata/system/configs 2>/dev/null
mkdir /userdata/system/configs/evmapy 2>/dev/null
mkdir /userdata/system/configs/emulationstation 2>/dev/null

# -------------------------------------------------------------------- 
# FILL /USERDATA/SYSTEM/SWITCH/EXTRA
path=/userdata/system/switch/extra
url=https://raw.githubusercontent.com/ordovice/batocera-switch/main/system/switch/extra
wget -q -O "$path/batocera-config-ryujinx" "$url/batocera-config-ryujinx"
wget -q -O "$path/batocera-config-ryujinx-avalonia" "$url/batocera-config-ryujinx-avalonia"
wget -q -O "$path/batocera-config-yuzu" "$url/batocera-config-yuzu"
wget -q -O "$path/batocera-config-yuzuEA" "$url/batocera-config-yuzuEA"
wget -q -O "$path/batocera-switch-libselinux.so.1" "$url/batocera-switch-libselinux.so.1"
wget -q -O "$path/batocera-switch-libthai.so.0.3" "$url/batocera-switch-libthai.so.0.3"
wget -q -O "$path/batocera-switch-libtinfo.so.6" "$url/batocera-switch-libtinfo.so.6"
wget -q -O "$path/batocera-switch-sshupdater.sh" "$url/batocera-switch-sshupdater.sh"
wget -q -O "$path/batocera-switch-tar" "$url/batocera-switch-tar"
wget -q -O "$path/batocera-switch-tput" "$url/batocera-switch-tput"
wget -q -O "$path/batocera-switch-updater.sh" "$url/batocera-switch-updater.sh"
wget -q -O "$path/icon_ryujinx.png" "$url/icon_ryujinx.png"
wget -q -O "$path/icon_yuzu.png" "$url/icon_yuzu.png"
wget -q -O "$path/libthai.so.0.3.1" "$url/libthai.so.0.3.1"
wget -q -O "$path/ryujinx-avalonia.png" "$url/ryujinx-avalonia.png"
wget -q -O "$path/ryujinx.png" "$url/ryujinx.png"
wget -q -O "$path/yuzu.png" "$url/yuzu.png"
wget -q -O "$path/yuzuEA.png" "$url/yuzuEA.png"
# -------------------------------------------------------------------- 
# FILL /USERDATA/SYSTEM/SWITCH/CONFIGGEN/GENERATORS/RYUJINX
path=/userdata/system/switch/configgen/generators/ryujinx
url=https://raw.githubusercontent.com/ordovice/batocera-switch/main/system/switch/configgen/generators/ryujinx
wget -q -O "$path/__init__.py" "$url/__init__.py"
wget -q -O "$path/ryujinxMainlineGenerator.py" "$url/ryujinxMainlineGenerator.py"
# -------------------------------------------------------------------- 
# FILL /USERDATA/SYSTEM/SWITCH/CONFIGGEN/GENERATORS/YUZU
path=/userdata/system/switch/configgen/generators/yuzu
url=https://raw.githubusercontent.com/ordovice/batocera-switch/main/system/switch/configgen/generators/yuzu
wget -q -O "$path/__init__.py" "$url/__init__.py"
wget -q -O "$path/yuzuMainlineGenerator.py" "$url/yuzuMainlineGenerator.py"
# -------------------------------------------------------------------- 
# FILL /USERDATA/SYSTEM/SWITCH/CONFIGGEN/GENERATORS
path=/userdata/system/switch/configgen/generators
url=https://raw.githubusercontent.com/ordovice/batocera-switch/main/system/switch/configgen/generators
wget -q -O "$path/__init__.py" "$url/__init__.py"
wget -q -O "$path/Generator.py" "$url/Generator.py"
# -------------------------------------------------------------------- 
# FILL /USERDATA/SYSTEM/SWITCH/CONFIGGEN
path=/userdata/system/switch/configgen
url=https://raw.githubusercontent.com/ordovice/batocera-switch/main/system/switch/configgen
wget -q -O "$path/GeneratorImporter.py" "$url/GeneratorImporter.py"
wget -q -O "$path/switchlauncher.py" "$url/switchlauncher.py"
wget -q -O "$path/switchlauncher2.py" "$url/switchlauncher2.py"
# -------------------------------------------------------------------- 
# FILL /USERDATA/SYSTEM/CONFIGS/EMULATIONSTATION
path=/userdata/system/configs/emulationstation
url=https://raw.githubusercontent.com/ordovice/batocera-switch/main/system/configs/emulationstation
wget -q -O "$path/es_features_switch.cfg" "$url/es_features_switch.cfg"
wget -q -O "$path/es_systems_switch.cfg" "$url/es_systems_switch.cfg"
# -------------------------------------------------------------------- 
# FILL /USERDATA/SYSTEM/CONFIGS/EMULATIONSTATION 
path=/userdata/system/configs/evmapy
url=https://raw.githubusercontent.com/ordovice/batocera-switch/main/system/configs/evmapy
wget -q -O "$path/switch.keys" "$url/switch.keys"
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
dos2unix /userdata/system/switch/extra/*.sh 2>/dev/null
dos2unix /userdata/system/switch/extra/batocera-config* 2>/dev/null
chmod a+x /userdata/system/switch/extra/*.sh 2>/dev/null
chmod a+x /userdata/system/switch/extra/batocera-config* 2>/dev/null
chmod a+x /userdata/system/switch/extra/batocera-switch-lib* 2>/dev/null
chmod a+x /userdata/system/switch/extra/*.desktop 2>/dev/null
# --------------------------------------------------------------------
echo -e "${X} > INSTALLED OK${X}" 
sleep 2
echo
echo
echo
# restore xterm font
X='\033[0m' # / resetcolor
echo -e "${X}LOADING ${X}SWITCH UPDATER${X} . . ." 
echo -e "${X} "
sleep 5
rm -rf /userdata/system/switch/extra/installation 2>/dev/null
echo "OK" >> /userdata/system/switch/extra/installation
rm /tmp/batocera-switch-sshupdater.sh 2>/dev/null 
mkdir -p /tmp 2>/dev/null
wget -q -O "/tmp/batocera-switch-sshupdater.sh" "https://raw.githubusercontent.com/ordovice/batocera-switch/main/system/switch/extra/batocera-switch-sshupdater.sh" 
dos2unix /tmp/batocera-switch-sshupdater.sh 2>/dev/null 
chmod a+x /tmp/batocera-switch-sshupdater.sh 2>/dev/null 
bash /tmp/batocera-switch-sshupdater.sh 
sleep 0.5 
} 
export -f batocera-pro-installer 2>/dev/null 
# --------------------------------------------------------------------
batocera-pro-installer "$APPNAME" "$ORIGIN" 
# --------------------------------------------------------------------
X='\033[0m' # / resetcolor
if [[ -e /userdata/system/switch/extra/installation ]]; then
rm /userdata/system/switch/extra/installation 2>/dev/null
clear
echo
echo 
echo -e "   ${X}$APPNAME INSTALLED${X}" 
echo
echo -e "   ${X}Place your keys in /userdata/bios/switch/${X}" 
echo -e "   ${X}Firmware files in /userdata/bios/switch/firmware/${X}" 
echo
echo -e "   ${X}Use Switch Updater in Ports to update emulators${X}" 
echo
else
clear 
echo
echo
echo -e "   ${X}Looks like the installation failed${X}" 
echo -e "   ${X}Maybe try again?${X}" 
echo
echo
sleep 1
exit 0
fi
# done. 
