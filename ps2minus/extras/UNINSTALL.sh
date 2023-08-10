#!/bin/bash

cd /userdata/system/

rm /userdata/system/configs/emulationstation/es_systems_ps2minus.cfg 2>/dev/null 
rm /userdata/system/configs/emulationstation/es_features_ps2minus.cfg 2>/dev/null 
rm /userdata/system/configs/evmapy/ps2minus.keys 2>/dev/null 
rm /usr/share/applications/pcsx2minus.desktop 2>/dev/null 
rm /userdata/system/pro/ps2minus/extras/startup.sh 2>/dev/null  
rm "/userdata/roms/ps2/■ CONFIG PS2-.sh" 2>/dev/null  
rm "/userdata/roms/ps2/■ CONFIG PS2-.sh.keys" 2>/dev/null  
rm -rf /userdata/system/pro/ps2minus 2>/dev/null 

curl http://127.0.0.1:1234/reloadgames 
