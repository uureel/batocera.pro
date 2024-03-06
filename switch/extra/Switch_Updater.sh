#!/usr/bin/env bash
######################################################################
#                SWITCH EMULATORS UPDATER FOR BATOCERA               #
#               ----------------------------------------             #
#                    > https://discord.gg/hH5AfThG                   #
#                > github.com/ordovice/batocera-switch               #
######################################################################
#   EMULATORS    /                                                   #
#===============/                                                    #
EMULATORS="YUZUEA YUZU RYUJINX RYUJINXLDN RYUJINXAVALONIA"           #
# DEFAULT:                                                           #
# EMULATORS="YUZUEA YUZU RYUJINX RYUJINXLDN RYUJINXAVALONIA"         #
# EMULATORS="RYUJINX YUZU" -> will only update ryujinx & then yuzu   #
# EMULATORS="YUZUEA"       -> will only update yuzu early access     #
######################################################################
#   CONFIG    /
#============/
TEXT_SIZE=AUTO
TEXT_COLOR=WHITE
THEME_COLOR=WHITE
THEME_COLOR_OK=WHITE
THEME_COLOR_YUZU=RED
THEME_COLOR_YUZUEA=RED
THEME_COLOR_RYUJINX=BLUE
THEME_COLOR_RYUJINXLDN=BLUE
THEME_COLOR_RYUJINXAVALONIA=BLUE
# AVAILABLE COLORS:
# WHITE,BLACK,RED,GREEN,BLUE,YELLOW,PURPLE,CYAN
# DARKRED,DARKGREEN,DARKBLUE,DARKYELLOW,DARKPURPLE,DARKCYAN#
######################################################################
# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
# @@@@@@@@@@@@@@@@                @@@@@            @@@@@@@@@@@@@@@@@@@
# @@@@@@@@@@@@@                   @@@@@                @@@@@@@@@@@@@@@
# @@@@@@@@@@@     @@@@@@@@@@@@    @@@@@                  @@@@@@@@@@@@@
# @@@@@@@@@     @@@@@@@@@@@@@@    @@@@@                   @@@@@@@@@@@@
# @@@@@@@@@    @@@@@      @@@@    @@@@@                   @@@@@@@@@@@@
# @@@@@@@@@    @@@         @@@    @@@@@                   @@@@@@@@@@@@
# @@@@@@@@@    @@@@        @@@    @@@@@                   @@@@@@@@@@@@
# @@@@@@@@@    @@@@@@   %@@@@@    @@@@@                   @@@@@@@@@@@@
# @@@@@@@@@    @@@@@@@@@@@@@@@    @@@@@       @@@@        @@@@@@@@@@@@
# @@@@@@@@@    @@@@@@@@@@@@@@@    @@@@@     @@@@@@@@      @@@@@@@@@@@@
# @@@@@@@@@    @@@@@@@@@@@@@@@    @@@@@    @@@@@@@@@@     @@@@@@@@@@@@
# @@@@@@@@@    @@@@@@@@@@@@@@@    @@@@@     @@@@@@@@      @@@@@@@@@@@@
# @@@@@@@@@    @@@@@@@@@@@@@@@    @@@@@        @@         @@@@@@@@@@@@
# @@@@@@@@@    @@@@@@@@@@@@@@@    @@@@@                   @@@@@@@@@@@@
# @@@@@@@@@    @@@@@@@@@@@@@@@    @@@@@                   @@@@@@@@@@@@
# @@@@@@@@@    @@@@@@@@@@@@@@@    @@@@@                   @@@@@@@@@@@@
# @@@@@@@@@@     @@@@@@@@@@@@@    @@@@@                  @@@@@@@@@@@@@
# @@@@@@@@@@@@      @@@@@@@@@@    @@@@@                @@@@@@@@@@@@@@@
# @@@@@@@@@@@@@@@                 @@@@@             @@@@@@@@@@@@@@@@@@
# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#                > github.com/ordovice/batocera-switch               #
#                    > https://discord.gg/hH5AfThG                   #
######################################################################
######################################################################
######################################################################
######################################################################
# --------------------------------------------------------------------
# PREPARE SHORTCUTS FOR F1-APPLICATIONS MENU
# --------------------------------------------------------------------
function generate-shortcut-launcher {
# SCALING FOR F1 APPS, DEFAULT 1@128:  
SCALE=1
DPI=128
# --------
Name=$1
name=$2
# --------
extra=/userdata/system/switch/extra/$Name.desktop
shortcut=/usr/share/applications/$Name.desktop
launcher=/userdata/system/switch/extra/batocera-switch-launcher-$Name
# --------
rm -rf $shortcut 2>/dev/null && rm -rf $launcher 2>/dev/null
echo "[Desktop Entry]" >> $shortcut
echo "Version=1.0" >> $shortcut
if [[ "$(echo $name | grep yuzu)" != "" ]]; then
echo "Icon=/userdata/system/switch/extra/icon_yuzu.png" >> $shortcut
else
echo "Icon=/userdata/system/switch/extra/icon_ryujinx.png" >> $shortcut
fi
echo "Exec=$launcher" >> $shortcut
echo "Terminal=false" >> $shortcut
echo "Type=Application" >> $shortcut
echo "Categories=Game;batocera.linux;" >> $shortcut
echo "Name=$name-config" >> $shortcut
####
echo "#!/bin/bash" >> $launcher
echo "DISPLAY=:0.0 QT_FONT_DPI=$DPI QT_SCALE_FACTOR=$SCALE GDK_SCALE=$SCALE XDG_CONFIG_HOME="/userdata/system/configs" XDG_DATA_HOME="/userdata/system/configs" XDG_CACHE_HOME="/userdata/system/cache" QT_QPA_PLATFORM="xcb" /userdata/system/switch/$Name.AppImage" >> $launcher
dos2unix "$launcher"
chmod a+x "$launcher"
dos2unix "$shortcut"
chmod a+x "$shortcut"
cp "$shortcut" "$extra" 2>/dev/null
} # -----------------------------------------------------------------
#
# remove old version dekstop shortcuts from ~/.local/share/applications 
rm /userdata/system/.local/share/applications/yuzu-config.desktop 2>/dev/null
rm /userdata/system/.local/share/applications/yuzuEA-config.desktop 2>/dev/null
rm /userdata/system/.local/share/applications/ryujinx-config.desktop 2>/dev/null
rm /userdata/system/.local/share/applications/ryujinxavalonia-config.desktop 2>/dev/null
rm /userdata/system/.local/share/applications/ryujinxldn-config.desktop 2>/dev/null
# remove old version dekstop shortcuts from /usr/share/applications:
rm /usr/share/applications/yuzu-config.desktop 2>/dev/null
rm /usr/share/applications/yuzuEA-config.desktop 2>/dev/null
rm /usr/share/applications/ryujinx-config.desktop 2>/dev/null
rm /usr/share/applications/ryujinxavalonia-config.desktop 2>/dev/null
rm /usr/share/applications/ryujinxldn-config.desktop 2>/dev/null
rm /usr/share/applications/yuzu-config.desktop 2>/dev/null
rm /usr/share/applications/yuzuea-config.desktop 2>/dev/null
rm /usr/share/applications/ryujinx-config.desktop 2>/dev/null
rm /usr/share/applications/ryujinxavalonia-config.desktop 2>/dev/null
rm /usr/share/applications/ryujinxldn-config.desktop 2>/dev/null
# generate new desktop shortcuts: 
generate-shortcut-launcher 'yuzu' 'yuzu'
generate-shortcut-launcher 'yuzuEA' 'yuzuEA'
generate-shortcut-launcher 'Ryujinx' 'ryujinx'
generate-shortcut-launcher 'Ryujinx-LDN' 'ryujinx-LDN'
generate-shortcut-launcher 'Ryujinx-Avalonia' 'ryujinx-Avalonia'
# -------------------------------------------------------------------
# PREPARE BATOCERA-SWITCH-STARTUP FILE
# -------------------------------------------------------------------
startup=/userdata/system/switch/extra/batocera-switch-startup
rm -rf $startup 2>/dev/null
echo '#!/bin/bash' >> $startup 
#\ prepare system
echo '#\ prepare system ' >> $startup
echo 'sysctl -w vm.max_map_count=262144 1>/dev/null' >> $startup
echo 'extra=/userdata/system/switch/extra' >> $startup
echo 'cp $extra/batocera-switch-lib* /lib/ 2>/dev/null' >> $startup
echo 'cp $extra/lib* /lib/ 2>/dev/null' >> $startup
echo 'cp $extra/*.desktop /usr/share/applications/ 2>/dev/null' >> $startup
echo 'rm /lib/libthai.so.0.3.1 2>/dev/null; rm /lib/libthai.so.0 2>/dev/null' >> $startup
echo 'cp /userdata/system/switch/extra/libthai.so.0.3.1 /lib/libthai.so.0.3.1 2>/dev/null' >> $startup
echo 'cp /userdata/system/switch/extra/libthai.so.0.3.1 /lib/libthai.so.0 2>/dev/null' >> $startup
echo '/userdata/system/switch/extra/ryujinx/startup 2>/dev/null' >> $startup
echo '/userdata/system/switch/extra/ryujinxavalonia/startup 2>/dev/null' >> $startup
#\ link ryujinx config folders 
echo '#\ link ryujinx config folders ' >> $startup
echo 'mkdir /userdata/system/configs 2>/dev/null' >> $startup
echo 'mkdir /userdata/system/configs/Ryujinx 2>/dev/null' >> $startup
echo 'mv /userdata/system/configs/Ryujinx /userdata/system/configs/Ryujinx_tmp 2>/dev/null' >> $startup
echo 'cp -rL /userdata/system/.config/Ryujinx/* /userdata/configs/Ryujinx_tmp 2>/dev/null' >> $startup
echo 'rm -rf /userdata/system/.config/Ryujinx' >> $startup
echo 'mv /userdata/system/configs/Ryujinx_tmp /userdata/system/configs/Ryujinx 2>/dev/null' >> $startup
echo 'ln -s /userdata/system/configs/Ryujinx /userdata/system/.config/Ryujinx 2>/dev/null' >> $startup
echo 'rm /userdata/system/configs/Ryujinx/Ryujinx 2>/dev/null' >> $startup
#\ link ryujinx saves folders 
echo '#\ link ryujinx saves folders ' >> $startup
echo 'mkdir /userdata/saves 2>/dev/null' >> $startup
echo 'mkdir /userdata/saves/Ryujinx 2>/dev/null' >> $startup
echo 'mv /userdata/saves/Ryujinx /userdata/saves/Ryujinx_tmp 2>/dev/null' >> $startup
echo 'cp -rL /userdata/system/configs/Ryujinx/bis/user/save/* /userdata/saves/Ryujinx_tmp/ 2>/dev/null' >> $startup
echo 'rm -rf /userdata/system/configs/Ryujinx/bis/user/save 2>/dev/null' >> $startup
echo 'mv /userdata/saves/Ryujinx_tmp /userdata/saves/Ryujinx 2>/dev/null' >> $startup
echo 'mkdir /userdata/system/configs 2>/dev/null' >> $startup
echo 'mkdir /userdata/system/configs/Ryujinx 2>/dev/null' >> $startup
echo 'mkdir /userdata/system/configs/Ryujinx/bis 2>/dev/null' >> $startup
echo 'mkdir /userdata/system/configs/Ryujinx/bis/user 2>/dev/null' >> $startup
echo 'ln -s /userdata/saves/Ryujinx /userdata/system/configs/Ryujinx/bis/user/save 2>/dev/null' >> $startup
echo 'rm /userdata/saves/Ryujinx/Ryujinx 2>/dev/null' >> $startup
echo 'if [ ! -L /userdata/system/configs/Ryujinx/bis/user/save ]; then mkdir /userdata/system/configs/Ryujinx/bis/user/save 2>/dev/null; rsync -au /userdata/saves/Ryujinx/ /userdata/system/configs/Ryujinx/bis/user/save/ 2>/dev/null; fi' >> $startup
#\ link yuzu config folders 
echo '#\ link yuzu config folders ' >> $startup
echo 'mkdir /userdata/system/configs 2>/dev/null' >> $startup
echo 'mkdir /userdata/system/configs/yuzu 2>/dev/null' >> $startup
echo 'mv /userdata/system/configs/yuzu /userdata/system/configs/yuzu_tmp 2>/dev/null' >> $startup
echo 'cp -rL /userdata/system/.config/yuzu/* /userdata/configs/yuzu_tmp 2>/dev/null' >> $startup
echo 'cp -rL /userdata/system/.local/share/yuzu/* /userdata/configs/yuzu_tmp 2>/dev/null' >> $startup
echo 'rm -rf /userdata/system/.config/yuzu' >> $startup
echo 'rm -rf /userdata/system/.local/share/yuzu' >> $startup
echo 'mv /userdata/system/configs/yuzu_tmp /userdata/system/configs/yuzu 2>/dev/null' >> $startup
echo 'ln -s /userdata/system/configs/yuzu /userdata/system/.config/yuzu 2>/dev/null' >> $startup
echo 'ln -s /userdata/system/configs/yuzu /userdata/system/.local/share/yuzu 2>/dev/null' >> $startup
echo 'rm /userdata/system/configs/yuzu/yuzu 2>/dev/null' >> $startup
#\ link yuzu saves folders
echo '#\ link yuzu saves folders' >> $startup
echo 'mkdir /userdata/saves 2>/dev/null' >> $startup
echo 'mkdir /userdata/saves/yuzu 2>/dev/null' >> $startup
echo 'mv /userdata/saves/yuzu /userdata/saves/yuzu_tmp 2>/dev/null' >> $startup
echo 'cp -rL /userdata/system/configs/yuzu/nand/user/save/* /userdata/saves/yuzu_tmp/ 2>/dev/null' >> $startup
echo 'rm -rf /userdata/system/configs/yuzu/nand/user/save 2>/dev/null' >> $startup
echo 'mv /userdata/saves/yuzu_tmp /userdata/saves/yuzu 2>/dev/null' >> $startup
echo 'mkdir /userdata/system/configs 2>/dev/null' >> $startup
echo 'mkdir /userdata/system/configs/yuzu 2>/dev/null' >> $startup
echo 'mkdir /userdata/system/configs/yuzu/nand 2>/dev/null' >> $startup
echo 'mkdir /userdata/system/configs/yuzu/nand/user 2>/dev/null' >> $startup
echo 'ln -s /userdata/saves/yuzu /userdata/system/configs/yuzu/nand/user/save 2>/dev/null' >> $startup
echo 'rm /userdata/saves/yuzu/yuzu 2>/dev/null' >> $startup
echo 'if [ ! -L /userdata/system/configs/yuzu/nand/user/save ]; then mkdir /userdata/system/configs/yuzu/nand/user/save 2>/dev/null; rsync -au /userdata/saves/yuzu/ /userdata/system/configs/yuzu/nand/user/save/ 2>/dev/null; fi' >> $startup
#echo 'if [ ! -L /userdata/system/configs/Ryujinx/system ]; then mkdir /userdata/system/configs/Ryujinx/system 2>/dev/null; cp -rL /userdata/bios/switch/*.keys /userdata/system/configs/Ryujinx/system/ 2>/dev/null; fi' >> $startup
#\ link yuzu and ryujinx keys folders to bios/switch 
echo '#\ link yuzu and ryujinx keys folders to bios/switch ' >> $startup
echo 'cp -rL /userdata/system/configs/yuzu/keys/* /userdata/bios/switch/ 2>/dev/null' >> $startup
echo 'cp -rL /userdata/system/configs/Ryujinx/system/* /userdata/bios/switch/ 2>/dev/null' >> $startup
echo 'mkdir /userdata/system/configs 2>/dev/null' >> $startup
echo 'mkdir /userdata/system/configs/yuzu 2>/dev/null' >> $startup
echo 'mkdir /userdata/system/configs/Ryujinx 2>/dev/null' >> $startup
echo 'mv /userdata/bios/switch /userdata/bios/switch_tmp 2>/dev/null' >> $startup
echo 'rm -rf /userdata/system/configs/yuzu/keys 2>/dev/null' >> $startup
echo 'rm -rf /userdata/system/configs/Ryujinx/system 2>/dev/null' >> $startup
echo 'mv /userdata/bios/switch_tmp /userdata/bios/switch 2>/dev/null' >> $startup
echo 'mkdir /userdata/system/configs 2>/dev/null' >> $startup
echo 'mkdir /userdata/system/configs/yuzu 2>/dev/null' >> $startup
echo 'mkdir /userdata/system/configs/Ryujinx 2>/dev/null' >> $startup
echo 'ln -s /userdata/bios/switch /userdata/system/configs/yuzu/keys 2>/dev/null' >> $startup
echo 'ln -s /userdata/bios/switch /userdata/system/configs/Ryujinx/system 2>/dev/null' >> $startup
echo 'if [ ! -L /userdata/system/configs/yuzu/keys ]; then mkdir /userdata/system/configs/yuzu/keys 2>/dev/null; cp -rL /userdata/bios/switch/*.keys /userdata/system/configs/yuzu/keys/ 2>/dev/null; fi' >> $startup
echo 'if [ ! -L /userdata/system/configs/Ryujinx/system ]; then mkdir /userdata/system/configs/Ryujinx/system 2>/dev/null; cp -rL /userdata/bios/switch/*.keys /userdata/system/configs/Ryujinx/system/ 2>/dev/null; fi' >> $startup
#\ rsync ryujinx+yuzu firmware folders with bios/switch/firmware
echo '#\ rsync ryujinx+yuzu firmware folders with bios/switch/firmware' >> $startup
echo 'rm -rf /userdata/bios/switch/.firmware 2>/dev/null' >> $startup
echo 'rm -rf /userdata/bios/switch/_firmware_ 2>/dev/null' >> $startup
echo 'ff=/userdata/bios/switch/firmware' >> $startup
echo 'ft=/userdata/bios/switch/firmware_backup' >> $startup
echo 'fr=/userdata/system/configs/Ryujinx/bis/system/Contents/registered' >> $startup
echo 'fy=/userdata/system/configs/yuzu/nand/system/Contents/registered' >> $startup
echo 'rm $fr 2>/dev/null' >> $startup
echo 'rm $fy 2>/dev/null' >> $startup
echo 'mkdir /userdata/bios 2>/dev/null' >> $startup
echo 'mkdir /userdata/bios/switch 2>/dev/null' >> $startup
echo 'mkdir /userdata/bios/switch/firmware 2>/dev/null' >> $startup
echo 'mkdir /userdata/bios/switch/firmware_backup 2>/dev/null' >> $startup
#echo 'mkdir -p $ff 2>/dev/null' >> $startup
#echo 'mkdir -p $ft 2>/dev/null' >> $startup
echo 'mkdir /userdata/system/configs 2>/dev/null' >> $startup
echo 'mkdir /userdata/system/configs/Ryujinx 2>/dev/null' >> $startup
echo 'mkdir /userdata/system/configs/Ryujinx/bis 2>/dev/null' >> $startup
echo 'mkdir /userdata/system/configs/Ryujinx/bis/system 2>/dev/null' >> $startup
echo 'mkdir /userdata/system/configs/Ryujinx/bis/system/Contents 2>/dev/null' >> $startup
echo 'mkdir /userdata/system/configs/Ryujinx/bis/system/Contents/registered 2>/dev/null' >> $startup
#
echo 'mkdir /userdata/system/configs 2>/dev/null' >> $startup
echo 'mkdir /userdata/system/configs/yuzu 2>/dev/null' >> $startup
echo 'mkdir /userdata/system/configs/yuzu/nand 2>/dev/null' >> $startup
echo 'mkdir /userdata/system/configs/yuzu/nand/system 2>/dev/null' >> $startup
echo 'mkdir /userdata/system/configs/yuzu/nand/system/Contents 2>/dev/null' >> $startup
echo 'mkdir /userdata/system/configs/yuzu/nand/system/Contents/registered 2>/dev/null' >> $startup
#
#echo 'mkdir -p $fr 2>/dev/null' >> $startup
#echo 'mkdir -p $fy 2>/dev/null' >> $startup
echo 'rsync -au $ff/ $fr/' >> $startup
echo 'rsync -au $fr/ $ff/' >> $startup
echo 'rsync -au $ff/ $fy/' >> $startup
echo 'rsync -au $fy/ $ff/' >> $startup
echo 'rm -rf $ft 2>/dev/null' >> $startup
echo '#/' >> $startup
dos2unix "$startup" 
chmod a+x "$startup" 
# & run startup immediatelly: 
/userdata/system/switch/extra/batocera-switch-startup 
# -------------------------------------------------------------------
# ADD TO BATOCERA AUTOSTART > /USERDATA/SYSTEM/CUSTOM.SH 
# -------------------------------------------------------------------
csh=/userdata/system/custom.sh
startup="/userdata/system/switch/extra/batocera-switch-startup"
if [[ -e "$csh" ]];
then
   tmp=/userdata/system/customsh.tmp
   remove="$startup"
   rm $tmp 2>/dev/null
   nl=$(cat "$csh" | wc -l); nl1=$(($nl + 1))
   l=1; for l in $(seq 1 $nl1); do
   ln=$(cat $csh | sed ""$l"q;d" );
   if [[ "$(echo $ln | grep "$remove")" != "" ]]; then :; else echo $ln >> $tmp; fi
   ((l++))
   done
   cp "$tmp" "$csh" 2>/dev/null
   rm "$tmp" 2>/dev/null
   echo -e "\n$startup" >> $csh   
   dos2unix "$csh" 
   chmod a+x "$csh" 
