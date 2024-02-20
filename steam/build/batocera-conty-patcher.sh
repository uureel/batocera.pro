#!/bin/bash 
# -------------------------------------------------------------------------------
conty="/userdata/system/pro/steam/conty.sh"
md5="$(head -c 4000000 "${conty}" | md5sum | head -c 7)"_"$(tail -c 1000000 "${conty}" | md5sum | head -c 7)"
# -------------------------------------------------------------------------------
v=$(ls /lib32/libnvidia-* | sort | tail -n1 | sed 's,^.*.so.,,g')
c="/userdata/system/.local/share/Conty/overlayfs_$md5/up"
# -------------------------------------------------------------------------------
echo
mkdir -p "$c/etc/" 2>/dev/null
sysctl -w fs.inotify.max_user_watches=8192000 1>/dev/null 2>/dev/null
sysctl -w vm.max_map_count=2147483642 1>/dev/null 2>/dev/null
sysctl -w fs.file-max=8192000 1>/dev/null 2>/dev/null
  sed -i '/<description>.*<\/description>/d' /etc/fonts/fonts.conf 2>/dev/null &
  sed -i '/<description>.*<\/description>/d' /etc/fonts/conf.d/* 2>/dev/null &
  cp -r ~/.local/share/Conty/ld/* ~/.local/share/Conty/overlayfs_$md5/up/etc/ 2>/dev/null &
  cp -rf /etc /userdata/system/ 2>/dev/null &
    wait
      ulimit -H -n 819200 2>/dev/null
      ulimit -S -n 819200 2>/dev/null
        mkdir -p /newroot/proc 2>/dev/null
          mount -t proc /proc /newroot/proc 2>/dev/null
# -------------------------------------------------------------------------------
mkdir -p $c/etc 2>/dev/null &
mkdir -p $c/lib32 2>/dev/null &
mkdir -p $c/lib64 2>/dev/null &
mkdir -p $c/usr/bin 2>/dev/null &
mkdir -p $c/usr/lib 2>/dev/null &
mkdir -p $c/usr/lib/dri 2>/dev/null &
mkdir -p $c/usr/lib/nvidia/wine 2>/dev/null &
mkdir -p $c/usr/lib/nvidia/xorg 2>/dev/null &
mkdir -p $c/usr/lib/vdpau 2>/dev/null &
mkdir -p $c/usr/lib/xorg/modules/drivers 2>/dev/null &
mkdir -p $c/usr/lib32 2>/dev/null &
mkdir -p $c/usr/lib32/dri 2>/dev/null &
mkdir -p $c/usr/lib32/vdpau 2>/dev/null &
mkdir -p /var/run/nvidia 2>/dev/null &
mkdir -p /var/tmp 2>/dev/null &
    wait
# -------------------------------------------------------------------------------
# CHECK PRIME
export DISPLAY=:0.0
p=/userdata/system/.local/share/Conty/.conty-prime
rm "$p" 2>/dev/null
rm /var/tmp/nvidia.prime 2>/dev/null
rm /var/tmp/amd.prime 2>/dev/null
    gpu_count="$(lspci -nn | grep -E "(VGA|3D|Display controller)" | wc -l)"
    nvidia_conditions_met=false
    if [[ "$gpu_count" -eq 2 ]]; then
        nvidia_prime="$(/usr/bin/batocera-settings-get -f /boot/batocera-boot.conf nvidia-prime)"
        if [[ "$nvidia_prime" = "false" ]]; then
        :
        else
            gpu_name=$(lspci -nn | grep -iE "nvidia" | grep -iE "VGA|3D|Display controller")
            if [[ -n "$gpu_name" ]] || [[ "$nvidia_prime" = "true" ]]; then
                echo "" > "/var/tmp/nvidia.prime"
                nvidia_conditions_met=true
                nv=1
            fi
        fi
        if [[ "$nvidia_conditions_met" = "false" ]]; then
            radeon_prime="$(/usr/bin/batocera-settings-get -f /boot/batocera-boot.conf radeon-prime)"
            if [[ "$radeon_prime" = "false" ]]; then
            :
            else
                gpu_name="$(lspci -nn | grep -iE "AMD/ATI" | grep -iE "VGA|3D|Display controller")"
                if [[ -n "$gpu_name" ]] || [[ "$radeon_prime" = "true" ]]; then
                    formatted_info=$(lspci -nn | grep -iE "AMD/ATI" | grep -iE "VGA|3D|Display controller" | awk -F ' ' '{print $1}' | sed -e 's/:/_/g' -e 's/\./_/' -e 's/^/pci-0000_/')
                    echo $formatted_info > "/var/tmp/amd.prime"
                fi
            fi
        fi
    else
    :
    fi
# -------------------------------------------------------------------------------
# SET ENV FOR NVIDIA
if [[ -f "/var/tmp/nvidia.prime" ]]; then
    provider_count="$(DISPLAY=:0.0 xrandr --listproviders | grep 'Providers:' | awk '{print $4}')"
    if [[ "$provider_count" -ge 2 ]]; then
        provider_number="$(DISPLAY=:0.0 xrandr --listproviders | awk '/NVIDIA/ {print $2}' | tr -d ':')"
        if [[ -z "$provider_number" ]]; then
            :
        else
            export __NV_PRIME_RENDER_OFFLOAD=$provider_number
            export __VK_LAYER_NV_optimus=NVIDIA_only
            export __GLX_VENDOR_LIBRARY_NAME=nvidia
                echo "__NV_PRIME_RENDER_OFFLOAD=$provider_number" >> "$p"
                echo "__VK_LAYER_NV_optimus=NVIDIA_only" >> "$p"
                echo "__GLX_VENDOR_LIBRARY_NAME=nvidia" >> "$p"
                    nv=1
        fi
    else
    :
    fi
fi
# -------------------------------------------------------------------------------
# SET ENV FOR AMD
if [[ -f "/var/tmp/amd.prime" ]]; then
    amd_prime_value=$(<"/var/tmp/amd.prime")
    if [[ -z "$amd_prime_value" ]]; then
        export DRI_PRIME=1
            echo "DRI_PRIME=1" >> "$p"
    else
        export DRI_PRIME="$amd_prime_value"
            echo "DRI_PRIME=$amd_prime_value" >> "$p"
    fi
fi
# -------------------------------------------------------------------------------
echo "debug=test" >> "$p"
# -------------------------------------------------------------------------------
if [[ "$(glxinfo | grep "vendor string" | grep NVIDIA)" = "" ]]; then
    exit 0
else
    if [[ -s /tmp/.conty-nvidia-$v-$md5 ]]; then
    echo "preparing batocera-conty"
    echo "nvidia = $v"
    echo
    shown=1
        if [[ ! -e /tmp/.conty-nvidia-started ]] && [[ -e /userdata/system/.local/share/Conty/nvidia/nvidia-$v ]] && [[ -s /userdata/system/.local/share/Conty/nvidia/nvidia-$v.run ]]; then
            exit 0
        else
            nv=1
        fi
    else
        rm /tmp/.conty-nvidia-$v-$md5 2>/dev/null
        ver=$(glxinfo | grep "OpenGL version string" | sed 's,^.*NVIDIA ,,g')
        if [[ "$(echo "$v" | grep ".")" != "" ]]; then
            if [[ -e /userdata/system/logs/nvidia.log ]]; then
                if [[ "$(cat /userdata/system/logs/nvidia.log | grep "$v")" != "" ]]; then
                    nv=1
                fi
            fi
        fi
    fi
fi
nvlog=/userdata/system/logs/nvidia.log
if [[ -e $nvlog ]]; then
    if [[ "$(cat $nvlog | grep "Detected a NVIDIA")" != "" ]] || [[ "$(cat $nvlog | grep "Using NVIDIA")" != "" ]]; then
        nv=1
    fi
fi
if [[ "$nv" != "1" ]]; then
    exit 0
else
  if [[ "$shown" != "1" ]]; then
    echo "preparing batocera-conty"
    echo "nvidia = $v"
  fi
fi
# -------------------------------------------------------------------------------
nvdir="/userdata/system/.local/share/Conty/nvidia"
 mkdir -p "$nvdir" 2>/dev/null
  cd "${nvdir}"
   rm /tmp/.conty-nvidia-started 2>/dev/null
   touch /tmp/.conty-nvidia-started 2>/dev/null
# -------------------------------------------------------------------------------
if [[ ! -s "${nvdir}"/.nvidia-$v-downloaded ]]; then
    rm "${nvdir}"/.nvidia-$v 2>/dev/null
    rm -rf "${nvdir}"/nvidia-$v* 2>/dev/null
    rm -rf "${nvdir}"/nvidia-$v.run 2>/dev/null
    rm -rf "${nvdir}"/nvidia-$v 2>/dev/null
      rm "${nvdir}/.nvidia-$v-downloaded" 2>/dev/null
        rm /tmp/.conty-nvidia-downloading 2>/dev/null
        touch /tmp/.conty-nvidia-downloading 2>/dev/null
          echo "downloading..."
            wget -q --show-progress -O nvidia-$v.run https://us.download.nvidia.com/XFree86/Linux-x86_64/$v/NVIDIA-Linux-x86_64-$v.run
            chmod +x nvidia-$v.run 2>/dev/null
        rm /tmp/.conty-nvidia-downloading 2>/dev/null
      echo "OK" >> "${nvdir}/.nvidia-$v-downloaded"
fi
# -------------------------------------------------------------------------------
if [ ! -f nvidia-$v.run ]; then
    echo "failed to download nvidia $v :( try again?"
    exit 1
fi
# -------------------------------------------------------------------------------
if [[ ! -f "${nvdir}/.nvidia-$v-$md5" ]]; then
  cd "${nvdir}"
    rm -rf "nvidia-$v" 2>/dev/null
    chmod +x nvidia-$v.run 2>/dev/null
    echo "extracting..."
      ./nvidia-$v.run -x 1>/dev/null 2>/dev/null
        mv "NVIDIA-Linux-x86_64-$v" "nvidia-$v"
        rm "${nvdir}"/.nvidia-$v-$md5 2>/dev/null
          echo "OK" >> "${nvdir}"/.nvidia-$v-$md5
fi
if [ ! -d nvidia-$v ]; then
    echo "failed to extract nvidia $v installer"
    exit 1
fi
# -------------------------------------------------------------------------------
function NV1() {
v="${1}"
c="${2}"
n="nvidia-$v"
nvdir="/userdata/system/.local/share/Conty/nvidia"
cd "$nvdir/$n/32"
for file in *; do
    name="$(basename $(realpath "$file"))"
    clean=$(echo "$name" | cut -d "." -f1)
    rm $c/usr/lib32/$name 2>/dev/null
    rm $c/lib32/$name 2>/dev/null
        if [[ "$(echo "$name" | grep "$v")" != "" ]]; then
            nover=$(echo "$name" | sed "s,.$v,,g")
                rm $c/usr/lib32/$name 2>/dev/null &
                rm $c/usr/lib32/$nover 2>/dev/null &
                rm $c/usr/lib32/$nover.0 2>/dev/null &
                rm $c/usr/lib32/$nover.1 2>/dev/null &
                rm $c/usr/lib32/$nover.2 2>/dev/null &
                    wait
                ln -sf "$PWD/$name" "$c/usr/lib32/$name" 2>/dev/null &
                ln -sf "$PWD/$name" "$c/usr/lib32/$nover" 2>/dev/null &
                ln -sf "$PWD/$name" "$c/usr/lib32/$nover.0" 2>/dev/null &
                ln -sf "$PWD/$name" "$c/usr/lib32/$nover.1" 2>/dev/null &
                ln -sf "$PWD/$name" "$c/usr/lib32/$nover.2" 2>/dev/null &
                    wait
        else 
            rm $c/usr/lib32/$name 2>/dev/null
            ln -sf "$PWD/$name" "$c/usr/lib32/$name" 2>/dev/null   
        fi
done
}
# -------------------------------------------------------------------------------
function NV2() {
v="${1}"
c="${2}"
n="nvidia-$v"
nvdir="/userdata/system/.local/share/Conty/nvidia"
cd "$nvdir/$n"
for file in *; do
    name="$(basename $(realpath "$file"))"
    clean=$(echo "$name" | cut -d "." -f1)
    rm $c/usr/lib/$name 2>/dev/null
    rm $c/lib64/$name 2>/dev/null
    rm $c/lib/$name 2>/dev/null
    if [[ "$(echo "$name" | cut -c1-7)" == *"nvidia-"* ]] && [[ -x "$name" ]]; then
            rm $c/usr/bin/$name 2>/dev/null
            ln -sf "$PWD/$name" "$c/usr/bin/$name" 2>/dev/null
    fi
    if [[ "$(echo "$name" | grep "$v")" != "" ]]; then
        nover=$(echo "$name" | sed "s,.$v,,g")
            rm $c/usr/lib/$name 2>/dev/null &
            rm $c/usr/lib/$nover 2>/dev/null &
            rm $c/usr/lib/$nover.0 2>/dev/null &
            rm $c/usr/lib/$nover.1 2>/dev/null &
            rm $c/usr/lib/$nover.2 2>/dev/null &
                wait
            ln -sf "$PWD/$name" "$c/usr/lib/$name" &
            ln -sf "$PWD/$name" "$c/usr/lib/$nover" &
            ln -sf "$PWD/$name" "$c/usr/lib/$nover.0" &
            ln -sf "$PWD/$name" "$c/usr/lib/$nover.1" &
            ln -sf "$PWD/$name" "$c/usr/lib/$nover.2" &
                wait
    else 
        if [[ "$(echo "$name" | cut -c1-3)" = "lib" ]]; then
            clean=$(echo "$name" | rev | sed 's,^.*os.,,g' | rev)
                rm $c/usr/lib/$name 2>/dev/null &
                rm $c/usr/lib/$clean.so 2>/dev/null &
                rm $c/usr/lib/$clean.0 2>/dev/null &
                rm $c/usr/lib/$clean.1 2>/dev/null &
                rm $c/usr/lib/$clean.2 2>/dev/null &
                    wait
                ln -sf "$PWD/$name" "$c/usr/lib/$name" 2>/dev/null &
                ln -sf "$PWD/$name" "$c/usr/lib/$clean.so" 2>/dev/null &
                ln -sf "$PWD/$name" "$c/usr/lib/$clean.so.0" 2>/dev/null &
                ln -sf "$PWD/$name" "$c/usr/lib/$clean.so.1" 2>/dev/null &
                ln -sf "$PWD/$name" "$c/usr/lib/$clean.so.2" 2>/dev/null &
                    wait
        else
                rm $c/usr/lib/$name 2>/dev/null
                ln -sf "$PWD/$name" "$c/usr/lib/$name" 2>/dev/null        
        fi
    fi
done
    rm "$c"/lib/libglvnd_install_checker.* 2>/dev/null &
    rm "$c"/usr/lib/libglvnd_install_checker.* 2>/dev/null &
        wait
}
# -------------------------------------------------------------------------------
function NV3() {
v="${1}"
c="${2}"
n="nvidia-$v"
nvdir="/userdata/system/.local/share/Conty/nvidia"
cd "$nvdir/$n"
    rm "$c/usr/lib/nvidia/xorg/libglxserver_nvidia.so.$v" 2>/dev/null &
    rm "$c/usr/lib/nvidia/xorg/libglxserver_nvidia.so.1" 2>/dev/null &
    rm "$c/usr/lib/nvidia/xorg/libglxserver_nvidia.so.0" 2>/dev/null &
    rm "$c/usr/lib/nvidia/xorg/libglxserver_nvidia.so" 2>/dev/null &
    rm "$c/usr/lib/vdpau/libvdpau_nvidia.so.$v" 2>/dev/null &
    rm "$c/usr/lib/vdpau/libvdpau_nvidia.so.1" 2>/dev/null &
    rm "$c/usr/lib/vdpau/libvdpau_nvidia.so.0" 2>/dev/null &
    rm "$c/usr/lib/vdpau/libvdpau_nvidia.so" 2>/dev/null &
    rm "$c/usr/lib/xorg/modules/drivers/nvidia_drv.so.1" 2>/dev/null &
    rm "$c/usr/lib/xorg/modules/drivers/nvidia_drv.so.0" 2>/dev/null &
    rm "$c/usr/lib/xorg/modules/drivers/nvidia_drv.so" 2>/dev/null &
    rm "$c/usr/lib/nvidia/wine/_nvgx.dll" 2>/dev/null &
    rm "$c/usr/lib/nvidia/wine/nvgx.dll" 2>/dev/null &
        wait
    ln -sf "$PWD/libglxserver_nvidia.so.$v" "$c/usr/lib/nvidia/xorg/libglxserver_nvidia.so.$v" 2>/dev/null &
    ln -sf "$PWD/libglxserver_nvidia.so.$v" "$c/usr/lib/nvidia/xorg/libglxserver_nvidia.so.1" 2>/dev/null &
    ln -sf "$PWD/libglxserver_nvidia.so.$v" "$c/usr/lib/nvidia/xorg/libglxserver_nvidia.so.0" 2>/dev/null &
    ln -sf "$PWD/libglxserver_nvidia.so.$v" "$c/usr/lib/nvidia/xorg/libglxserver_nvidia.so" 2>/dev/null &
    ln -sf "$PWD/libvdpau_nvidia.so.$v" "$c/usr/lib/vdpau/libvdpau_nvidia.so.$v" 2>/dev/null &
    ln -sf "$PWD/libvdpau_nvidia.so.$v" "$c/usr/lib/vdpau/libvdpau_nvidia.so.1" 2>/dev/null &
    ln -sf "$PWD/libvdpau_nvidia.so.$v" "$c/usr/lib/vdpau/libvdpau_nvidia.so.0" 2>/dev/null &
    ln -sf "$PWD/libvdpau_nvidia.so.$v" "$c/usr/lib/vdpau/libvdpau_nvidia.so" 2>/dev/null &
    ln -sf "$PWD/nvidia_drv.so" "$c/usr/lib/xorg/modules/drivers/nvidia_drv.so.1" 2>/dev/null &
    ln -sf "$PWD/nvidia_drv.so" "$c/usr/lib/xorg/modules/drivers/nvidia_drv.so.0" 2>/dev/null &
    ln -sf "$PWD/nvidia_drv.so" "$c/usr/lib/xorg/modules/drivers/nvidia_drv.so" 2>/dev/null &
    ln -sf "$PWD/_nvngx.dll" "$c/usr/lib/nvidia/wine/_nvngx.dll" 2>/dev/null &
    ln -sf "$PWD/nvngx.dll" "$c/usr/lib/nvidia/wine/nvngx.dll" 2>/dev/null &
        wait
    rm "$c"/lib/libglvnd_install_checker.* 2>/dev/null &
    rm "$c"/usr/lib/libglvnd_install_checker.* 2>/dev/null &
        wait
}
# -------------------------------------------------------------------------------
function NV4() {
v="${1}"
c="${2}"
n="nvidia-$v"
nvdir="/userdata/system/.local/share/Conty/nvidia"
cd "$nvdir/$n/32"
    rm "$c"/usr/lib32/vdpau/libvdpau_nvidia* 2>/dev/null &
    rm "$c/usr/lib32/vdpau/libvdpau_nvidia.so.$v" 2>/dev/null &
    rm "$c/usr/lib32/vdpau/libvdpau_nvidia.so.1" 2>/dev/null &
    rm "$c/usr/lib32/vdpau/libvdpau_nvidia.so.0" 2>/dev/null &
    rm "$c/usr/lib32/vdpau/libvdpau_nvidia.so" 2>/dev/null &
        wait
    ln -sf "$PWD/libvdpau_nvidia.so.$v" "$c/usr/lib32/vdpau/libvdpau_nvidia.so.$v" 2>/dev/null &
    ln -sf "$PWD/libvdpau_nvidia.so.$v" "$c/usr/lib32/vdpau/libvdpau_nvidia.so.1" 2>/dev/null &
    ln -sf "$PWD/libvdpau_nvidia.so.$v" "$c/usr/lib32/vdpau/libvdpau_nvidia.so.0" 2>/dev/null &
    ln -sf "$PWD/libvdpau_nvidia.so.$v" "$c/usr/lib32/vdpau/libvdpau_nvidia.so" 2>/dev/null &
        wait
}
# -------------------------------------------------------------------------------
NV1 "$v" "$c" & 
NV2 "$v" "$c" &
NV3 "$v" "$c" &
NV4 "$v" "$c" &
    wait
# -------------------------------------------------------------------------------
rm /tmp/.conty-nvidia-started 2>/dev/null
rm /tmp/.conty-nvidia-$v-$md5 2>/dev/null
echo "OK" >> /tmp/.conty-nvidia-$v-$md5
# -------------------------------------------------------------------------------
echo "ready"
echo
exit 0
