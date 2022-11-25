#!/usr/bin/env bash 
function set-rpcs3-version {
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
# paths for batocera.pro:
pro=/userdata/system/pro
rm $pro/rpcs3/extra/whichrpcs3.cfg 2>/dev/null
echo "/userdata/system/pro/rpcs3/backup/rpcs3" >> $pro/rpcs3/extra/whichrpcs3.cfg 2>/dev/null
version=$(/userdata/system/pro/rpcs3/backup/rpcs3 --version 2>/dev/null | grep RPCS3 | cut -d " " -f 2 | tr -d \")
if [ "$version" = "" ]; then
version="not found"
fi 
######################################################################
clear
echo
echo
echo
echo -e "${W}RPCS3  ${G}>${W}  USE BATOCERA VERSION${G} $version ${W}"
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
echo -e "${W}RPCS3  ${G}>${W}  USE BATOCERA VERSION${G} $version ${W}"
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
echo -e "${W}RPCS3  ${G}>${W}  USE BATOCERA VERSION${G} $version ${W}"
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
echo -e "${W}RPCS3  ${G}>${W}  USE BATOCERA VERSION${G} $version ${W}"
echo
echo
echo -e "${L}--------------------------------------------------------"
echo
######################################################################
sleep 1.1
curl http://127.0.0.1:1234/reloadgames
}
# --------------------------------------------------------------------
  export -f set-rpcs3-version 2>/dev/null
# --------------------------------------------------------------------
# include display output: 
function get-xterm-fontsize { 
tput=/userdata/system/pro/rpcs3/extra/tput; chmod a+x $tput; 
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
  DISPLAY=:0.0 xterm -fullscreen -bg black -fa 'Monospace' -fs $TEXT_SIZE -e bash -c "set-rpcs3-version" 2>/dev/null
# --------------------------------------------------------------------