else 
   echo -e "\n$startup" >> $csh
fi 
cat "$csh" | sed -e '/./b' -e :n -e 'N;s/\n$//;tn' >> "$tmp"; cp "$tmp" "$csh"; rm "$tmp";
dos2unix "$csh" 2>/dev/null
chmod a+x "$csh"
######################################################################
######################################################################
######################################################################
######################################################################
if [[ "$EMULATORS" = "DEFAULT" ]] || [[ "$EMULATORS" = "default" ]] \
|| [[ "$EMULATORS" = "ALL" ]] || [[ "$EMULATORS" = "all" ]]; then
EMULATORS="YUZU YUZUEA RYUJINX RYUJINXLDN RYUJINXAVALONIA"; fi
if [ "$(echo $EMULATORS | grep "-")" = "" ]; then 
EMULATORS="$EMULATORS-"; fi
EMULATORS=$(echo $EMULATORS | sed 's/ /-/g')
# -------------------------------------------------------------------
temp=/userdata/system/switch/extra/downloads
mkdir /userdata/system/switch 2>/dev/null
mkdir /userdata/system/switch/extra 2>/dev/null
mkdir /userdata/system/switch/extra/downloads 2>/dev/null
clear 
# TEXT & THEME COLORS: 
###########################
RED='\033[1;31m'          # red
BLUE='\033[1;34m'         # blue
GREEN='\033[1;32m'        # green
YELLOW='\033[1;33m'       # yellow
PURPLE='\033[1;35m'       # purple
CYAN='\033[1;36m'         # cyan
#-------------------------#
DARKRED='\033[0;31m'      # darkred
DARKBLUE='\033[0;34m'     # darkblue
DARKGREEN='\033[0;32m'    # darkgreen
DARKYELLOW='\033[0;33m'   # darkyellow
DARKPURPLE='\033[0;35m'   # darkpurple
DARKCYAN='\033[0;36m'     # darkcyan
#-------------------------#
WHITE='\033[0;37m'        # white
BLACK='\033[0;30m'        # black
###########################
# PARSE COLORS FOR THEMING:
# ---------------------------------------------------------------------------------- 
if [ "$TEXT_COLOR" = "RED" ]; then TEXT_COLOR="$RED"; fi
if [ "$TEXT_COLOR" = "BLUE" ]; then TEXT_COLOR="$BLUE"; fi
if [ "$TEXT_COLOR" = "GREEN" ]; then TEXT_COLOR="$GREEN"; fi
if [ "$TEXT_COLOR" = "YELLOW" ]; then TEXT_COLOR="$YELLOW"; fi
if [ "$TEXT_COLOR" = "PURPLE" ]; then TEXT_COLOR="$PURPLE"; fi
if [ "$TEXT_COLOR" = "CYAN" ]; then TEXT_COLOR="$CYAN"; fi
if [ "$TEXT_COLOR" = "DARKRED" ]; then TEXT_COLOR="$DARKRED"; fi
if [ "$TEXT_COLOR" = "DARKBLUE" ]; then TEXT_COLOR="$DARKBLUE"; fi
if [ "$TEXT_COLOR" = "DARKGREEN" ]; then TEXT_COLOR="$DARKGREEN"; fi
if [ "$TEXT_COLOR" = "DARKYELLOW" ]; then TEXT_COLOR="$DARKYELLOW"; fi
if [ "$TEXT_COLOR" = "DARKPURPLE" ]; then TEXT_COLOR="$DARKPURPLE"; fi
if [ "$TEXT_COLOR" = "DARKCYAN" ]; then TEXT_COLOR="$DARKCYAN"; fi
if [ "$TEXT_COLOR" = "WHITE" ]; then TEXT_COLOR="$WHITE"; fi
if [ "$TEXT_COLOR" = "BLACK" ]; then TEXT_COLOR="$BLACK"; fi
# ---------------------------------------------------------------------------------- 
if [ "$THEME_COLOR" = "RED" ]; then THEME_COLOR="$RED"; fi
if [ "$THEME_COLOR" = "BLUE" ]; then THEME_COLOR="$BLUE"; fi
if [ "$THEME_COLOR" = "GREEN" ]; then THEME_COLOR="$GREEN"; fi
if [ "$THEME_COLOR" = "YELLOW" ]; then THEME_COLOR="$YELLOW"; fi
if [ "$THEME_COLOR" = "PURPLE" ]; then THEME_COLOR="$PURPLE"; fi
if [ "$THEME_COLOR" = "CYAN" ]; then THEME_COLOR="$CYAN"; fi
if [ "$THEME_COLOR" = "DARKRED" ]; then THEME_COLOR="$DARKRED"; fi
if [ "$THEME_COLOR" = "DARKBLUE" ]; then THEME_COLOR="$DARKBLUE"; fi
if [ "$THEME_COLOR" = "DARKGREEN" ]; then THEME_COLOR="$DARKGREEN"; fi
if [ "$THEME_COLOR" = "DARKYELLOW" ]; then THEME_COLOR="$DARKYELLOW"; fi
if [ "$THEME_COLOR" = "DARKPURPLE" ]; then THEME_COLOR="$DARKPURPLE"; fi
if [ "$THEME_COLOR" = "DARKCYAN" ]; then THEME_COLOR="$DARKCYAN"; fi
if [ "$THEME_COLOR" = "WHITE" ]; then THEME_COLOR="$WHITE"; fi
if [ "$THEME_COLOR" = "BLACK" ]; then THEME_COLOR="$BLACK"; fi
# ---------------------------------------------------------------------------------- 
if [ "$THEME_COLOR_OK" = "RED" ]; then THEME_COLOR_OK="$RED"; fi
if [ "$THEME_COLOR_OK" = "BLUE" ]; then THEME_COLOR_OK="$BLUE"; fi
if [ "$THEME_COLOR_OK" = "GREEN" ]; then THEME_COLOR_OK="$GREEN"; fi
if [ "$THEME_COLOR_OK" = "YELLOW" ]; then THEME_COLOR_OK="$YELLOW"; fi
if [ "$THEME_COLOR_OK" = "PURPLE" ]; then THEME_COLOR_OK="$PURPLE"; fi
if [ "$THEME_COLOR_OK" = "CYAN" ]; then THEME_COLOR_OK="$CYAN"; fi
if [ "$THEME_COLOR_OK" = "DARKRED" ]; then THEME_COLOR_OK="$DARKRED"; fi
if [ "$THEME_COLOR_OK" = "DARKBLUE" ]; then THEME_COLOR_OK="$DARKBLUE"; fi
if [ "$THEME_COLOR_OK" = "DARKGREEN" ]; then THEME_COLOR_OK="$DARKGREEN"; fi
if [ "$THEME_COLOR_OK" = "DARKYELLOW" ]; then THEME_COLOR_OK="$DARKYELLOW"; fi
if [ "$THEME_COLOR_OK" = "DARKPURPLE" ]; then THEME_COLOR_OK="$DARKPURPLE"; fi
if [ "$THEME_COLOR_OK" = "DARKCYAN" ]; then THEME_COLOR_OK="$DARKCYAN"; fi
if [ "$THEME_COLOR_OK" = "WHITE" ]; then THEME_COLOR_OK="$WHITE"; fi
if [ "$THEME_COLOR_OK" = "BLACK" ]; then THEME_COLOR_OK="$BLACK"; fi
# ---------------------------------------------------------------------------------- 
if [ "$THEME_COLOR_YUZU" = "RED" ]; then THEME_COLOR_YUZU="$RED"; fi
if [ "$THEME_COLOR_YUZU" = "BLUE" ]; then THEME_COLOR_YUZU="$BLUE"; fi
if [ "$THEME_COLOR_YUZU" = "GREEN" ]; then THEME_COLOR_YUZU="$GREEN"; fi
if [ "$THEME_COLOR_YUZU" = "YELLOW" ]; then THEME_COLOR_YUZU="$YELLOW"; fi
if [ "$THEME_COLOR_YUZU" = "PURPLE" ]; then THEME_COLOR_YUZU="$PURPLE"; fi
if [ "$THEME_COLOR_YUZU" = "CYAN" ]; then THEME_COLOR_YUZU="$CYAN"; fi
if [ "$THEME_COLOR_YUZU" = "DARKRED" ]; then THEME_COLOR_YUZU="$DARKRED"; fi
if [ "$THEME_COLOR_YUZU" = "DARKBLUE" ]; then THEME_COLOR_YUZU="$DARKBLUE"; fi
if [ "$THEME_COLOR_YUZU" = "DARKGREEN" ]; then THEME_COLOR_YUZU="$DARKGREEN"; fi
if [ "$THEME_COLOR_YUZU" = "DARKYELLOW" ]; then THEME_COLOR_YUZU="$DARKYELLOW"; fi
if [ "$THEME_COLOR_YUZU" = "DARKPURPLE" ]; then THEME_COLOR_YUZU="$DARKPURPLE"; fi
if [ "$THEME_COLOR_YUZU" = "DARKCYAN" ]; then THEME_COLOR_YUZU="$DARKCYAN"; fi
if [ "$THEME_COLOR_YUZU" = "WHITE" ]; then THEME_COLOR_YUZU="$WHITE"; fi
if [ "$THEME_COLOR_YUZU" = "BLACK" ]; then THEME_COLOR_YUZU="$BLACK"; fi
# ---------------------------------------------------------------------------------- 
if [ "$THEME_COLOR_YUZUEA" = "RED" ]; then THEME_COLOR_YUZUEA="$RED"; fi
if [ "$THEME_COLOR_YUZUEA" = "BLUE" ]; then THEME_COLOR_YUZUEA="$BLUE"; fi
if [ "$THEME_COLOR_YUZUEA" = "GREEN" ]; then THEME_COLOR_YUZUEA="$GREEN"; fi
if [ "$THEME_COLOR_YUZUEA" = "YELLOW" ]; then THEME_COLOR_YUZUEA="$YELLOW"; fi
if [ "$THEME_COLOR_YUZUEA" = "PURPLE" ]; then THEME_COLOR_YUZUEA="$PURPLE"; fi
if [ "$THEME_COLOR_YUZUEA" = "CYAN" ]; then THEME_COLOR_YUZUEA="$CYAN"; fi
if [ "$THEME_COLOR_YUZUEA" = "DARKRED" ]; then THEME_COLOR_YUZUEA="$DARKRED"; fi
if [ "$THEME_COLOR_YUZUEA" = "DARKBLUE" ]; then THEME_COLOR_YUZUEA="$DARKBLUE"; fi
if [ "$THEME_COLOR_YUZUEA" = "DARKGREEN" ]; then THEME_COLOR_YUZUEA="$DARKGREEN"; fi
if [ "$THEME_COLOR_YUZUEA" = "DARKYELLOW" ]; then THEME_COLOR_YUZUEA="$DARKYELLOW"; fi
if [ "$THEME_COLOR_YUZUEA" = "DARKPURPLE" ]; then THEME_COLOR_YUZUEA="$DARKPURPLE"; fi
if [ "$THEME_COLOR_YUZUEA" = "DARKCYAN" ]; then THEME_COLOR_YUZUEA="$DARKCYAN"; fi
if [ "$THEME_COLOR_YUZUEA" = "WHITE" ]; then THEME_COLOR_YUZUEA="$WHITE"; fi
if [ "$THEME_COLOR_YUZUEA" = "BLACK" ]; then THEME_COLOR_YUZUEA="$BLACK"; fi
# ---------------------------------------------------------------------------------- 
if [ "$THEME_COLOR_RYUJINX" = "RED" ]; then THEME_COLOR_RYUJINX="$RED"; fi
if [ "$THEME_COLOR_RYUJINX" = "BLUE" ]; then THEME_COLOR_RYUJINX="$BLUE"; fi
if [ "$THEME_COLOR_RYUJINX" = "GREEN" ]; then THEME_COLOR_RYUJINX="$GREEN"; fi
if [ "$THEME_COLOR_RYUJINX" = "YELLOW" ]; then THEME_COLOR_RYUJINX="$YELLOW"; fi
if [ "$THEME_COLOR_RYUJINX" = "PURPLE" ]; then THEME_COLOR_RYUJINX="$PURPLE"; fi
if [ "$THEME_COLOR_RYUJINX" = "CYAN" ]; then THEME_COLOR_RYUJINX="$CYAN"; fi
if [ "$THEME_COLOR_RYUJINX" = "DARKRED" ]; then THEME_COLOR_RYUJINX="$DARKRED"; fi
if [ "$THEME_COLOR_RYUJINX" = "DARKBLUE" ]; then THEME_COLOR_RYUJINX="$DARKBLUE"; fi
if [ "$THEME_COLOR_RYUJINX" = "DARKGREEN" ]; then THEME_COLOR_RYUJINX="$DARKGREEN"; fi
if [ "$THEME_COLOR_RYUJINX" = "DARKYELLOW" ]; then THEME_COLOR_RYUJINX="$DARKYELLOW"; fi
if [ "$THEME_COLOR_RYUJINX" = "DARKPURPLE" ]; then THEME_COLOR_RYUJINX="$DARKPURPLE"; fi
if [ "$THEME_COLOR_RYUJINX" = "DARKCYAN" ]; then THEME_COLOR_RYUJINX="$DARKCYAN"; fi
if [ "$THEME_COLOR_RYUJINX" = "WHITE" ]; then THEME_COLOR_RYUJINX="$WHITE"; fi
if [ "$THEME_COLOR_RYUJINX" = "BLACK" ]; then THEME_COLOR_RYUJINX="$BLACK"; fi
# ---------------------------------------------------------------------------------- 
if [ "$THEME_COLOR_RYUJINXLDN" = "RED" ]; then THEME_COLOR_RYUJINXLDN="$RED"; fi
if [ "$THEME_COLOR_RYUJINXLDN" = "BLUE" ]; then THEME_COLOR_RYUJINXLDN="$BLUE"; fi
if [ "$THEME_COLOR_RYUJINXLDN" = "GREEN" ]; then THEME_COLOR_RYUJINXLDN="$GREEN"; fi
if [ "$THEME_COLOR_RYUJINXLDN" = "YELLOW" ]; then THEME_COLOR_RYUJINXLDN="$YELLOW"; fi
if [ "$THEME_COLOR_RYUJINXLDN" = "PURPLE" ]; then THEME_COLOR_RYUJINXLDN="$PURPLE"; fi
if [ "$THEME_COLOR_RYUJINXLDN" = "CYAN" ]; then THEME_COLOR_RYUJINXLDN="$CYAN"; fi
if [ "$THEME_COLOR_RYUJINXLDN" = "DARKRED" ]; then THEME_COLOR_RYUJINXLDN="$DARKRED"; fi
if [ "$THEME_COLOR_RYUJINXLDN" = "DARKBLUE" ]; then THEME_COLOR_RYUJINXLDN="$DARKBLUE"; fi
if [ "$THEME_COLOR_RYUJINXLDN" = "DARKGREEN" ]; then THEME_COLOR_RYUJINXLDN="$DARKGREEN"; fi
if [ "$THEME_COLOR_RYUJINXLDN" = "DARKYELLOW" ]; then THEME_COLOR_RYUJINXLDN="$DARKYELLOW"; fi
if [ "$THEME_COLOR_RYUJINXLDN" = "DARKPURPLE" ]; then THEME_COLOR_RYUJINXLDN="$DARKPURPLE"; fi
if [ "$THEME_COLOR_RYUJINXLDN" = "DARKCYAN" ]; then THEME_COLOR_RYUJINXLDN="$DARKCYAN"; fi
if [ "$THEME_COLOR_RYUJINXLDN" = "WHITE" ]; then THEME_COLOR_RYUJINXLDN="$WHITE"; fi
if [ "$THEME_COLOR_RYUJINXLDN" = "BLACK" ]; then THEME_COLOR_RYUJINXLDN="$BLACK"; fi
# ---------------------------------------------------------------------------------- 
if [ "$THEME_COLOR_RYUJINXAVALONIA" = "RED" ]; then THEME_COLOR_RYUJINXAVALONIA="$RED"; fi
if [ "$THEME_COLOR_RYUJINXAVALONIA" = "BLUE" ]; then THEME_COLOR_RYUJINXAVALONIA="$BLUE"; fi
if [ "$THEME_COLOR_RYUJINXAVALONIA" = "GREEN" ]; then THEME_COLOR_RYUJINXAVALONIA="$GREEN"; fi
if [ "$THEME_COLOR_RYUJINXAVALONIA" = "YELLOW" ]; then THEME_COLOR_RYUJINXAVALONIA="$YELLOW"; fi
if [ "$THEME_COLOR_RYUJINXAVALONIA" = "PURPLE" ]; then THEME_COLOR_RYUJINXAVALONIA="$PURPLE"; fi
if [ "$THEME_COLOR_RYUJINXAVALONIA" = "CYAN" ]; then THEME_COLOR_RYUJINXAVALONIA="$CYAN"; fi
if [ "$THEME_COLOR_RYUJINXAVALONIA" = "DARKRED" ]; then THEME_COLOR_RYUJINXAVALONIA="$DARKRED"; fi
if [ "$THEME_COLOR_RYUJINXAVALONIA" = "DARKBLUE" ]; then THEME_COLOR_RYUJINXAVALONIA="$DARKBLUE"; fi
if [ "$THEME_COLOR_RYUJINXAVALONIA" = "DARKGREEN" ]; then THEME_COLOR_RYUJINXAVALONIA="$DARKGREEN"; fi
if [ "$THEME_COLOR_RYUJINXAVALONIA" = "DARKYELLOW" ]; then THEME_COLOR_RYUJINXAVALONIA="$DARKYELLOW"; fi
if [ "$THEME_COLOR_RYUJINXAVALONIA" = "DARKPURPLE" ]; then THEME_COLOR_RYUJINXAVALONIA="$DARKPURPLE"; fi
if [ "$THEME_COLOR_RYUJINXAVALONIA" = "DARKCYAN" ]; then THEME_COLOR_RYUJINXAVALONIA="$DARKCYAN"; fi
if [ "$THEME_COLOR_RYUJINXAVALONIA" = "WHITE" ]; then THEME_COLOR_RYUJINXAVALONIA="$WHITE"; fi
if [ "$THEME_COLOR_RYUJINXAVALONIA" = "BLACK" ]; then THEME_COLOR_RYUJINXAVALONIA="$BLACK"; fi
# ---------------------------------------------------------------------------------- 
# PREPARE COOKIE FOR FUNCTIONS: 
rm -rf /userdata/system/switch/extra/batocera-switch-updatersettings
echo "TEXT_SIZE=$TEXT_SIZE" >> /userdata/system/switch/extra/batocera-switch-updatersettings
echo "TEXT_COLOR=$TEXT_COLOR" >> /userdata/system/switch/extra/batocera-switch-updatersettings
echo "THEME_COLOR=$THEME_COLOR" >> /userdata/system/switch/extra/batocera-switch-updatersettings
echo "THEME_COLOR_YUZU=$THEME_COLOR_YUZU" >> /userdata/system/switch/extra/batocera-switch-updatersettings
echo "THEME_COLOR_YUZUEA=$THEME_COLOR_YUZUEA" >> /userdata/system/switch/extra/batocera-switch-updatersettings
echo "THEME_COLOR_RYUJINX=$THEME_COLOR_RYUJINX" >> /userdata/system/switch/extra/batocera-switch-updatersettings
echo "THEME_COLOR_RYUJINXAVALONIA=$THEME_COLOR_RYUJINXAVALONIA" >> /userdata/system/switch/extra/batocera-switch-updatersettings
echo "THEME_COLOR_RYUJINXLDN=$THEME_COLOR_RYUJINXLDN" >> /userdata/system/switch/extra/batocera-switch-updatersettings
echo "THEME_COLOR_OK=$THEME_COLOR_OK" >> /userdata/system/switch/extra/batocera-switch-updatersettings
echo "EMULATORS=$EMULATORS" >> /userdata/system/switch/extra/batocera-switch-updatersettings
####################################################################################
function update_emulator {
E=$1 && N=$2
link_yuzu="$4"
link_yuzuea="$5"
link_ryujinx="$6"
link_ryujinxldn="$7"
link_ryujinxavalonia="$8"
# ---------------------------------------------------------------------------------- 
# TEMPORARILY FREEZING UPDATES FOR RYUJINX: 
#link_ryujinx=https://github.com/uureel/batocera.pro/raw/main/switch/extra/ryujinx-1.1.382-linux_x64.tar.gz
#link_ryujinxavalonia=https://github.com/uureel/batocera.pro/raw/main/switch/extra/test-ava-ryujinx-1.1.382-linux_x64.tar.gz
# ---------------------------------------------------------------------------------- 
# TEMPORARILY FREEZING UPDATES FOR YUZU: 
#link_yuzu=https://archive.org/download/yuzu-windows-msvc-20240304-537296095_202403/yuzu-mainline-20240304-537296095.AppImage
#link_yuzuea=https://github.com/uureel/batocera.pro/raw/main/switch/extra/Linux-Yuzu-EA-3180.AppImage
# ----------------------------------------------------------------------------------
# PATHS: 
path_yuzu=/userdata/system/switch/yuzu.AppImage
path_yuzuea=/userdata/system/switch/yuzuEA.AppImage
path_ryujinx=/userdata/system/switch/Ryujinx.AppImage
path_ryujinxldn=/userdata/system/switch/Ryujinx-LDN.AppImage
path_ryujinxavalonia=/userdata/system/switch/Ryujinx-Avalonia.AppImage
# ---------------------------------------------------------------------------------- 
# READ SETTINGS FROM COOKIE: 
cookie=/userdata/system/switch/extra/batocera-switch-updatersettings
TEXT_SIZE=$(cat $cookie | grep "TEXT_SIZE=" | cut -d "=" -f 2)
TEXT_COLOR=$(cat $cookie | grep "TEXT_COLOR=" | cut -d "=" -f 2)
THEME_COLOR=$(cat $cookie | grep "THEME_COLOR=" | cut -d "=" -f 2)
THEME_COLOR_YUZU=$(cat $cookie | grep "THEME_COLOR_YUZU=" | cut -d "=" -f 2)
THEME_COLOR_YUZUEA=$(cat $cookie | grep "THEME_COLOR_YUZUEA=" | cut -d "=" -f 2)
THEME_COLOR_RYUJINX=$(cat $cookie | grep "THEME_COLOR_RYUJINX=" | cut -d "=" -f 2)
THEME_COLOR_RYUJINXLDN=$(cat $cookie | grep "THEME_COLOR_RYUJINXLDN=" | cut -d "=" -f 2)
THEME_COLOR_RYUJINXAVALONIA=$(cat $cookie | grep "THEME_COLOR_RYUJINXAVALONIA=" | cut -d "=" -f 2)
THEME_COLOR_OK=$(cat $cookie | grep "THEME_COLOR_OK=" | cut -d "=" -f 2)
EMULATORS=$(cat $cookie | grep "EMULATORS=" | cut -d "=" -f 2)
# ---------------------------------------------------------------------------------- 
# OVERRIDE COLORS FOR SSH/XTERM: 
X='\033[0m' # / resetcolor
#TEXT_COLOR=$X 
#THEME_COLOR=$X
#THEME_COLOR_YUZU=$X
#THEME_COLOR_YUZUEA=$X
#THEME_COLOR_RYUJINX=$X
#THEME_COLOR_RYUJINXLDN=$X
#THEME_COLOR_RYUJINXAVALONIA=$X
#THEME_COLOR_OK=$X
# ---------------------------------------------------------------------------------- 
# RUN UPDATER FOR SELECTED EMULATOR:
# ----------------------------------------------------------------------------------
extra=/userdata/system/switch/extra
temp=/userdata/system/switch/extra/downloads
mkdir /userdata/system/switch 2>/dev/null
mkdir /userdata/system/switch/extra 2>/dev/null
mkdir /userdata/system/switch/extra/downloads 2>/dev/null
# 
if [ "$3" = "YUZU" ]; then
T=$THEME_COLOR_YUZU
 if [ "$N" = "1" ]; then C="///////////////"; else C="///// ${F}$E/$N ${T}/////"; fi
echo -e "${T}     ///////////////"
echo -e "${T}    $C    ${F}UPDATING YUZU ..."
echo -e "${T}   ///////////////"
echo -e "${T}$link_yuzu" | sed 's,https://,> ,g' 2>/dev/null
rm -rf $temp/yuzu 2>/dev/null
mkdir $temp/yuzu 2>/dev/null
cd $temp/yuzu
curl --progress-bar --remote-name --location $link_yuzu
mv $temp/yuzu/* $temp/yuzu/yuzu.AppImage 2>/dev/null
chmod a+x "$temp/yuzu/yuzu.AppImage" 2>/dev/null
$temp/yuzu/yuzu.AppImage --appimage-extract 1>/dev/null 
mkdir /userdata/system/switch 2>/dev/null
mkdir /userdata/system/switch/extra 2>/dev/null
mkdir /userdata/system/switch/extra/yuzu 2>/dev/null
cp $temp/yuzu/squashfs-root/usr/lib/libQt5* /userdata/system/switch/extra/yuzu/ 2>/dev/null 
cp $temp/yuzu/squashfs-root/usr/lib/libicu* /userdata/system/switch/extra/yuzu/ 2>/dev/null 
cp $temp/yuzu/squashfs-root/usr/bin/yuzu /userdata/system/switch/extra/yuzu/yuzu 2>/dev/null
cp $temp/yuzu/squashfs-root/usr/bin/yuzu-room /userdata/system/switch/extra/yuzu/yuzu-room 2>/dev/null
cd $temp
# make launcher
ai=/userdata/system/switch/yuzu.AppImage; rm $ai 2>/dev/null
echo '#!/bin/bash' >> $ai
echo 'cp /userdata/system/switch/extra/yuzu/lib* /lib64/ 2>/dev/null' >> $ai 
echo 'export QT_PLUGIN_PATH=/usr/lib/qt/plugins/' >> $ai
echo 'if [ ! -L /userdata/system/configs/Ryujinx/bis/user/save ]; then mkdir /userdata/system/configs/Ryujinx/bis/user/save 2>/dev/null; rsync -au /userdata/saves/Ryujinx/ /userdata/system/configs/Ryujinx/bis/user/save/ 2>/dev/null; fi' >> $ai
echo 'if [ ! -L /userdata/system/configs/yuzu/nand/user/save ]; then mkdir /userdata/system/configs/yuzu/nand/user/save 2>/dev/null; rsync -au /userdata/saves/yuzu/ /userdata/system/configs/yuzu/nand/user/save/ 2>/dev/null; fi' >> $ai
echo 'ff=/userdata/bios/switch/firmware' >> $ai
echo 'fr=/userdata/system/configs/Ryujinx/bis/system/Contents/registered' >> $ai
echo 'fy=/userdata/system/configs/yuzu/nand/system/Contents/registered' >> $ai
echo 'rsync -au $ff/ $fr/ ; rsync -au $ff/ $fy/' >> $ai
echo 'if [ ! -L /userdata/system/configs/yuzu/keys ]; then mkdir /userdata/system/configs/yuzu/keys 2>/dev/null; cp -rL /userdata/bios/switch/*.keys /userdata/system/configs/yuzu/keys/ 2>/dev/null; fi' >> $ai
echo 'if [ ! -L /userdata/system/configs/Ryujinx/system ]; then mkdir /userdata/system/configs/Ryujinx/system 2>/dev/null; cp -rL /userdata/bios/switch/*.keys /userdata/system/configs/Ryujinx/system/ 2>/dev/null; fi' >> $ai
echo 'rm /usr/bin/yuzu 2>/dev/null; rm /usr/bin/yuzu-room 2>/dev/null' >> $ai
echo 'ln -s /userdata/system/switch/yuzu.AppImage /usr/bin/yuzu 2>/dev/null' >> $ai
echo 'cp /userdata/system/switch/extra/yuzu/yuzu-room /usr/bin/yuzu-room 2>/dev/null' >> $ai
echo 'QT_PLUGIN_PATH=/usr/lib/qt/plugins/ XDG_CONFIG_HOME=/userdata/system/configs XDG_CACHE_HOME=/userdata/saves QT_QPA_PLATFORM=xcb XDG_RUNTIME_DIR=/userdata /userdata/system/switch/extra/yuzu/yuzu "$1" "$2" "$3"' >> $ai
dos2unix "$ai" 2>/dev/null; chmod a+x "$ai" 2>/dev/null
chmod a+x "/userdata/system/switch/extra/yuzu/yuzu" 2>/dev/null
chmod a+x "/userdata/system/switch/extra/yuzu/yuzu-room" 2>/dev/null
size_yuzu=$(($(wc -c $temp/yuzu/yuzu.AppImage | awk '{print $1}')/1048576)) 2>/dev/null
echo -e "${T}$path_yuzu  ${T}($size_yuzu( )MB)  ${THEME_COLOR_OK}OK" | sed 's/( )//g'
echo
cd ~/
fi
# ---------------------------------------------------------------------------------- 
if [ "$3" = "YUZUEA" ]; then
T=$THEME_COLOR_YUZUEA
 if [ "$N" = "1" ]; then C="///////////////"; else C="///// ${F}$E/$N ${T}/////"; fi
echo -e "${T}     ///////////////"
echo -e "${T}    $C    ${F}UPDATING YUZU EA ..."
echo -e "${T}   ///////////////"
echo -e "${T}$link_yuzuea" | sed 's,https://,> ,g' 2>/dev/null
rm -rf $temp/yuzuea 2>/dev/null
mkdir $temp/yuzuea 2>/dev/null
cd $temp/yuzuea
curl --progress-bar --remote-name --location $link_yuzuea
mv $temp/yuzuea/* $temp/yuzuea/yuzuEA.AppImage 2>/dev/null
chmod a+x "$temp/yuzuea/yuzuEA.AppImage" 2>/dev/null
$temp/yuzuea/yuzuEA.AppImage --appimage-extract 1>/dev/null 
mkdir /userdata/system/switch 2>/dev/null
mkdir /userdata/system/switch/extra 2>/dev/null
mkdir /userdata/system/switch/extra/yuzuea 2>/dev/null
cp $temp/yuzuea/squashfs-root/usr/lib/libQt5* /userdata/system/switch/extra/yuzuea/ 2>/dev/null 
cp $temp/yuzuea/squashfs-root/usr/lib/libicu* /userdata/system/switch/extra/yuzuea/ 2>/dev/null 
cp $temp/yuzuea/squashfs-root/usr/bin/yuzu /userdata/system/switch/extra/yuzuea/yuzu 2>/dev/null
cp $temp/yuzuea/squashfs-root/usr/bin/yuzu-room /userdata/system/switch/extra/yuzuea/yuzu-room 2>/dev/null
cd $temp
# make launcher
ai=/userdata/system/switch/yuzuEA.AppImage; rm $ai 2>/dev/null
echo '#!/bin/bash' >> $ai
echo 'cp /userdata/system/switch/extra/yuzuea/lib* /lib64/ 2>/dev/null' >> $ai 
echo 'export QT_PLUGIN_PATH=/usr/lib/qt/plugins/' >> $ai
echo 'if [ ! -L /userdata/system/configs/Ryujinx/bis/user/save ]; then mkdir /userdata/system/configs/Ryujinx/bis/user/save 2>/dev/null; rsync -au /userdata/saves/Ryujinx/ /userdata/system/configs/Ryujinx/bis/user/save/ 2>/dev/null; fi' >> $ai
echo 'if [ ! -L /userdata/system/configs/yuzu/nand/user/save ]; then mkdir /userdata/system/configs/yuzu/nand/user/save 2>/dev/null; rsync -au /userdata/saves/yuzu/ /userdata/system/configs/yuzu/nand/user/save/ 2>/dev/null; fi' >> $ai
echo 'ff=/userdata/bios/switch/firmware' >> $ai
echo 'fr=/userdata/system/configs/Ryujinx/bis/system/Contents/registered' >> $ai
echo 'fy=/userdata/system/configs/yuzu/nand/system/Contents/registered' >> $ai
echo 'rsync -au $ff/ $fr/ ; rsync -au $ff/ $fy/' >> $ai
echo 'if [ ! -L /userdata/system/configs/yuzu/keys ]; then mkdir /userdata/system/configs/yuzu/keys 2>/dev/null; cp -rL /userdata/bios/switch/*.keys /userdata/system/configs/yuzu/keys/ 2>/dev/null; fi' >> $ai
echo 'if [ ! -L /userdata/system/configs/Ryujinx/system ]; then mkdir /userdata/system/configs/Ryujinx/system 2>/dev/null; cp -rL /userdata/bios/switch/*.keys /userdata/system/configs/Ryujinx/system/ 2>/dev/null; fi' >> $ai
echo 'rm /usr/bin/yuzu 2>/dev/null; rm /usr/bin/yuzu-room 2>/dev/null' >> $ai
echo 'ln -s /userdata/system/switch/yuzuEA.AppImage /usr/bin/yuzu 2>/dev/null' >> $ai
echo 'cp /userdata/system/switch/extra/yuzuea/yuzu-room /usr/bin/yuzu-room 2>/dev/null' >> $ai
echo 'QT_PLUGIN_PATH=/usr/lib/qt/plugins/ XDG_CONFIG_HOME=/userdata/system/configs XDG_CACHE_HOME=/userdata/saves QT_QPA_PLATFORM=xcb XDG_RUNTIME_DIR=/userdata /userdata/system/switch/extra/yuzuea/yuzu "$1" "$2" "$3"' >> $ai
dos2unix "$ai" 2>/dev/null; chmod a+x "$ai" 2>/dev/null
chmod a+x "/userdata/system/switch/extra/yuzuea/yuzu" 2>/dev/null
chmod a+x "/userdata/system/switch/extra/yuzuea/yuzu-room" 2>/dev/null
size_yuzuea=$(($(wc -c $temp/yuzuea/yuzuEA.AppImage | awk '{print $1}')/1048576)) 2>/dev/null
echo -e "${T}$path_yuzuea  ${T}($size_yuzuea( )MB)  ${THEME_COLOR_OK}OK" | sed 's/( )//g'
echo
cd ~/
fi
# ---------------------------------------------------------------------------------- 
if [ "$3" = "RYUJINX" ]; then
T=$THEME_COLOR_RYUJINX
 if [ "$N" = "1" ]; then C="///////////////"; else C="///// ${F}$E/$N ${T}/////"; fi
echo -e "${T}     ///////////////"
echo -e "${T}    $C    ${F}UPDATING RYUJINX ..."
echo -e "${T}   ///////////////"
echo -e "${T}$link_ryujinx" | sed 's,https://,> ,g'
# --------------------------------------------------------
# --------------------------------------------------------
# \\ get dependencies for handling ryujinx
link_tar=https://github.com/ordovice/batocera-switch/blob/main/system/switch/extra/batocera-switch-tar
if [[ -e "$extra/batocera-switch-tar" ]]; then 
chmod a+x "$extra/batocera-switch-tar"
else 
wget -q -O "$extra/batocera-switch-tar" "$link_tar"
chmod a+x "$extra/batocera-switch-tar"
fi
cp "$extra/batocera-switch-libselinux.so.1" "/lib/libselinux.so.1" 2>/dev/null
# //
# /userdata/system/switch/extra/ryujinx/ will keep all ryujinx related dependencies
emu=ryujinx
mkdir $extra/$emu 2>/dev/null
rm -rf $temp/$emu 2>/dev/null
mkdir $temp/$emu 2>/dev/null
cd $temp/$emu
wget -q -O "$extra/$emu/xdg-mime" "https://github.com/uureel/batocera.pro/raw/main/switch/extra/xdg-mime"
chmod a+x "$extra/$emu/xdg-mime"
curl --progress-bar --remote-name --location $link_ryujinx
$extra/batocera-switch-tar -xf $temp/$emu/*.tar.gz
cp $temp/$emu/publish/lib* $extra/$emu/
mkdir $extra/$emu/mime 2>/dev/null; 
cp -rL $temp/$emu/publish/mime/* $extra/$emu/mime/ 2>/dev/null;
cp -rL $temp/$emu/publish/*.config $extra/$emu/ 2>/dev/null;
cd $extra/$emu
rm -rf $extra/$emu/dependencies 2>/dev/null
ls -l ./lib* | awk '{print $9}' | cut -d "/" -f2 >> $extra/$emu/dependencies
cd ~/
startup=$extra/$emu/startup
rm -rf $startup 2>/dev/null
echo '#!/bin/bash' >> $startup
echo 'cp /userdata/system/switch/extra/'$emu'/lib* /lib/ 2>/dev/null' >> $startup
dos2unix "$startup"
chmod a+x "$startup"
$extra/$emu/startup 2>/dev/null
# / 
path_ryujinx=$extra/$emu/Ryujinx.AppImage
cp $temp/$emu/publish/Ryujinx $path_ryujinx 2>/dev/null
chmod a+x "$path_ryujinx" 2>/dev/null
# make launcher 
ai=/userdata/system/switch/Ryujinx.AppImage; rm $ai 2>/dev/null
echo '#!/bin/bash' >> $ai
echo 'cp /userdata/system/switch/extra/'$emu'/lib* /lib/ 2>/dev/null' >> $ai
echo 'cp /userdata/system/switch/extra/'$emu'/xdg-mime /usr/bin/ 2>/dev/null' >> $ai
echo 'export QT_PLUGIN_PATH=/usr/lib/qt/plugins/' >> $ai
echo 'if [ ! -L /userdata/system/configs/Ryujinx/bis/user/save ]; then mkdir /userdata/system/configs/Ryujinx/bis/user/save 2>/dev/null; rsync -au /userdata/saves/Ryujinx/ /userdata/system/configs/Ryujinx/bis/user/save/ 2>/dev/null; fi' >> $ai
echo 'if [ ! -L /userdata/system/configs/yuzu/nand/user/save ]; then mkdir /userdata/system/configs/yuzu/nand/user/save 2>/dev/null; rsync -au /userdata/saves/yuzu/ /userdata/system/configs/yuzu/nand/user/save/ 2>/dev/null; fi' >> $ai
echo 'ff=/userdata/bios/switch/firmware' >> $ai
echo 'fr=/userdata/system/configs/Ryujinx/bis/system/Contents/registered' >> $ai
echo 'fy=/userdata/system/configs/yuzu/nand/system/Contents/registered' >> $ai
echo 'rsync -au $ff/ $fr/; rsync -au $ff/ $fy/' >> $ai
echo 'if [ ! -L /userdata/system/configs/yuzu/keys ]; then mkdir /userdata/system/configs/yuzu/keys 2>/dev/null; cp -rL /userdata/bios/switch/*.keys /userdata/system/configs/yuzu/keys/ 2>/dev/null; fi' >> $ai
echo 'if [ ! -L /userdata/system/configs/Ryujinx/system ]; then mkdir /userdata/system/configs/Ryujinx/system 2>/dev/null; cp -rL /userdata/bios/switch/*.keys /userdata/system/configs/Ryujinx/system/ 2>/dev/null; fi' >> $ai
echo 'rm /usr/bin/ryujinx 2>/dev/null; ln -s /userdata/system/switch/Ryujinx.AppImage /usr/bin/ryujinx 2>/dev/null' >> $ai
echo 'if [[ "$1" = "" ]]; then SCRIPT_DIR=/userdata/system/switch/extra/ryujinx DOTNET_EnableAlternateStackCheck=1 XDG_CONFIG_HOME=/userdata/system/configs XDG_CACHE_HOME=/userdata/saves QT_QPA_PLATFORM=xcb XDG_RUNTIME_DIR=/userdata /userdata/system/switch/extra/ryujinx/Ryujinx.AppImage' >> $ai
echo 'else SCRIPT_DIR=/userdata/system/switch/extra/ryujinx DOTNET_EnableAlternateStackCheck=1 XDG_CONFIG_HOME=/userdata/system/configs XDG_CACHE_HOME=/userdata/saves QT_QPA_PLATFORM=xcb XDG_RUNTIME_DIR=/userdata /userdata/system/switch/extra/ryujinx/Ryujinx.AppImage "$1"; fi' >> $ai
dos2unix "$ai" 2>/dev/null; chmod a+x "$ai" 2>/dev/null
# --------------------------------------------------------
# --------------------------------------------------------
size_ryujinx=$(($(wc -c $path_ryujinx | awk '{print $1}')/1048576)) 2>/dev/null
echo -e "${T}/userdata/system/switch/Ryujinx.AppImage  ${T}($size_ryujinx( )MB)  ${THEME_COLOR_OK}OK" | sed 's/( )//g'
echo
cd ~/
fi
# ---------------------------------------------------------------------------------- 
if [ "$3" = "RYUJINXLDN" ]; then
T=$THEME_COLOR_RYUJINXLDN
 if [ "$N" = "1" ]; then C="///////////////"; else C="///// ${F}$E/$N ${T}/////"; fi
echo -e "${T}     ///////////////"
echo -e "${T}    $C    ${F}UPDATING RYUJINX LDN ..."
echo -e "${T}   ///////////////"
echo -e "${T}$link_ryujinxldn" | sed 's,https://,> ,g'
# --------------------------------------------------------
# --------------------------------------------------------
# \\ get dependencies for handling ryujinxavalonia
link_tar=https://github.com/ordovice/batocera-switch/blob/main/system/switch/extra/batocera-switch-tar
if [[ -e "$extra/batocera-switch-tar" ]]; then 
   chmod a+x "$extra/batocera-switch-tar"
else 
   wget -q -O "$extra/batocera-switch-tar" "$link_tar"
   chmod a+x "$extra/batocera-switch-tar"
fi
cp "$extra/batocera-switch-libselinux.so.1" "/lib/libselinux.so.1" 2>/dev/null
# //
# /userdata/system/switch/extra/ryujinxavalonia/ will keep all ryujinxavalonia related dependencies
emu=ryujinxldn
mkdir $extra/$emu 2>/dev/null  
rm -rf $temp/$emu 2>/dev/null
mkdir $temp/$emu 2>/dev/null
cd $temp/$emu
wget -q -O "$extra/$emu/xdg-mime" "https://github.com/uureel/batocera.pro/raw/main/switch/extra/xdg-mime"
chmod a+x "$extra/$emu/xdg-mime"
curl --progress-bar --remote-name --location $link_ryujinxldn
$extra/batocera-switch-tar -xf $temp/$emu/*.tar.gz 2>/dev/null
cp $temp/$emu/publish/lib* $extra/$emu/ 2>/dev/null
mkdir $extra/$emu/mime 2>/dev/null; 
cp -rL $temp/$emu/publish/mime/* $extra/$emu/mime/ 2>/dev/null;
cp -rL $temp/$emu/publish/*.config $extra/$emu/ 2>/dev/null;
rm -rf $extra/$emu/startup 2>/dev/null
cd $extra/$emu
rm -rf $extra/$emu/dependencies 2>/dev/null
ls -l ./lib* | awk '{print $9}' | cut -d "/" -f2 >> $extra/$emu/dependencies
cd ~/
startup=$extra/$emu/startup
rm -rf $startup 2>/dev/null
echo '#!/bin/bash' >> $startup
echo 'cp /userdata/system/switch/extra/'$emu'/lib* /lib/ 2>/dev/null' >> $startup
dos2unix "$startup"
chmod a+x "$startup"
$extra/$emu/startup 2>/dev/null
# /
# --------------------------------------------------------
path_ryujinx=$extra/$emu/Ryujinx-LDN.AppImage
cp $temp/$emu/publish/Ryujinx.Ava $path_ryujinx 2>/dev/null
chmod a+x "$path_ryujinx" 2>/dev/null
# make launcher 
ai=/userdata/system/switch/Ryujinx-LDN.AppImage; rm $ai 2>/dev/null
echo '#!/bin/bash' >> $ai
echo 'cp /userdata/system/switch/extra/'$emu'/lib* /lib/ 2>/dev/null' >> $ai
echo 'cp /userdata/system/switch/extra/'$emu'/xdg-mime /usr/bin/ 2>/dev/null' >> $ai
echo 'export QT_PLUGIN_PATH=/usr/lib/qt/plugins/' >> $ai
echo 'if [ ! -L /userdata/system/configs/Ryujinx/bis/user/save ]; then mkdir /userdata/system/configs/Ryujinx/bis/user/save 2>/dev/null; rsync -au /userdata/saves/Ryujinx/ /userdata/system/configs/Ryujinx/bis/user/save/ 2>/dev/null; fi' >> $ai
echo 'if [ ! -L /userdata/system/configs/yuzu/nand/user/save ]; then mkdir /userdata/system/configs/yuzu/nand/user/save 2>/dev/null; rsync -au /userdata/saves/yuzu/ /userdata/system/configs/yuzu/nand/user/save/ 2>/dev/null; fi' >> $ai
echo 'ff=/userdata/bios/switch/firmware' >> $ai
echo 'fr=/userdata/system/configs/Ryujinx/bis/system/Contents/registered' >> $ai
echo 'fy=/userdata/system/configs/yuzu/nand/system/Contents/registered' >> $ai
echo 'rsync -au $ff/ $fr/; rsync -au $ff/ $fy/' >> $ai
echo 'if [ ! -L /userdata/system/configs/yuzu/keys ]; then mkdir /userdata/system/configs/yuzu/keys 2>/dev/null; cp -rL /userdata/bios/switch/*.keys /userdata/system/configs/yuzu/keys/ 2>/dev/null; fi' >> $ai
echo 'if [ ! -L /userdata/system/configs/Ryujinx/system ]; then mkdir /userdata/system/configs/Ryujinx/system 2>/dev/null; cp -rL /userdata/bios/switch/*.keys /userdata/system/configs/Ryujinx/system/ 2>/dev/null; fi' >> $ai
echo 'rm /usr/bin/ryujinx 2>/dev/null; ln -s /userdata/system/switch/Ryujinx-Avalonia.AppImage /usr/bin/ryujinx 2>/dev/null' >> $ai
echo 'if [[ "$1" = "" ]]; then SCRIPT_DIR=/userdata/system/switch/extra/ryujinxldn DOTNET_EnableAlternateStackCheck=1 XDG_CONFIG_HOME=/userdata/system/configs XDG_CACHE_HOME=/userdata/saves QT_QPA_PLATFORM=xcb XDG_RUNTIME_DIR=/userdata /userdata/system/switch/extra/ryujinxldn/Ryujinx-LDN.AppImage' >> $ai
echo 'else SCRIPT_DIR=/userdata/system/switch/extra/ryujinxldn DOTNET_EnableAlternateStackCheck=1 XDG_CONFIG_HOME=/userdata/system/configs XDG_CACHE_HOME=/userdata/saves QT_QPA_PLATFORM=xcb XDG_RUNTIME_DIR=/userdata /userdata/system/switch/extra/ryujinxldn/Ryujinx-LDN.AppImage "$1"; fi' >> $ai
dos2unix "$ai" 2>/dev/null; chmod a+x "$ai" 2>/dev/null
# --------------------------------------------------------
# --------------------------------------------------------
size_ryujinx=$(($(wc -c $path_ryujinx | awk '{print $1}')/1048576)) 2>/dev/null
echo -e "${T}/userdata/system/switch/Ryujinx-LDN.AppImage  ${T}($size_ryujinx( )MB)  ${THEME_COLOR_OK}OK" | sed 's/( )//g'
echo
cd ~/
fi
# ---------------------------------------------------------------------------------- 
if [ "$3" = "RYUJINXAVALONIA" ]; then
T=$THEME_COLOR_RYUJINXAVALONIA
 if [ "$N" = "1" ]; then C="///////////////"; else C="///// ${F}$E/$N ${T}/////"; fi
echo -e "${T}     ///////////////"
echo -e "${T}    $C    ${F}UPDATING RYUJINX AVALONIA ..."
echo -e "${T}   ///////////////"
echo -e "${T}$link_ryujinxavalonia" | sed 's,https://,> ,g'
# --------------------------------------------------------
# --------------------------------------------------------
# \\ get dependencies for handling ryujinxavalonia
link_tar=https://github.com/ordovice/batocera-switch/blob/main/system/switch/extra/batocera-switch-tar
if [[ -e "$extra/batocera-switch-tar" ]]; then 
   chmod a+x "$extra/batocera-switch-tar"
else 
   wget -q -O "$extra/batocera-switch-tar" "$link_tar"
   chmod a+x "$extra/batocera-switch-tar"
fi
cp "$extra/batocera-switch-libselinux.so.1" "/lib/libselinux.so.1" 2>/dev/null
# //
# /userdata/system/switch/extra/ryujinxavalonia/ will keep all ryujinxavalonia related dependencies
emu=ryujinxavalonia
mkdir $extra/$emu 2>/dev/null  
rm -rf $temp/$emu 2>/dev/null
mkdir $temp/$emu 2>/dev/null
cd $temp/$emu
wget -q -O "$extra/$emu/xdg-mime" "https://github.com/uureel/batocera.pro/raw/main/switch/extra/xdg-mime"
chmod a+x "$extra/$emu/xdg-mime"
curl --progress-bar --remote-name --location $link_ryujinxavalonia
$extra/batocera-switch-tar -xf $temp/$emu/*.tar.gz 2>/dev/null
cp $temp/$emu/publish/lib* $extra/$emu/ 2>/dev/null
mkdir $extra/$emu/mime 2>/dev/null; 
cp -rL $temp/$emu/publish/mime/* $extra/$emu/mime/ 2>/dev/null;
cp -rL $temp/$emu/publish/*.config $extra/$emu/ 2>/dev/null;
rm -rf $extra/$emu/startup 2>/dev/null
cd $extra/$emu
rm -rf $extra/$emu/dependencies 2>/dev/null
ls -l ./lib* | awk '{print $9}' | cut -d "/" -f2 >> $extra/$emu/dependencies
cd ~/
startup=$extra/$emu/startup
rm -rf $startup 2>/dev/null
echo '#!/bin/bash' >> $startup
echo 'cp /userdata/system/switch/extra/'$emu'/lib* /lib/ 2>/dev/null' >> $startup
dos2unix "$startup"
chmod a+x "$startup"
$extra/$emu/startup 2>/dev/null
# /
# --------------------------------------------------------
path_ryujinx=$extra/$emu/Ryujinx-Avalonia.AppImage
cp $temp/$emu/publish/Ryujinx.Ava $path_ryujinx 2>/dev/null
chmod a+x "$path_ryujinx" 2>/dev/null
# make launcher 
ai=/userdata/system/switch/Ryujinx-Avalonia.AppImage; rm $ai 2>/dev/null
echo '#!/bin/bash' >> $ai
echo 'cp /userdata/system/switch/extra/'$emu'/lib* /lib/ 2>/dev/null' >> $ai
echo 'cp /userdata/system/switch/extra/'$emu'/xdg-mime /usr/bin/ 2>/dev/null' >> $ai
echo 'export QT_PLUGIN_PATH=/usr/lib/qt/plugins/' >> $ai
echo 'if [ ! -L /userdata/system/configs/Ryujinx/bis/user/save ]; then mkdir /userdata/system/configs/Ryujinx/bis/user/save 2>/dev/null; rsync -au /userdata/saves/Ryujinx/ /userdata/system/configs/Ryujinx/bis/user/save/ 2>/dev/null; fi' >> $ai
echo 'if [ ! -L /userdata/system/configs/yuzu/nand/user/save ]; then mkdir /userdata/system/configs/yuzu/nand/user/save 2>/dev/null; rsync -au /userdata/saves/yuzu/ /userdata/system/configs/yuzu/nand/user/save/ 2>/dev/null; fi' >> $ai
echo 'ff=/userdata/bios/switch/firmware' >> $ai
echo 'fr=/userdata/system/configs/Ryujinx/bis/system/Contents/registered' >> $ai
echo 'fy=/userdata/system/configs/yuzu/nand/system/Contents/registered' >> $ai
echo 'rsync -au $ff/ $fr/; rsync -au $ff/ $fy/' >> $ai
echo 'if [ ! -L /userdata/system/configs/yuzu/keys ]; then mkdir /userdata/system/configs/yuzu/keys 2>/dev/null; cp -rL /userdata/bios/switch/*.keys /userdata/system/configs/yuzu/keys/ 2>/dev/null; fi' >> $ai
echo 'if [ ! -L /userdata/system/configs/Ryujinx/system ]; then mkdir /userdata/system/configs/Ryujinx/system 2>/dev/null; cp -rL /userdata/bios/switch/*.keys /userdata/system/configs/Ryujinx/system/ 2>/dev/null; fi' >> $ai
echo 'rm /usr/bin/ryujinx 2>/dev/null; ln -s /userdata/system/switch/Ryujinx-Avalonia.AppImage /usr/bin/ryujinx 2>/dev/null' >> $ai
echo 'if [[ "$1" = "" ]]; then SCRIPT_DIR=/userdata/system/switch/extra/ryujinxavalonia DOTNET_EnableAlternateStackCheck=1 XDG_CONFIG_HOME=/userdata/system/configs XDG_CACHE_HOME=/userdata/saves QT_QPA_PLATFORM=xcb XDG_RUNTIME_DIR=/userdata /userdata/system/switch/extra/ryujinxavalonia/Ryujinx-Avalonia.AppImage' >> $ai
echo 'else SCRIPT_DIR=/userdata/system/switch/extra/ryujinxavalonia DOTNET_EnableAlternateStackCheck=1 XDG_CONFIG_HOME=/userdata/system/configs XDG_CACHE_HOME=/userdata/saves QT_QPA_PLATFORM=xcb XDG_RUNTIME_DIR=/userdata /userdata/system/switch/extra/ryujinxavalonia/Ryujinx-Avalonia.AppImage "$1"; fi' >> $ai
dos2unix "$ai" 2>/dev/null; chmod a+x "$ai" 2>/dev/null
# --------------------------------------------------------
# --------------------------------------------------------
size_ryujinx=$(($(wc -c $path_ryujinx | awk '{print $1}')/1048576)) 2>/dev/null
echo -e "${T}/userdata/system/switch/Ryujinx-Avalonia.AppImage  ${T}($size_ryujinx( )MB)  ${THEME_COLOR_OK}OK" | sed 's/( )//g'
echo
cd ~/
fi
}
export -f update_emulator
######################################################################
function batocera_update_switch {
######################################################################
cd ~/
spinner()
{
    local pid=$1
    local delay=0.2
    local spinstr='|/-\'
    while [ "$(ps a | awk '{print $1}' | grep $pid)" ]; do
        local temp=${spinstr#?}
        printf "LOADING EMULATORS  %c   " "$spinstr"
        local spinstr=$temp${spinstr%"$temp"}
        sleep $delay
        printf "\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b"
    done
    printf "   \b\b\b\b"
}
resolvelinks()
{
# LINKS & RESOLVERS:
# -------------------------------------------------------------------
links=/userdata/system/switch/extra/links
rm -rf $links 2>/dev/null
# YUZU:
release_yuzu=$(curl -s https://github.com/yuzu-emu/yuzu-mainline/ | grep "yuzu-emu/yuzu-mainline/releases/tag/" | sed 's/^.*href=/href=/g' | cut -d "/" -f 6 | cut -d \" -f 1)
date_yuzu=$(curl -s https://github.com/yuzu-emu/yuzu-mainline/releases/tag/$release_yuzu | grep "datetime=" | sed 's/^.*datetime/datetime/g' | cut -d \" -f 2 | cut -c 1-10 | sed 's/-//g')
subrelease_yuzu=$(curl -s https://github.com/yuzu-emu/yuzu-mainline/releases/tag/$release_yuzu | grep data-hovercard-url | grep commit-link | head -n 1 | cut -d "=" -f 4 | cut -d "/" -f 7 | cut -c 1-9)
link_yuzu=https://github.com/yuzu-emu/yuzu-mainline/releases/download/$release_yuzu/yuzu-mainline-$date_yuzu-$subrelease_yuzu.AppImage
# -------------------------------------------------------------------
# YUZUEA: 
release_yuzuea=$(curl -s https://github.com/pineappleEA/pineapple-src | grep /releases/ | cut -d "=" -f 5 | cut -d / -f 6 | cut -d '"' -f 1)
link_yuzuea=https://github.com/pineappleEA/pineapple-src/releases/download/$release_yuzuea/Linux-Yuzu-$release_yuzuea.AppImage
# -------------------------------------------------------------------
# RYUJINX:
release_ryujinx=$(curl -s https://github.com/Ryujinx/release-channel-master | grep "/release-channel-master/releases/tag/" | sed 's,^.*/release-channel-master/releases/tag/,,g' | cut -d \" -f1)
link_ryujinx=https://github.com/Ryujinx/release-channel-master/releases/download/$release_ryujinx/ryujinx-$release_ryujinx-linux_x64.tar.gz
# -------------------------------------------------------------------
# RYUJINXLDN:
link_ryujinxldn=https://github.com/uureel/batocera.pro/raw/main/switch/extra/ava-ryujinx-1.1.0-ldn3.0.1-linux_x64.tar.gz
## -------------------------------------------------------------------
# RYUJINXAVALONIA:
link_ryujinxavalonia=https://github.com/Ryujinx/release-channel-master/releases/download/$release_ryujinx/test-ava-ryujinx-$release_ryujinx-linux_x64.tar.gz
#
echo "link_yuzu@$link_yuzu" >> $links
echo "link_yuzuea@$link_yuzuea" >> $links
echo "link_ryujinx@$link_ryujinx" >> $links
echo "link_ryujinxldn@$link_ryujinxldn" >> $links
echo "link_ryujinxavalonia@$link_ryujinxavalonia" >> $links
}
######################################################################
# READ SETTINGS FROM COOKIE: -----------------------------------------
cookie=/userdata/system/switch/extra/batocera-switch-updatersettings
TEXT_SIZE=$(cat $cookie | grep "TEXT_SIZE=" | cut -d "=" -f 2)
TEXT_COLOR=$(cat $cookie | grep "TEXT_COLOR=" | cut -d "=" -f 2)
THEME_COLOR=$(cat $cookie | grep "THEME_COLOR=" | cut -d "=" -f 2)
THEME_COLOR_YUZU=$(cat $cookie | grep "THEME_COLOR_YUZU=" | cut -d "=" -f 2)
THEME_COLOR_YUZUEA=$(cat $cookie | grep "THEME_COLOR_YUZUEA=" | cut -d "=" -f 2)
THEME_COLOR_RYUJINX=$(cat $cookie | grep "THEME_COLOR_RYUJINX=" | cut -d "=" -f 2)
THEME_COLOR_RYUJINXLDN=$(cat $cookie | grep "THEME_COLOR_RYUJINXLDN=" | cut -d "=" -f 2)
THEME_COLOR_RYUJINXAVALONIA=$(cat $cookie | grep "THEME_COLOR_RYUJINXAVALONIA=" | cut -d "=" -f 2)
THEME_COLOR_OK=$(cat $cookie | grep "THEME_COLOR_OK=" | cut -d "=" -f 2)
EMULATORS=$(cat $cookie | grep "EMULATORS=" | cut -d "=" -f 2)
# -------------------------
F=$TEXT_COLOR
T=$THEME_COLOR
# REREAD TEXT/THEME COLORS:
###########################
X='\033[0m'               # / resetcolor
RED='\033[1;31m'          # red
BLUE='\033[1;34m'         # blue
GREEN='\033[1;32m'        # green
YELLOW='\033[1;33m'       # yellow
PURPLE='\033[1;35m'       # purple
CYAN='\033[1;36m'         # cyan
#-------------------------#
DARKRED='\033[0;31m'      # darkred
DARKBLUE='\033[0;34m'     # darkblue
DARKGREEN='\033[0;32m'    # darkgreen
DARKYELLOW='\033[0;33m'   # darkyellow
DARKPURPLE='\033[0;35m'   # darkpurple
DARKCYAN='\033[0;36m'     # darkcyan
#-------------------------#
WHITE='\033[0;37m'        # white
BLACK='\033[0;30m'        # black
###########################
R=$RED
W=$WHITE
# -------------------------
#  override colors: 
   #RED=$X
   #R=$X
   #F=$X
   #W=$X
