#!/bin/bash

##
# check conty version md5
conty="/userdata/system/pro/steam/conty.sh"
md5="$(head -c 4000000 "${conty}" | md5sum | head -c 7)"_"$(tail -c 1000000 "${conty}" | md5sum | head -c 7)"

##
# reload ld
if [[ -s /userdata/system/.local/share/Conty/nvidia/.active ]]; then
  v="$(cat /userdata/system/.local/share/Conty/nvidia/.active | head -n1)"
	if [[ -s /userdata/system/.local/share/Conty/nvidia/ld.so.cache-$v-$md5 ]]; then
		cp -r /userdata/system/.local/share/Conty/nvidia/ld.so.cache-$v-$md5 /userdata/system/.local/share/Conty/overlayfs_$md5/up/etc/ld.so.cache &
	else
		ldconfig 1>/dev/null 2>/dev/null
			mkdir -p /userdata/system/.local/share/Conty/nvidia 2>/dev/null
			mkdir -p /userdata/system/.local/share/Conty/overlayfs_$md5/up/etc 2>/dev/null
			  cp -r /etc/ld.so.cache /userdata/system/.local/share/Conty/nvidia/ld.so.cache-$v-$md5 &
			  cp -r /etc/ld.so.cache /userdata/system/.local/share/Conty/overlayfs_$md5/up/etc/ld.so.cache &
			  	wait
	fi
fi

##
# check prime env
p=/userdata/system/.local/share/Conty/.conty-prime
	if [[ -s "$p" ]]; then
		dos2unix "$p" 2>/dev/null
			__NV_PRIME_RENDER_OFFLOAD_="$(cat "$p" | grep '__NV_PRIME_RENDER_OFFLOAD' | cut -d "=" -f2)"
			__VK_LAYER_NV_optimus_="$(cat "$p" | grep '__VK_LAYER_NV_optimus' | cut -d "=" -f2)"
			__GLX_VENDOR_LIBRARY_NAME_="$(cat "$p" | grep '__GLX_VENDOR_LIBRARY_NAME' | cut -d "=" -f2)"
			DRI_PRIME_="$(cat "$p" | grep 'DRI_PRIME' | cut -d "=" -f2)"
			debug_="$(cat "$p" | grep 'debug' | cut -d "=" -f2)"
	fi
		if [[ "$__NV_PRIME_RENDER_OFFLOAD_" != "" ]]; then
			export __NV_PRIME_RENDER_OFFLOAD="$__NV_PRIME_RENDER_OFFLOAD_"
		fi
		if [[ "$__VK_LAYER_NV_optimus_" != "" ]]; then
			export __VK_LAYER_NV_optimus="$__VK_LAYER_NV_optimus_"
		fi
		if [[ "$__GLX_VENDOR_LIBRARY_NAME_" != "" ]]; then
			export __GLX_VENDOR_LIBRARY_NAME="$__GLX_VENDOR_LIBRARY_NAME_"
		fi
		if [[ "$DRI_PRIME_" != "" ]]; then
			export DRI_PRIME="$DRI_PRIME_"
			#export AMD_VULKAN_ICD=RADV
			#export DISABLE_LAYER_AMD_SWITCHABLE_GRAPHICS_1=1
		fi
		if [[ "$debug_" != "" ]]; then
			export debug="$debug_"
		fi

##
# remaining env
export XDG_CURRENT_DESKTOP=XFCE
export DESKTOP_SESSION=XFCE
export QT_SCALE_FACTOR=1 
export QT_FONT_DPI=96
export GDK_SCALE=1
export DISPLAY=:0.0
export GTK_A11Y=none
export NO_AT_BRIDGE=1
eval "$(dbus-launch --sh-syntax)"
