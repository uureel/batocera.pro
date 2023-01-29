#!/bin/bash

p=/userdata/roms/ports
r=/userdata/roms/ps3
c=/userdata/system/configs
a=/userdata/system/pro/ps3plus
x=/userdata/system/pro/ps3plus/extras

mkdir -p $c/emulationstation 2>/dev/null
mkdir -p $c/evmapy 2>/dev/null
mkdir -p $x 2>/dev/null

dos2unix $x/boost.sh 2>/dev/null
dos2unix $x/config.sh.keys 2>/dev/null
dos2unix $x/config.sh 2>/dev/null
dos2unix $x/es_features_ps3plus.cfg 2>/dev/null
dos2unix $x/es_systems_ps3plus.cfg 2>/dev/null
dos2unix $x/launcher.sh 2>/dev/null
dos2unix $x/rpcs3plus.desktop 2>/dev/null
dos2unix $x/ps3plus.keys 2>/dev/null
dos2unix $x/startup.sh 2>/dev/null

chmod a+x $x/boost.sh 2>/dev/null
chmod a+x $x/config.sh 2>/dev/null
chmod a+x $x/launcher.sh 2>/dev/null
chmod a+x $x/rpcs3plus.desktop 2>/dev/null
chmod a+x $x/startup.sh 2>/dev/null

cp $x/boost.sh $a/ 2>/dev/null
cp "$x/config.sh" "$r/■ CONFIG.sh" 2>/dev/null
cp "$x/config.sh.keys" "$r/■ CONFIG.sh.keys" 2>/dev/null
cp $x/es_features_ps3plus.cfg $c/emulationstation/ 2>/dev/null
cp $x/es_systems_ps3plus.cfg $c/emulationstation/ 2>/dev/null
cp $x/launcher.sh $a/ 2>/dev/null
cp $x/rpcs3plus.desktop /usr/share/applications/ 2>/dev/null
cp $x/ps3plus.keys $c/evmapy/ 2>/dev/null

cd $x/
yes "A" | unzip -qq $x/configgen.zip -d $x/
cd ~/ 

# backup saves
timestamp=$(date +"%y%m%d-%H%M%S") 
cp -r /userdata/saves/ps3 /userdata/saves/ps3-backup-$timestamp 2>/dev/null

# link saves 
fs=$(blkid | grep "LABEL=\"SHARE\"" | sed 's,^.*TYPE=,,g' | sed 's,",,g')
if [[ "$fs" = "ext4" ]] || [[ "$fs" = "btrfs" ]]; then 
	
	mkdir -p /userdata/system/.config/PCSX2/ 2>/dev/null
	rm -rf /userdata/system/.config/PCSX2/bios 2>/dev/null
	ln -s /userdata/bios /userdata/system/.config/PCSX2/bios 2>/dev/null 

	if [[ -d "/userdata/system/configs/rpcs3/dev_hdd0/savedata" ]]; then 
	cp -r /userdata/system/configs/rpcs3/dev_hdd0/savedata /userdata/system/pro/rpcs3/backup/savedata-backup-$timestamp 2>/dev/null
	fi
	if [[ -d "/userdata/system/.config/rpcs3/dev_hdd0/savedata" ]]; then 
	cp -r /userdata/system/.config/rpcs3/dev_hdd0/savedata /userdata/system/pro/rpcs3/backup/savedata-backup-$timestamp 2>/dev/null
	fi
	
		rm -r /userdata/system/.config/rpcs3/dev_hdd0/savedata 2>/dev/null
		rm -r /userdata/system/configs/rpcs3/dev_hdd0/savedata 2>/dev/null
		mkdir -p /userdata/system/.config/rpcs3/dev_hdd0 2>/dev/null
		mkdir -p /userdata/system/configs/rpcs3/dev_hdd0 2>/dev/null
		ln -s /userdata/saves/ps3 /userdata/system/configs/rpcs3/dev_hdd0/savedata 2>/dev/null
		ln -s /userdata/saves/ps3 /userdata/system/.config/rpcs3/dev_hdd0/savedata 2>/dev/null
		rsync -au /userdata/saves/ps3-backup-$timestamp/ /userdata/saves/ps3/ 2>/dev/null
		sleep 0.1
fi

/userdata/system/pro/ps3plus/extras/startup.sh 

curl http://127.0.0.1:1234/reloadgames 