# -------------------------
clear
echo -e "${R}---------------------------"
echo -e "${F}SWITCH UPDATER FOR BATOCERA${RED}"
echo
resolvelinks & spinner $!
# -------------------------
clear
echo -e "${R}---------------------------"
#echo -e "${W}---------------------------"
echo -e "${F}SWITCH UPDATER FOR BATOCERA"
echo
echo -e "${R}LOADING EMULATORS"
sleep 0.1
# -------------------------
clear
echo -e "${W}-${R} -------------------------"
#echo -e "${R}---------------------------"
echo -e "${F}SWITCH UPDATER FOR BATOCERA"
echo
echo -e "${R} /OADING/EMULATOR/"
sleep 0.1
# -------------------------
clear
echo -e "${W}----${R} ----------------------"
#echo -e "${W}---------------------------"
echo -e "${F}SWITCH UPDATER FOR BATOCERA"
echo
echo -e "${R} LOAD/NGEMU/A/ORS"
sleep 0.1
# -------------------------
clear
echo -e "${W}-------${R} -------------------"
#echo -e "${R}---------------------------"
echo -e "${F}SWITCH UPDATER FOR BATOCERA"
echo
echo -e "${R}  LOA//N/EMU/AT/RS"
sleep 0.1
# -------------------------
clear
echo -e "${W}----------${R} ----------------"
#echo -e "${W}---------------------------"
echo -e "${F}SWITCH UPDATER FOR BATOCERA"
echo
echo -e "${R}  LOAD//EMUL//S"
sleep 0.1
# -------------------------
clear
echo -e "${W}-------------${R} -------------"
#echo -e "${R}---------------------------"
echo -e "${F}SWITCH UPDATER FOR BATOCERA"
echo
echo -e "${R}   LOA///EMU///S"
sleep 0.1
# -------------------------
clear
echo -e "${W}----------------${R} ----------"
#echo -e "${W}---------------------------"
echo -e "${F}SWITCH UPDATER FOR BATOCERA"
echo
echo -e "${R}   /OADNEM/TRS"
sleep 0.1
# -------------------------
clear
echo -e "${W}-------------------${R} -------"
#echo -e "${R}---------------------------"
echo -e "${F}SWITCH UPDATER FOR BATOCERA"
echo
echo -e "${R}   /OA/NEM//RS"
sleep 0.1
# -------------------------
clear
echo -e "${W}----------------------${R} ----"
#echo -e "${W}---------------------------"
echo -e "${F}SWITCH UPDATER FOR BATOCERA"
echo
echo -e "${R}   ///A/NEM///S"
sleep 0.1
# -------------------------
clear
echo -e "${W}-------------------------${R} -"
#echo -e "${R}---------------------------"
echo -e "${F}SWITCH UPDATER FOR BATOCERA"
echo
echo -e "${R}      ///A/N/////S"
sleep 0.1
# -------------------------
clear
echo -e "${W}---------------------------"
echo -e "${W}SWITCH UPDATER FOR BATOCERA"
echo
#echo -e "${RED}   LOADNEMLTRS"
# -------------------------
links=/userdata/system/switch/extra/links
link_yuzu=$(cat "$links" | grep "link_yuzu@" | cut -d "@" -f2 )
link_yuzuea=$(cat "$links" | grep "link_yuzuea@" | cut -d "@" -f2 )
link_ryujinx=$(cat "$links" | grep "link_ryujinx@" | cut -d "@" -f2 )
link_ryujinxldn=$(cat "$links" | grep "link_ryujinxldn@" | cut -d "@" -f2 )
link_ryujinxavalonia=$(cat "$links" | grep "link_ryujinxavalonia@" | cut -d "@" -f2 )
#
# UPDATE 5 EMULATORS -------------------------------------
if [[ "$(echo $EMULATORS | cut -d "=" -f 2 | cut -d "-" -f 5)" != "" ]]; then
update_emulator 1 5 $(echo "$EMULATORS" | cut -d "-" -f 1) "$link_yuzu" "$link_yuzuea" "$link_ryujinx" "$link_ryujinxldn" "$link_ryujinxavalonia"
update_emulator 2 5 $(echo "$EMULATORS" | cut -d "-" -f 2) "$link_yuzu" "$link_yuzuea" "$link_ryujinx" "$link_ryujinxldn" "$link_ryujinxavalonia"
update_emulator 3 5 $(echo "$EMULATORS" | cut -d "-" -f 3) "$link_yuzu" "$link_yuzuea" "$link_ryujinx" "$link_ryujinxldn" "$link_ryujinxavalonia"
update_emulator 4 5 $(echo "$EMULATORS" | cut -d "-" -f 4) "$link_yuzu" "$link_yuzuea" "$link_ryujinx" "$link_ryujinxldn" "$link_ryujinxavalonia"
update_emulator 5 5 $(echo "$EMULATORS" | cut -d "-" -f 5) "$link_yuzu" "$link_yuzuea" "$link_ryujinx" "$link_ryujinxldn" "$link_ryujinxavalonia"
echo
echo -e "${TEXT_COLOR}      ${TEXT_COLOR}5/5${TEXT_COLOR} SWITCH EMULATORS UPDATED ${THEME_COLOR_OK}OK ${W}"
echo -e "${THEME_COLOR}-------------------------------------${X}"
fi
# UPDATE 4 EMULATORS -------------------------------------
if [[ "$(echo $EMULATORS | cut -d "=" -f 2 | cut -d "-" -f 5)" = "" ]] && [[ "$(echo $EMULATORS | cut -d "=" -f 2 | cut -d "-" -f 4)" != "" ]]; then
update_emulator 1 4 $(echo "$EMULATORS" | cut -d "-" -f 1) "$link_yuzu" "$link_yuzuea" "$link_ryujinx" "$link_ryujinxldn" "$link_ryujinxavalonia"
update_emulator 2 4 $(echo "$EMULATORS" | cut -d "-" -f 2) "$link_yuzu" "$link_yuzuea" "$link_ryujinx" "$link_ryujinxldn" "$link_ryujinxavalonia"
update_emulator 3 4 $(echo "$EMULATORS" | cut -d "-" -f 3) "$link_yuzu" "$link_yuzuea" "$link_ryujinx" "$link_ryujinxldn" "$link_ryujinxavalonia"
update_emulator 4 4 $(echo "$EMULATORS" | cut -d "-" -f 4) "$link_yuzu" "$link_yuzuea" "$link_ryujinx" "$link_ryujinxldn" "$link_ryujinxavalonia"
echo
echo -e "${TEXT_COLOR}      ${TEXT_COLOR}4/4${TEXT_COLOR} SWITCH EMULATORS UPDATED ${THEME_COLOR_OK}OK ${W}"
echo -e "${THEME_COLOR}-------------------------------------${X}"
fi
# UPDATE 3 EMULATORS -------------------------------------
if [[ "$(echo $EMULATORS | cut -d "=" -f 2 | cut -d "-" -f 5)" = "" ]] && [[ "$(echo $EMULATORS | cut -d "=" -f 2 | cut -d "-" -f 4)" = "" ]] && [[ "$(echo $EMULATORS | cut -d "=" -f 2 | cut -d "-" -f 3)" != "" ]]; then
update_emulator 1 3 $(echo "$EMULATORS" | cut -d "-" -f 1) "$link_yuzu" "$link_yuzuea" "$link_ryujinx" "$link_ryujinxldn" "$link_ryujinxavalonia"
update_emulator 2 3 $(echo "$EMULATORS" | cut -d "-" -f 2) "$link_yuzu" "$link_yuzuea" "$link_ryujinx" "$link_ryujinxldn" "$link_ryujinxavalonia"
update_emulator 3 3 $(echo "$EMULATORS" | cut -d "-" -f 3) "$link_yuzu" "$link_yuzuea" "$link_ryujinx" "$link_ryujinxldn" "$link_ryujinxavalonia"
echo
echo -e "${TEXT_COLOR}      ${TEXT_COLOR}3/3${TEXT_COLOR} SWITCH EMULATORS UPDATED ${THEME_COLOR_OK}OK ${W}"
echo -e "${THEME_COLOR}-------------------------------------${X}"
fi
# UPDATE 2 EMULATORS -------------------------------------
if [[ "$(echo $EMULATORS | cut -d "=" -f 2 | cut -d "-" -f 5)" = "" ]] && [[ "$(echo $EMULATORS | cut -d "=" -f 2 | cut -d "-" -f 4)" = "" ]] && [[ "$(echo $EMULATORS | cut -d "=" -f 2 | cut -d "-" -f 3)" = "" ]] && [[ "$(echo $EMULATORS | cut -d "=" -f 2 | cut -d "-" -f 2)" != "" ]]; then
update_emulator 1 2 $(echo "$EMULATORS" | cut -d "-" -f 1) "$link_yuzu" "$link_yuzuea" "$link_ryujinx" "$link_ryujinxldn" "$link_ryujinxavalonia"
update_emulator 2 2 $(echo "$EMULATORS" | cut -d "-" -f 2) "$link_yuzu" "$link_yuzuea" "$link_ryujinx" "$link_ryujinxldn" "$link_ryujinxavalonia"
echo
echo -e "${TEXT_COLOR}      ${TEXT_COLOR}2/2${TEXT_COLOR} SWITCH EMULATORS UPDATED ${THEME_COLOR_OK}OK ${W}"
echo -e "${THEME_COLOR}-------------------------------------${X}"
fi
# UPDATE 1 EMULATOR ---------------------------------------
if [[ "$(echo $EMULATORS | cut -d "=" -f 2 | cut -d "-" -f 5)" = "" ]] && [[ "$(echo $EMULATORS | cut -d "=" -f 2 | cut -d "-" -f 4)" = "" ]] && [[ "$(echo $EMULATORS | cut -d "=" -f 2 | cut -d "-" -f 3)" = "" ]] && [[ "$(echo $EMULATORS | cut -d "=" -f 2 | cut -d "-" -f 2)" = "" ]] && [[ "$(echo $EMULATORS | cut -d "=" -f 2 | cut -d "-" -f 1)" != "" ]]; then
update_emulator 1 1 $(echo "$EMULATORS" | cut -d "-" -f 1) "$link_yuzu" "$link_yuzuea" "$link_ryujinx" "$link_ryujinxldn" "$link_ryujinxavalonia"
echo
echo -e "${TEXT_COLOR}                  EMULATOR UPDATED ${THEME_COLOR_OK}OK ${W}"
echo -e "${THEME_COLOR}-------------------------------------${X}"
fi
# --------------------------------------------------------------------
# CLEAR THE OLD V34- CUSTOM.SH LINE IF FOUND AND THE SYSTEM IS NOW VERSION V35+:
# THIS SHOULD HELP WITH UPGRADED VERSIONS AND 'OTHER INSTALLS' 
if [[ "$(uname -a | grep "x86_64")" != "" ]] && [[ "$(uname -a | awk '{print $3}')" > "5.18.00" ]]; then
remove="cat /userdata/system/configs/emulationstation/add_feat_os.cfg /userdata/system/configs/emulationstation/add_feat_switch.cfg"
csh=/userdata/system/custom.sh
  if [[ -e "$csh" ]]; then
