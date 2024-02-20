#!/bin/bash

##
# reload ld
ldconfig 1>/dev/null 2>/dev/null
  mkdir -p /userdata/system/.local/share/Conty/ld/ 2>/dev/null
    cp -r /etc/ld.so* /userdata/system/.local/share/Conty/ld/ 2>/dev/null

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
		fi
		if [[ "$debug_" != "" ]]; then
			export debug="$debug_"
		fi

##
# remaining env
export DISPLAY=:0.0
eval $(dbus-launch --sh-syntax)
