#!/bin/bash

if [[ "$(uname -m)" != "x86_64" ]] || [[ "$(which flatpak)" == *"not found"* ]]; then
  echo "this system is not supported." 
    exit 1
fi

echo -e "\ninstalling batocera-livecaptions...\n" 

killall -9 livecaptions 2>/dev/null

if [[ "$(flatpak list | grep 'net.sapples.LiveCaptions')" = "" ]]; then
  echo -e "\ninstalling livecaptions flatpak...\n" 
  flatpak install --system -y net.sapples.LiveCaptions
    if [[ "$(flatpak list | grep 'net.sapples.LiveCaptions')" != "" ]]; then
      echo -e "\nlivecaptions flatpak installed.\n" 
    else
      echo -e "\nlivecaptions flatpak install failed? :( exiting.\n" 
      echo -e "\ntry manually installing:"
      echo -e "flatpak installnet.sapples.LiveCaptions" 
      echo -e "flatpak update"
      echo -e "\nthen try running this installer again...\n" 
        exit 1
    fi  	
fi

d=/userdata/system/pro/livecaptions
  mkdir -p $d/extra 2>/dev/null

f=$d/extra/batocera-compositor
  wget -q --show-progress --tries=10 --no-check-certificate --no-cache --no-cookies -O $f https://github.com/uureel/batocera.pro/raw/main/livecaptions/extra/batocera-compositor
  chmod 777 $f 2>/dev/null
f=$d/extra/batocera-compositor
  wget -q --show-progress --tries=10 --no-check-certificate --no-cache --no-cookies -O $f https://github.com/uureel/batocera.pro/raw/main/livecaptions/extra/batocera-compositor
  chmod 777 $f 2>/dev/null
f=$d/extra/batocera-rc.xml
  wget -q --show-progress --tries=10 --no-check-certificate --no-cache --no-cookies -O $f https://raw.githubusercontent.com/uureel/batocera.pro/main/livecaptions/extra/batocera-rc.xml
  dos2unix "$f" 2>/dev/null
f=$d/extra/livecaptions-rc.xml
  wget -q --show-progress --tries=10 --no-check-certificate --no-cache --no-cookies -O $f https://raw.githubusercontent.com/uureel/batocera.pro/main/livecaptions/extra/livecaptions-rc.xml
  dos2unix "$f" 2>/dev/null
f=$d/README.txt
  wget -q --show-progress --tries=10 --no-check-certificate --no-cache --no-cookies -O $f https://raw.githubusercontent.com/uureel/batocera.pro/main/livecaptions/README.txt
  dos2unix "$f" 2>/dev/null
f=$d/extra/xdotool
  wget -q --show-progress --tries=10 --no-check-certificate --no-cache --no-cookies -O $f https://raw.githubusercontent.com/uureel/batocera.pro/main/livecaptions/extra/xdotool
  chmod 777 "$f" 2>/dev/null
f=$d/extra/wmctrl
  wget -q --show-progress --tries=10 --no-check-certificate --no-cache --no-cookies -O $f https://raw.githubusercontent.com/uureel/batocera.pro/main/livecaptions/extra/wmctrl
  chmod 777 "$f" 2>/dev/null
f=$d/extra/start.sh
  wget -q --show-progress --tries=10 --no-check-certificate --no-cache --no-cookies -O $f https://raw.githubusercontent.com/uureel/batocera.pro/main/livecaptions/extra/start.sh
  dos2unix "$f" 2>/dev/null
  chmod 777 "$f" 2>/dev/null
f=$d/extra/stop.sh
  wget -q --show-progress --tries=10 --no-check-certificate --no-cache --no-cookies -O $f https://raw.githubusercontent.com/uureel/batocera.pro/main/livecaptions/extra/stop.sh
  dos2unix "$f" 2>/dev/null
  chmod 777 "$f" 2>/dev/null
f=$d/extra/move.sh
  wget -q --show-progress --tries=10 --no-check-certificate --no-cache --no-cookies -O $f https://raw.githubusercontent.com/uureel/batocera.pro/main/livecaptions/extra/move.sh
  dos2unix "$f" 2>/dev/null
  chmod 777 "$f" 2>/dev/null
f=$d/extra/watcher.sh
  wget -q --show-progress --tries=10 --no-check-certificate --no-cache --no-cookies -O $f https://raw.githubusercontent.com/uureel/batocera.pro/main/livecaptions/extra/watcher.sh
  dos2unix "$f" 2>/dev/null
  chmod 777 "$f" 2>/dev/null
f=$d/extra/service.sh
  wget -q --show-progress --tries=10 --no-check-certificate --no-cache --no-cookies -O $f https://raw.githubusercontent.com/uureel/batocera.pro/main/livecaptions/extra/service.sh
  dos2unix "$f" 2>/dev/null
  chmod 777 "$f" 2>/dev/null
  cp "$f" /userdata/system/services/livecaptions 2>/dev/null

if [[ "$(batocera-services list | grep 'livecaptions')" != "" ]]; then
  batocera-services stop livecaptions 2>/dev/null
  batocera-services disable livecaptions 2>/dev/null
  batocera-services enable livecaptions 2>/dev/null
  batocera-services start livecaptions 2>/dev/null
fi

echo 
echo "installed ok."
echo
echo "|||||||||||||||||||||||||||||||||||||||||||||||||||"
echo "|                                                 |"
echo "|                                                 |"
echo "|    livecaptions is a batocera SERVICE add-on    |"
echo "|                                                 |"
echo "|                                                 |"
echo "|    to start it, or stop it, use                 |"
echo "|    SYSTEM SETTINGS > SERVICES > LIVECAPTIONS    |"
echo "|                                                 |"
echo "|                                                 |"
echo "|||||||||||||||||||||||||||||||||||||||||||||||||||"
echo
echo

sleep 5

exit 0