tmp=/userdata/system/customsh.tmp
rm $tmp 2>/dev/null
nl=$(cat "$csh" | wc -l)
l=1; while [[ "$l" -le "$nl" ]]; do
ln=$(cat "$csh" | sed ""$l"q;d")
if [[ "$(echo "$ln" | grep "$remove")" != "" ]]; then :; else echo "$ln" >> "$tmp"; fi
((l++))
done
cp "$tmp" "$csh" 2>/dev/null
rm "$tmp" 2>/dev/null
  fi
es=/userdata/system/configs/emulationstation
backup=/userdata/system/switch/extra/backup
mkdir /userdata/system/switch 2>/dev/null
mkdir /userdata/system/switch/extra 2>/dev/null
mkdir /userdata/system/switch/extra/backup 2>/dev/null
# REMOVE OLD ~/CONFIGS/EMULATIONSTATION/files if found & system is now upgraded: 
rm "$es/add_feat_switch.cfg" 2>/dev/null
# --- optionally remove es_features or backup to ~/switch/extra/backup
#rm $es/es_features.cfg 2>/dev/null
#timestamp=$(date +"%y%m%d-%H%M%S")
#mv $es/add_feat_switch.cfg $backup/add_feat_switch.cfg-backup-$timestamp 2>/dev/null
#mv $es/es_features.cfg $backup/es_features.cfg-backup-$timestamp 2>/dev/null
fi
# -------------------------------------------------------------------- 
# REMOVE OLD UPDATERS 
rm /userdata/roms/ports/updateyuzu.sh 2>/dev/null 
rm /userdata/roms/ports/updateyuzuea.sh 2>/dev/null
rm /userdata/roms/ports/updateyuzuEA.sh 2>/dev/null 
rm /userdata/roms/ports/updateryujinx.sh 2>/dev/null
rm /userdata/roms/ports/updateryujinxavalonia.sh 2>/dev/null
# --------------------------------------------------------------------
# AUTOMATICALLY PULL THE LATEST EMULATORS FEATURES UPDATES / ALSO UPDATE THESE FILES: 
url_switchkeys=https://raw.githubusercontent.com/ordovice/batocera-switch/main/system/configs/evmapy/switch.keys
url_es_features_switch=https://raw.githubusercontent.com/ordovice/batocera-switch/main/system/configs/emulationstation/es_features_switch.cfg
url_es_systems_switch=https://raw.githubusercontent.com/ordovice/batocera-switch/main/system/configs/emulationstation/es_systems_switch.cfg
url_switchlauncher=https://raw.githubusercontent.com/ordovice/batocera-switch/main/system/switch/configgen/switchlauncher.py
url_GeneratorImporter=https://raw.githubusercontent.com/ordovice/batocera-switch/main/system/switch/configgen/GeneratorImporter.py
url_ryujinxMainlineGenerator=https://raw.githubusercontent.com/ordovice/batocera-switch/main/system/switch/configgen/generators/ryujinx/ryujinxMainlineGenerator.py
url_yuzuMainlineGenerator=https://raw.githubusercontent.com/ordovice/batocera-switch/main/system/switch/configgen/generators/yuzu/yuzuMainlineGenerator.py
url_sshupdater=https://raw.githubusercontent.com/ordovice/batocera-switch/main/system/switch/extra/batocera-switch-sshupdater.sh
wget -q -O "/userdata/system/configs/evmapy/switch.keys" "$url_switchkeys"
wget -q -O "/userdata/system/configs/emulationstation/es_features_switch.cfg" "$url_es_features_switch"
wget -q -O "/userdata/system/configs/emulationstation/es_systems_switch.cfg" "$url_es_systems_switch"
wget -q -O "/userdata/system/switch/configgen/switchlauncher.py" "$url_switchlauncher"
wget -q -O "/userdata/system/switch/configgen/GeneratorImporter.py" "$url_GeneratorImporter"
#\
# \ download ryujinx generator only if custom ryujinx controller patch is not being used
ryugenpatch=/userdata/system/switch/configgen/generators/ryujinx/ryujinxMainlineGenerator_patched.py
ryugen=/userdata/system/switch/configgen/generators/ryujinx/ryujinxMainlineGenerator.py
ryu382=$(echo "$link_ryujinx" | grep "1.1.382")
ava382=$(echo "$link_ryujinxavalonia" | grep "1.1.382")
origen=$(cat /userdata/system/switch/configgen/generators/ryujinx/ryujinxMainlineGenerator.py | grep "cvalue\['id" | grep "convuuid")
   
   #backup patch gen
   if [[ "$origen" = "" ]]; then
   cp "$ryugen" "$ryugenpatch" 2>/dev/null
   fi
   
   #if frozen   
      if [[ "$ryu382" != "" ]] || [[ "$ava382" != "" ]]; then
         #frozen and ori gen
         if [[ "$origen" != "" ]]; then
         wget -q -O "/userdata/system/switch/configgen/generators/ryujinx/ryujinxMainlineGenerator.py" "$url_ryujinxMainlineGenerator"
         fi
         #frozen and patch gen found, backup
         if [[ "$origen" = "" ]]; then
         cp "$ryugen" "$ryugenpatch" 2>/dev/null
         wget -q -O "/userdata/system/switch/configgen/generators/ryujinx/ryujinxMainlineGenerator.py" "$url_ryujinxMainlineGenerator"
         fi
      fi 
      
   #if unfrozen   
      if [[ "$ryu382" = "" ]] || [[ "$ava382" = "" ]]; then
         #found patch gen found, restore
         if [[ -e "$ryugenpatch" ]]; then
         cp "$ryugenpatch" "$ryugen"
         else 
         wget -q -O "/userdata/system/switch/configgen/generators/ryujinx/ryujinxMainlineGenerator.py" "$url_ryujinxMainlineGenerator"
         fi
      fi 
