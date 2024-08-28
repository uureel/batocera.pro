#!/bin/bash
# ----------------------------------------------------
# don't run this outside conty/inside batocera
	if [[ -s /usr/bin/batocera-version ]] && [[ -s /usr/bin/batocera-support ]]; then
	  echo -e "\nthis script should only run inside conty!\n"
	  exit 1
	fi
# ----------------------------------------------------
# check conty version md5
	conty="/userdata/system/pro/steam/conty.sh"
	md5="$(head -c 4000000 "$conty" | md5sum | head -c 7)"_"$(tail -c 1000000 "$conty" | md5sum | head -c 7)"
	C=/userdata/system/.local/share/Conty
# ----------------------------------------------------
# reload group & passwd
	if [[ -s $C/group ]]; then
		dos2unix $C/group 2>/dev/null
		chmod 777 $C/group 2>/dev/null
	  mkdir -p $C/overlayfs_$md5/up/etc 2>/dev/null
	  cp -r $C/group $C/overlayfs_$md5/up/etc/ 2>/dev/null
	  cp -r $C/group /etc/ 2>/dev/null
	fi
	if [[ -s $C/passwd ]]; then
		dos2unix $C/passwd 2>/dev/null
		chmod 777 $C/passwd 2>/dev/null
	  mkdir -p $C/overlayfs_$md5/up/etc 2>/dev/null
	  cp -r $C/passwd $C/overlayfs_$md5/up/etc/ 2>/dev/null
	  cp -r $C/passwd /etc/ 2>/dev/null
	fi
# ----------------------------------------------------
# reload ld
        cd /usr/lib
        [[ -e /usr/lib/libGLX.so.0.0.0 ]] && ln -sf libGLX.so.0.0.0 libGLX.so.0 2>/dev/null
        [[ -e /usr/lib/libOpenGL.so.0.0.0 ]] && ln -sf libOpenGL.so.0.0.0 libOpenGL.so.0 2>/dev/null
        [[ -e /usr/lib/libGLdispatch.so.0.0.0 ]] && ln -sf libGLdispatch.so.0.0.0 libGLdispatch.so.0 2>/dev/null
        cd ~/
        cd /usr/lib32
        [[ -e /usr/lib32/libGLX.so.0.0.0 ]] && ln -sf libGLX.so.0.0.0 libGLX.so.0 2>/dev/null
        [[ -e /usr/lib32/libOpenGL.so.0.0.0 ]] && ln -sf libOpenGL.so.0.0.0 libOpenGL.so.0 2>/dev/null
        [[ -e /usr/lib32/libGLdispatch.so.0.0.0 ]] && ln -sf libGLdispatch.so.0.0.0 libGLdispatch.so.0 2>/dev/null
        cd ~/	
	if [[ -s $C/nvidia/.active ]]; then
	  v="$(cat $C/nvidia/.active | head -n1)"
	  if [[ -s $C/nvidia/ld.so.cache-$v-$md5 ]]; then
	    cp -r $C/nvidia/ld.so.cache-$v-$md5 $C/overlayfs_$md5/up/etc/ld.so.cache 2>/dev/null
	  else
	    ldconfig 1>/dev/null 2>/dev/null
	      mkdir -p $C/nvidia 2>/dev/null
	      mkdir -p $C/overlayfs_$md5/up/etc 2>/dev/null
	        cp -r /etc/ld.so.cache $C/nvidia/ld.so.cache-$v-$md5 2>/dev/null
	  fi
	  #
   		function off() {
	  	# patch nv drivers for nvenc support // disabled because it borks cuda, fu nv
				#------------------------------------
		  	patch="$C/overlayfs_$md5/up/bin/nvidia-patch.sh"
				  if [[ ! -s "$patch" ]]; then
				  	wget -q --tries=30 -O "$patch" "https://raw.githubusercontent.com/keylase/nvidia-patch/master/patch.sh" 2>/dev/null
				  fi
				  #\
					  if [[ -s "$patch" ]]; then
						  dos2unix "$patch" 1>/dev/null 2>/dev/null
						  chmod 777 "$patch" 1>/dev/null 2>/dev/null
					  		"$patch" 1>/dev/null 2>/dev/null
					  fi
				#------------------------------------
		  	patchfbc="$C/overlayfs_$md5/up/bin/nvidia-patch-fbc.sh"
				  if [[ ! -s "$patchfbc" ]]; then
				  	wget -q --tries=30 -O "$patchfbc" "https://raw.githubusercontent.com/keylase/nvidia-patch/master/patch-fbc.sh" 2>/dev/null
				  fi
				  #\
				  	if [[ -s "$patchfbc" ]]; then
					  	dos2unix "$patchfbc" 1>/dev/null 2>/dev/null
					  	chmod 777 "$patchfbc" 1>/dev/null 2>/dev/null
					  		"$patchfbc" 1>/dev/null 2>/dev/null
					  fi
       		}
	fi
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
# patch portproton
	if [[ -e /usr/bin/properportproton ]]; then sed -i 's,(id -u),(fakeid -u),g' /usr/bin/properportproton 2>/dev/null; fi
	if [[ -e "$HOME/.config/PortProton.conf" ]]; then sed -i 's,(id -u),(fakeid -u),g' "$(cat "$HOME/.config/PortProton.conf" | grep '/' | head -n1)/data/scripts/runlib" 2>/dev/null; fi
