#!/bin/bash

cd /userdata/system/

rm /userdata/system/configs/emulationstation/es_systems_ps2plus.cfg 2>/dev/null 
rm /userdata/system/configs/emulationstation/es_features_ps2plus.cfg 2>/dev/null 
rm /userdata/system/configs/evmapy/ps2plus.keys 2>/dev/null 
rm /usr/share/applications/pcsx2plus.desktop 2>/dev/null 
rm /userdata/system/pro/ps2plus/extras/startup.sh 2>/dev/null  
rm "/userdata/roms/ps2/■ CONFIG.sh" 2>/dev/null  
rm "/userdata/roms/ps2/■ CONFIG.sh.keys" 2>/dev/null  
rm -rf /userdata/system/pro/ps2plus 2>/dev/null 

curl http://127.0.0.1:1234/reloadgames 
