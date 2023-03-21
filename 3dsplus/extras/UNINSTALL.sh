#!/bin/bash

cd /userdata/system/

rm /userdata/system/configs/emulationstation/es_systems_3dsplus.cfg 2>/dev/null 
rm /userdata/system/configs/emulationstation/es_features_3dsplus.cfg 2>/dev/null 
rm /userdata/system/configs/evmapy/3dsplus.keys 2>/dev/null 
rm /usr/share/applications/3dsplus.desktop 2>/dev/null 
rm /userdata/system/pro/3dsplus/extras/startup.sh 2>/dev/null  
rm "/userdata/roms/3ds/■ CONFIG.sh" 2>/dev/null  
rm "/userdata/roms/3ds/■ CONFIG.sh.keys" 2>/dev/null  
rm -rf /userdata/system/pro/3dsplus 2>/dev/null 

curl http://127.0.0.1:1234/reloadgames 2>/dev/null
