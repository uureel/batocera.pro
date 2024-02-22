#!/bin/bash

if [[ "$(uname -m)" != "x86_64" ]] || [[ "$(which flatpak)" == *"not found"* ]]; then
  echo "this system is not supported." 
  exit 1
fi

if [[ "$(flatpak list | grep 'net.sapples.LiveCaptions')" = "" ]]; then
  echo -e "\ninstalling livecaptions flatpak...\n" 
  flatpak install --system -y net.sapples.LiveCaptions
  if [[ "$(flatpak list | grep 'net.sapples.LiveCaptions')" != "" ]]; then
    echo -e "\nlivecaptions flatpak installed.\n" 
  else
    echo -e "\nlivecaptions flatpak install failed. exiting.\n" 
    exit 1
  fi  	
fi

d=/userdata/system/pro/livecaptions
mkdir -p $d/extra 2>/dev/null
f=$d/extra/batocera-compositor
wget -q --tries=10 --no-check-certificate --no-cache --no-cookies -O $f http://batocera.pro/app/batocera-compositor
chmod 777 $f 2>/dev/null
