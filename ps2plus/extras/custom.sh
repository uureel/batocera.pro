#!/bin/bash

p=/userdata/roms/ports
r=/userdata/roms/ps2
c=/userdata/system/configs
a=/userdata/system/pro/ps2plus
x=/userdata/system/pro/ps2plus/extras

mkdir -p $c/emulationstation 2>/dev/null
mkdir -p $c/evmapy 2>/dev/null
mkdir -p $x 2>/dev/null

dos2unix $x/boost.sh 2>/dev/null
dos2unix $x/config.sh.keys 2>/dev/null
dos2unix $x/config.sh 2>/dev/null
dos2unix $x/es_features_ps2plus.cfg 2>/dev/null
dos2unix $x/es_systems_ps2plus.cfg 2>/dev/null
dos2unix $x/launcher.sh 2>/dev/null
dos2unix $x/pcsx2plus.desktop 2>/dev/null
dos2unix $x/ps2plus.keys 2>/dev/null
dos2unix $x/startup.sh 2>/dev/null

chmod a+x $x/boost.sh 2>/dev/null
chmod a+x $x/config.sh 2>/dev/null
chmod a+x $x/launcher.sh 2>/dev/null
chmod a+x $x/pcsx2plus.desktop 2>/dev/null
chmod a+x $x/startup.sh 2>/dev/null

#cp $x/boost.sh $a/ 2>/dev/null
cp "$x/config.sh" "$r/■ CONFIG.sh" 2>/dev/null
cp "$x/config.sh.keys" "$r/■ CONFIG.sh.keys" 2>/dev/null
cp $x/es_features_ps2plus.cfg $c/emulationstation/ 2>/dev/null
cp $x/es_systems_ps2plus.cfg $c/emulationstation/ 2>/dev/null
cp $x/launcher.sh $a/ 2>/dev/null
cp $x/pcsx2plus.desktop /usr/share/applications/ 2>/dev/null
cp $x/ps2plus.keys $c/evmapy/ 2>/dev/null
cp $x/ps2+.keys $c/evmapy/ 2>/dev/null

cd $x/
yes "A" | unzip -qq $x/configgen.zip -d $x/
cd ~/ 

fs=$(blkid | grep "LABEL=\"SHARE\"" | sed 's,^.*TYPE=,,g' | sed 's,",,g')
if [[ "$fs" = "ext4" ]] || [[ "$fs" = "btrfs" ]]; then 
mkdir -p /userdata/system/.config/PCSX2/ 2>/dev/null
rm -rf /userdata/system/.config/PCSX2/bios 2>/dev/null
ln -s /userdata/bios /userdata/system/.config/PCSX2/bios 2>/dev/null 
fi

/userdata/system/pro/ps2plus/extras/startup.sh 

curl http://127.0.0.1:1234/reloadgames 
