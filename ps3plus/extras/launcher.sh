#!/bin/bash

# get rom from generator: 
	ROM="$(echo "$1")"

# check if *.psn 
	chmod a+x /userdata/system/pro/ps3plus/extras/rev 2>/dev/null
		if [[ "$(echo "$ROM" | /userdata/system/pro/ps3plus/extras/rev | cut -c 1-4 | /userdata/system/pro/ps3plus/extras/rev)" = ".psn" ]]; then 
			ID="$(cat "$ROM" | head -n 1 | tr 'a-z' 'A-Z')"
			ROM="/userdata/system/configs/rpcs3/dev_hdd0/game/$ID/USRDIR/EBOOT.BIN"
		fi

# prepare logs: 
	log1=/userdata/system/logs/ps3plus-out.txt
	log2=/userdata/system/logs/ps3plus-err.txt
		rm $log1 2>/dev/null
		rm $log2 2>/dev/null

# prepare *.ai: 
	chmod a+x /userdata/system/pro/ps3plus/rpcs3/rpcs3.AppImage

# cookies: 
	export XDG_CONFIG_HOME=/userdata/system/configs
	export XDG_CACHE_HOME=/userdata/system/cache
	export QT_QPA_PLATFORM=xcb
	export AMD_VULKAN_ICD=RADV
	export DISABLE_LAYER_AMD_SWITCHABLE_GRAPHICS_1=1
	export XDG_MENU_PREFIX=batocera- 
	export XDG_CONFIG_DIRS=/etc/xdg 
	export XDG_CURRENT_DESKTOP=XFCE 
	export DESKTOP_SESSION=XFCE 

# prepare booster:
/userdata/system/pro/ps3plus/extras/boost.sh 2>/dev/null & 

# start appimage: 
if [[ "$(echo "$ROM" | grep "CONFIG")" != "" ]] || [[ "$(echo "$ROM")" = "" ]]; then
	unclutter-remote -s; 
		DISPLAY=:0.0 \
		QT_FONT_DPI=128 \
		XDG_CONFIG_HOME=/userdata/system/configs \
		XDG_CACHE_HOME=/userdata/system/cache \
		QT_QPA_PLATFORM=xcb \
		AMD_VULKAN_ICD=RADV \
		DISABLE_LAYER_AMD_SWITCHABLE_GRAPHICS_1=1 \
			/userdata/system/pro/ps3plus/rpcs3/rpcs3.AppImage > >(tee "$log1") 2> >(tee "$log2" >&2)
else 
		DISPLAY=:0.0 \
		QT_FONT_DPI=128 \
		XDG_CONFIG_HOME=/userdata/system/configs \
		XDG_CACHE_HOME=/userdata/system/cache \
		QT_QPA_PLATFORM=xcb \
		AMD_VULKAN_ICD=RADV \
		DISABLE_LAYER_AMD_SWITCHABLE_GRAPHICS_1=1 \
			/userdata/system/pro/ps3plus/rpcs3/rpcs3.AppImage --no-gui "$ROM" > >(tee "$log1") 2> >(tee "$log2" >&2)
fi


