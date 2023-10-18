#!/bin/bash

# get rom from generator: 
	ROM="$(echo "$1")"

# prepare logs: 
	logs=/userdata/system/logs
	log="$logs/wiiuplus.txt"
	log1="$logs/wiiuplus-out.txt"
	log2="$logs/wiiuplus-err.txt"
	rm $log $log1 $log2 2>/dev/null

# prepare *.ai: 
	chmod 777 /userdata/system/pro/wiiuplus/cemu/cemu.AppImage 2>/dev/null

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
/userdata/system/pro/wiiuplus/extras/boost.sh 2>/dev/null & 

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
			/userdata/system/pro/wiiuplus/cemu/cemu.AppImage > >(tee "$log1") 2> >(tee "$log2" >&2)
else 
		DISPLAY=:0.0 \
		QT_FONT_DPI=128 \
		XDG_CONFIG_HOME=/userdata/system/configs \
		XDG_CACHE_HOME=/userdata/system/cache \
		QT_QPA_PLATFORM=xcb \
		AMD_VULKAN_ICD=RADV \
		DISABLE_LAYER_AMD_SWITCHABLE_GRAPHICS_1=1 \
			/userdata/system/pro/wiiuplus/cemu/cemu.AppImage -f -g "$ROM" > >(tee "$log1") 2> >(tee "$log2" >&2)
fi
