#!/bin/bash

cd /userdata/system/

rm /userdata/system/configs/emulationstation/es_systems_ps3plus.cfg 2>/dev/null 
rm /userdata/system/configs/emulationstation/es_features_ps3plus.cfg 2>/dev/null 
rm /userdata/system/configs/evmapy/ps3plus.keys 2>/dev/null 
rm /usr/share/applications/rpcs3plus.desktop 2>/dev/null 
rm /userdata/system/pro/ps3plus/extras/startup.sh 2>/dev/null  
rm "/userdata/roms/ps3/■ CONFIG.sh" 2>/dev/null  
rm "/userdata/roms/ps3/■ CONFIG.sh.keys" 2>/dev/null  
rm -rf /userdata/system/pro/ps3plus 2>/dev/null 

curl http://127.0.0.1:1234/reloadgames 
