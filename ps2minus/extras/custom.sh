#!/bin/bash

p=/userdata/roms/ports
r=/userdata/roms/ps2
c=/userdata/system/configs
a=/userdata/system/pro/ps2minus
x=/userdata/system/pro/ps2minus/extras

mkdir -p $c/emulationstation 2>/dev/null
mkdir -p $c/evmapy 2>/dev/null
mkdir -p $x 2>/dev/null

dos2unix $x/boost.sh 2>/dev/null
dos2unix $x/config.sh.keys 2>/dev/null
dos2unix $x/config.sh 2>/dev/null
dos2unix $x/es_features_ps2minus.cfg 2>/dev/null
dos2unix $x/es_systems_ps2minus.cfg 2>/dev/null
dos2unix $x/launcher.sh 2>/dev/null
dos2unix $x/pcsx2plus.desktop 2>/dev/null
dos2unix $x/ps2minus.keys 2>/dev/null
dos2unix $x/startup.sh 2>/dev/null

chmod a+x $x/boost.sh 2>/dev/null
chmod a+x $x/config.sh 2>/dev/null
chmod a+x $x/launcher.sh 2>/dev/null
chmod a+x $x/pcsx2plus.desktop 2>/dev/null
chmod a+x $x/startup.sh 2>/dev/null

#cp $x/boost.sh $a/ 2>/dev/null
cp "$x/config.sh" "$r/■ CONFIG PS2-.sh" 2>/dev/null
cp "$x/config.sh.keys" "$r/■ CONFIG PS2-.sh.keys" 2>/dev/null
cp $x/es_features_ps2minus.cfg $c/emulationstation/ 2>/dev/null
cp $x/es_systems_ps2minus.cfg $c/emulationstation/ 2>/dev/null
cp $x/launcher.sh $a/ 2>/dev/null
cp $x/pcsx2plus.desktop /usr/share/applications/ 2>/dev/null
cp $x/ps2minus.keys $c/evmapy/ 2>/dev/null
cp $x/ps2+.keys $c/evmapy/ 2>/dev/null
cp $x/ps2+.keys $c/evmapy/ 2>/dev/null

cd $x/
yes "A" | unzip -qq $x/configgen.zip -d $x/
cd ~/ 

mkdir -p $a/pcsx2 2>/dev/null
cd $a/pcsx2
cp -r $x/plugins.zip $a/pcsx2/
yes "A" | unzip -qq $a/pcsx2/plugins.zip -d $a/pcsx2/
cd ~/

# find ps2 bios in /userdata/bios/ and update config file 
ps2bios=$(ls /userdata/bios/ps2-0* | sort | grep "e-" | grep ".bin" | tail -n1)
sed -i '/^BIOS=/c\BIOS=$ps2bios' $x/PCSX2_ui.ini 
mkdir -p /userdata/system/configs/PCSX2/inis 2>/dev/null 
cp $x/PCSX2_ui.ini /userdata/system/configs/PCSX2/inis/PCSX2_ui.ini 2>/dev/null 

fs=$(blkid | grep "LABEL=\"SHARE\"" | sed 's,^.*TYPE=,,g' | sed 's,",,g')
if [[ "$fs" = "ext4" ]] || [[ "$fs" = "btrfs" ]]; then 
mkdir -p /userdata/system/.config/PCSX2/ 2>/dev/null
rm -rf /userdata/system/.config/PCSX2/bios 2>/dev/null
ln -s /userdata/bios /userdata/system/.config/PCSX2/bios 2>/dev/null 
fi

/userdata/system/pro/ps2minus/extras/startup.sh 

curl http://127.0.0.1:1234/reloadgames 
