#!/bin/bash
# ----------------------------------------------------
# check conty version md5
	conty="/userdata/system/pro/steam/conty.sh"
	md5="$(head -c 4000000 "$conty" | md5sum | head -c 7)"_"$(tail -c 1000000 "$conty" | md5sum | head -c 7)"
	C=/userdata/system/.local/share/Conty
# ----------------------------------------------------
# check prime env
	p=$C/.conty-prime
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
# ----------------------------------------------------
# remaining env
 	if [[ -e /opt/cuda/bin ]]; then
		if [[ -e /opt/cuda/targets/x86_64-linux/lib ]]; then
		    export LD_LIBRARY_PATH="/opt/cuda/targets/x86_64-linux/lib:$LD_LIBRARY_PATH"
		fi
		if [[ -e /opt/cuda/targets/x86_64-linux/include ]]; then
		    export CPATH="/opt/cuda/targets/x86_64-linux/include:$CPATH"
		fi
  		export PATH="/opt/cuda/bin:$PATH"
		export CUDA_HOME=/opt/cuda
    		export CUDADIR=/opt/cuda
  	fi
	export XDG_CURRENT_DESKTOP=XFCE
	export DESKTOP_SESSION=XFCE
	export QT_SCALE_FACTOR=1 
	export QT_FONT_DPI=96
	export GDK_SCALE=1
	export DISPLAY=:0.0
# ----------------------------------------------------
# bump limits
  sysctl -w fs.inotify.max_user_watches=8192000 vm.max_map_count=2147483642 fs.file-max=8192000 >/dev/null 2>&1
  ulimit -H -n 819200 && ulimit -S -n 819200
