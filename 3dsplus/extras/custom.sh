#!/bin/bash

p=/userdata/roms/ports
r=/userdata/roms/3ds
c=/userdata/system/configs
a=/userdata/system/pro/3dsplus
x=/userdata/system/pro/3dsplus/extras

mkdir -p $c/emulationstation 2>/dev/null
mkdir -p $c/evmapy 2>/dev/null
mkdir -p $x 2>/dev/null
mkdir -p $r/citra 2>/dev/null

dos2unix $x/boost.sh 2>/dev/null
dos2unix $x/config.sh.keys 2>/dev/null
dos2unix $x/config.sh 2>/dev/null
dos2unix $x/es_features_3dsplus.cfg 2>/dev/null
dos2unix $x/es_systems_3dsplus.cfg 2>/dev/null
dos2unix $x/launcher.sh 2>/dev/null
dos2unix $x/3dsplus.desktop 2>/dev/null
dos2unix $x/3dsplus.keys 2>/dev/null
dos2unix $x/startup.sh 2>/dev/null

chmod a+x $x/boost.sh 2>/dev/null
chmod a+x $x/config.sh 2>/dev/null
chmod a+x $x/launcher.sh 2>/dev/null
chmod a+x $x/3dsplus.desktop 2>/dev/null
chmod a+x $x/startup.sh 2>/dev/null
chmod a+x $x/rev 2>/dev/null
chmod a+x $x/startx 2>/dev/null
chmod a+x $x/xinitrc 2>/dev/null
chmod a+x $x/xdotool 2>/dev/null

#cp $x/boost.sh $a/ 2>/dev/null
cp "$x/config.sh" "$r/■ CONFIG.sh" 2>/dev/null
cp "$x/config.sh.keys" "$r/■ CONFIG.sh.keys" 2>/dev/null
cp $x/es_features_3dsplus.cfg $c/emulationstation/ 2>/dev/null
cp $x/es_systems_3dsplus.cfg $c/emulationstation/ 2>/dev/null
cp $x/launcher.sh $a/ 2>/dev/null
cp $x/3dsplus.desktop /usr/share/applications/ 2>/dev/null
cp $x/3dsplus.keys $c/evmapy/ 2>/dev/null
cp $x/3ds+.keys $c/evmapy/ 2>/dev/null

cd $x/ 
yes "A" | unzip -qq $x/configgen.zip -d $x/ 
cd ~/ 

chmod a+x $x/*.sh 2>/dev/null

# backup saves 
# timestamp=$(date +"%y%m%d-%H%M%S") 
#mkdir /userdata/saves/ps3-backup 2>/dev/null 
#rsync -au /userdata/saves/ps3/ /userdata/saves/ps3-backup/ 2>/dev/null 

/userdata/system/pro/3dsplus/extras/startup.sh 

curl http://127.0.0.1:1234/reloadgames 