# ----------------------------------------------------
# add basic pacman support
	if [[ -e /opt/pacman ]]; then
	   [[ -e /opt/pacman/pacman.conf ]] && rm /etc/pacman.conf 2>/dev/null && ln -sf /opt/pacman/pacman.conf /etc/pacman.conf 2>/dev/null
	   [[ -e /opt/pacman/pacman.d ]] && rm -rf /etc/pacman.d 2>/dev/null && ln -sf /opt/pacman/pacman.d /etc/pacman.d 2>/dev/null
	   [[ -e /opt/pacman/cache ]] && rm -rf /var/cache/pacman 2>/dev/null && mkdir -p /var/cache && ln -sf /opt/pacman/cache /var/cache/pacman 2>/dev/null
	   [[ -e /opt/pacman/lib ]] && rm -rf /var/lib/pacman 2>/dev/null && mkdir -p /var/lib && ln -sf /opt/pacman/lib /var/lib/pacman 2>/dev/null
	fi
	if [[ ! -e "$(which realpacman)" ]]; then
	   p=/usr/bin/pacman
	   mv "$(which pacman)" "/usr/bin/realpacman" 2>/dev/null
	   echo '#!/bin/bash' >> $p
	   echo 'if [[ "$(echo "${@}" | grep overwrite)" = "" ]]; then' >> $p
	   echo '  realpacman "${@}" ' >> $p
	   echo 'else' >> $p
	   echo '  realpacman "${@}" ' >> $p
	   echo 'fi' >> $p
	   echo 'exit 0' >> $p
	   dos2unix $p 2>/dev/null && chmod 777 $p 2>/dev/null
	fi
# ----------------------------------------------------
# ensure dockerd 
	if [[ "$(echo "${@}" | grep docker)" != "" ]] || [[ "$(echo "${@}" | grep container)" != "" ]]; then
		if [[ "$(which dockerd)" != "" ]]; then
		  if [[ "$(pidof dockerd)" = "" ]]; then
		    killall containerd 2>/dev/null
		    su -c "nohup dockerd 1>/dev/null 2>/dev/null &" root 1>/dev/null 2>/dev/null &
		    clear
		  fi
		fi
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
# source environment 
 	if [[ -e /opt/env ]]; then
  		source /opt/env 2>/dev/null
	fi
	sysctl -w fs.inotify.max_user_watches=8192000 vm.max_map_count=2147483642 fs.file-max=8192000 >/dev/null 2>&1
	eval "$(dbus-launch --sh-syntax)"