# / 
#/
wget -q -O "/userdata/system/switch/configgen/generators/yuzu/yuzuMainlineGenerator.py" "$url_yuzuMainlineGenerator"
wget -q -O "/userdata/system/switch/extra/batocera-switch-sshupdater.sh" "$url_sshupdater"
chmod a+x "/userdata/system/switch/extra/batocera-switch-sshupdater.sh"
# --------------------------------------------------------------------
# CLEAR TEMP & COOKIE:
rm -rf /userdata/system/switch/extra/downloads 2>/dev/null
rm /userdata/system/switch/extra/display.settings 2>/dev/null
rm /userdata/system/switch/extra/updater.settings 2>/dev/null
# KEEP OUTPUT FOR VISIBILITY:
sleep 3
curl http://127.0.0.1:1234/reloadgames
killall -9 xterm 2>/dev/null
exit 0
}
export -f batocera_update_switch
######################################################################
# --- include display output: 
killall -9 xterm 2>/dev/null
function get-xterm-fontsize {
url_tput=https://github.com/uureel/batocera-switch/raw/main/system/switch/extra/batocera-switch-tput
url_libtinfo=https://github.com/uureel/batocera-switch/raw/main/system/switch/extra/batocera-switch-libtinfo.so.6
mkdir /userdata/system/switch 2>/dev/null
mkdir /userdata/system/switch/extra 2>/dev/null
extra=/userdata/system/switch/extra
wget -q -O "$extra/batocera-switch-tput" "$url_tput"
wget -q -O "$extra/batocera-switch-libtinfo.so.6" "$url_libtinfo"
cp "$extra/batocera-switch-libtinfo.so.6" "/lib/libtinfo.so.6" 2>/dev/null
cp "$extra/batocera-switch-libtinfo.so.6" "/lib64/libtinfo.so.6" 2>/dev/null
chmod a+x "$extra/batocera-switch-tput" 2>/dev/null
tput=/userdata/system/switch/extra/batocera-switch-tput
cfg=/userdata/system/switch/extra/display.cfg; rm $cfg 2>/dev/null
DISPLAY=:0.0 xterm -fullscreen -fg black -bg black -fa Monospace -en UTF-8 -e bash -c "/userdata/system/switch/extra/batocera-switch-tput cols >> $cfg" 2>/dev/null
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
   TEXT_SIZE=$(bc <<<"scale=0;$cols/16" 2>/dev/null) 2>/dev/null
   if [ "$TEXT_SIZE" = "" ]; then TEXT_SIZE=8; fi
   rm /userdata/system/switch/extra/display.cfg 2>/dev/null
      killall -9 xterm 2>/dev/null
      #####################################################################
      # RUN THE UPDATER: 
      DISPLAY=:0.0 xterm -fs $TEXT_SIZE -fullscreen -fg black -bg black -fa Monospace -en UTF-8 -e bash -c "batocera_update_switch" 2>/dev/null 
###########################################################################
# ssh/xterm (no display)
# batocera_update_switch
###########################################################################
exit 0
######
