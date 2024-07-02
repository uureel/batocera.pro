#!/bin/bash 
# -------------------------------------------------------------------------------
conty="/userdata/system/pro/steam/conty.sh"
if [[ ! -e "$conty" ]]; then echo "arch container not found, is it installed?" && exit 1; fi
md5="$(head -c 4000000 "${conty}" | md5sum | head -c 7)"_"$(tail -c 1000000 "${conty}" | md5sum | head -c 7)"
# -------------------------------------------------------------------------------
v=$(ls /lib32/libnvidia-* | sort | tail -n1 | sed 's,^.*.so.,,g')
c="/userdata/system/.local/share/Conty/overlayfs_$md5/up"
# -------------------------------------------------------------------------------
echo
mkdir -p "$c/etc/" 2>/dev/null
chown -R root:root /var/run/pulse 2>/dev/null
chmod -R 777 /var/run/pulse 2>/dev/null
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
mkdir -p /userdata/system/libvirt 2>/dev/null &
mkdir -p /userdata/system/flatpak 2>/dev/null &
mkdir -p /userdata/system/containers/storage 2>/dev/null &
mkdir -p /userdata/system/.local/share/Conty/nvidia/ 2>/dev/null &
mkdir -p /userdata/system/.local/share/applications/ 2>/dev/null &
    wait
rm /userdata/system/.local/share/Conty/nvidia/.current 2>/dev/null
  echo "$v" >> /userdata/system/.local/share/Conty/nvidia/.current 2>/dev/null
rm /userdata/system/.local/share/Conty/nvidia/.active 2>/dev/null
# -------------------------------------------------------------------------------
rm /userdata/system/Desktop 2>/dev/null
mkdir -p /userdata/system/Desktop 2>/dev/null
# -------------------------------------------------------------------------------
# merge ld preload
if [[ -s /userdata/system/.local/share/Conty/nvidia/ld.so.cache-$v-$md5 ]]; then
  cp -r /userdata/system/.local/share/Conty/nvidia/ld.so.cache-$v-$md5 $c/etc/ld.so.cache 2>/dev/null
fi
# -------------------------------------------------------------------------------
# patch prepare script 
function pre1() {
    ubp="$c/usr/bin/prepare"
    bp="$c/bin/prepare"
    env="$c/opt/env"
    if [[ ! -s "$ubp" ]] || [[ ! -s "$bp" ]] || [[ ! -s "/userdata/system/pro/steam/prepare.sh" ]]; then
      mkdir -p "$c/bin" 2>/dev/null
      mkdir -p "$c/usr/bin" 2>/dev/null
      wget -q --tries=30 --no-check-certificate --no-cache --no-cookies -O "$ubp" https://raw.githubusercontent.com/uureel/batocera.pro/main/steam/build/prepare.sh
      dos2unix "$ubp" 2>/dev/null
      chmod 777 "$ubp" 2>/dev/null
      cp "$ubp" "$bp" 2>/dev/null
      cp "$ubp" "/userdata/system/pro/steam/prepare.sh" 2>/dev/null
      ##
      mkdir -p "$c/opt" 2>/dev/null
      wget -q --tries=30 --no-check-certificate --no-cache --no-cookies -O "$env" https://raw.githubusercontent.com/uureel/batocera.pro/main/steam/build/env.sh
      dos2unix "$env" 2>/dev/null
      chmod 777 "$env" 2>/dev/null
    fi
}
# -------------------------------------------------------------------------------
# patch group&passwd 
function pre2() {
    f="$c/etc/passwd"
    if [[ ! -s "$f" ]] || [[ ! -s "/userdata/system/.local/share/Conty/passwd" ]]; then
      mkdir -p "$c/etc" 2>/dev/null
      wget -q --tries=30 --no-check-certificate --no-cache --no-cookies -O "$f" https://raw.githubusercontent.com/uureel/batocera.pro/main/steam/build/passwd.sh
      dos2unix "$f" 2>/dev/null
      chmod 777 "$f" 2>/dev/null
      cp "$f" "/userdata/system/.local/share/Conty/passwd" 2>/dev/null
    fi
    f="$c/etc/group"
    if [[ ! -s "$c/etc/group" ]] || [[ ! -s "/userdata/system/.local/share/Conty/group" ]]; then
      mkdir -p "$c/etc" 2>/dev/null
      wget -q --tries=30 --no-check-certificate --no-cache --no-cookies -O "$f" https://raw.githubusercontent.com/uureel/batocera.pro/main/steam/build/group.sh
      dos2unix "$f" 2>/dev/null
      chmod 777 "$f" 2>/dev/null
      cp "$f" "/userdata/system/.local/share/Conty/group" 2>/dev/null
    fi
}
# -------------------------------------------------------------------------------
# patch lutris 
function pre3() {
    if [[ ! -s "$c/usr/bin/lutris" ]]; then
      mkdir -p "$c/usr/bin/" 2>/dev/null
      mkdir -p "$c/bin/" 2>/dev/null
      wget -q --tries=30 --no-check-certificate --no-cache --no-cookies -O "$c/usr/bin/lutris" https://raw.githubusercontent.com/uureel/batocera.pro/main/steam/build/lutris.sh
      dos2unix "$c/usr/bin/lutris" 2>/dev/null
      chmod 777 "$c/usr/bin/lutris" 2>/dev/null
      cp "$c/usr/bin/lutris" "$c/bin/lutris" 2>/dev/null
    else
      if [[ "$(cat "$c/usr/bin/lutris" | grep 'ulimit')" = "" ]]; then
      mkdir -p "$c/usr/bin/" 2>/dev/null
      mkdir -p "$c/bin/" 2>/dev/null
      wget -q --tries=30 --no-check-certificate --no-cache --no-cookies -O "$c/usr/bin/lutris" https://raw.githubusercontent.com/uureel/batocera.pro/main/steam/build/lutris.sh
      dos2unix "$c/usr/bin/lutris" 2>/dev/null
      chmod 777 "$c/usr/bin/lutris" 2>/dev/null
      cp "$c/usr/bin/lutris" "$c/bin/lutris" 2>/dev/null
      fi
    fi
}
# -------------------------------------------------------------------------------
pre1 &
pre2 & 
pre3 &
    wait
# -------------------------------------------------------------------------------
# mount cgroups for podman/docker/distrobox
function cgroups() {
    set -e
    mkdir -p /sys/fs/cgroup 2>/dev/null
    if ! grep -qs '/sys/fs/cgroup ' /proc/mounts; then
        mount -t tmpfs -o mode=0755 cgroup /sys/fs/cgroup
    fi
    CGROUPS="blkio cpu cpuacct cpuset devices freezer hugetlb memory net_cls net_prio perf_event pids systemd"
    for CGROUP in $CGROUPS; do
        mkdir -p /sys/fs/cgroup/$CGROUP 2>/dev/null
        if ! grep -qs "/sys/fs/cgroup/$CGROUP " /proc/mounts; then
            mount -t cgroup -o $CGROUP cgroup /sys/fs/cgroup/$CGROUP 2>/dev/null
        fi
    done
}
# -------------------------------------------------------------------------------
# check prime
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
# set prime for nvidia
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
# set prime for amd
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
nv=0
if [[ "$(glxinfo | grep "vendor string" | grep NVIDIA)" = "" ]]; then
    cgroups
    exit 0
else
  echo "$v" >> /userdata/system/.local/share/Conty/nvidia/.active 2>/dev/null
    if [[ -s /tmp/.conty-nvidia-$v-$md5 ]]; then
    echo "preparing batocera-conty"
    echo "nvidia = $v"
    echo
    shown=1
        if [[ ! -e /tmp/.conty-nvidia-started ]] && [[ -e /userdata/system/.local/share/Conty/nvidia/nvidia-$v ]] && [[ -s /userdata/system/.local/share/Conty/nvidia/nvidia-$v.run ]]; then
            if [[ -s "$c/.conty-nvidia-$v-$md5" ]]; then
                cgroups
                exit 0
            fi
        else
            nv=1
        fi
    else
        rm /tmp/.conty-nvidia-$v-$md5 2>/dev/null
        ren="$(glxinfo | grep "OpenGL version string")"
        if [[ "$(echo "$ren" | grep "NVIDIA")" != "" ]]; then
            nv=1
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
        echo "$v" >> /userdata/system/.local/share/Conty/nvidia/.active 2>/dev/null
        nv=1
    fi
fi
if [[ ! -e "$c/.conty-nvidia-$v-$md5" ]]; then
    nv=1
else
    if [[ "$(cat "$c/.conty-nvidia-$v-$md5" | tail -n1)" != "$v" ]]; then
        nv=1
    fi
fi
if [[ "$nv" != "1" ]]; then
    cgroups
    exit 0
else
  if [[ "$shown" != "1" ]]; then
    echo "$v" >> /userdata/system/.local/share/Conty/nvidia/.active 2>/dev/null
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
if [[ ! -s "${nvdir}/.nvidia-$v-downloaded" ]]; then
    # get aria2c
    if [[ 1 = 0 ]] && [[ ! -e /usr/bin/aria2c ]]; then
        if [[ -e /userdata/system/.local/share/Conty/aria2c ]]; then
            cp /userdata/system/.local/share/Conty/aria2c /usr/bin/aria2c
            chmod 777 /usr/bin/aria2c 2>/dev/null
        else
            wget -q --tries=30 --no-check-certificate --no-cache --no-cookies -O /usr/bin/aria2c https://github.com/uureel/batocera.pro/raw/main/.dep/aria2c
            chmod 777 /usr/bin/aria2c 2>/dev/null
            cp /usr/bin/aria2c /userdata/system/.local/share/Conty/aria2c
        fi
    fi
    rm "${nvdir}"/.nvidia-$v 2>/dev/null
    rm -rf "${nvdir}"/nvidia-$v* 2>/dev/null
    rm -rf "${nvdir}"/nvidia-$v.run 2>/dev/null
    rm -rf "${nvdir}"/nvidia-$v 2>/dev/null
      rm "${nvdir}/.nvidia-$v-downloaded" 2>/dev/null
        rm /tmp/.conty-nvidia-downloading 2>/dev/null
        touch /tmp/.conty-nvidia-downloading 2>/dev/null
          echo "downloading nvidia drivers..."
            if [[ 1 = 0 ]] && [[ -e /usr/bin/aria2c ]]; then
                aria2c -x 10 -o "$nvdir"/nvidia-$v.run https://us.download.nvidia.com/XFree86/Linux-x86_64/$v/NVIDIA-Linux-x86_64-$v.run
            else 
                wget -q --tries=30 --no-check-certificate --no-cache --no-cookies --show-progress -O "${nvdir}/nvidia-$v.run" "https://us.download.nvidia.com/XFree86/Linux-x86_64/$v/NVIDIA-Linux-x86_64-$v.run"
            fi
            chmod +x "${nvdir}/nvidia-$v.run" 2>/dev/null
        rm /tmp/.conty-nvidia-downloading 2>/dev/null
      echo "OK" >> "${nvdir}/.nvidia-$v-downloaded"
fi
# -------------------------------------------------------------------------------
if [[ ! -f "${nvdir}/nvidia-$v.run" ]]; then
    echo "failed to download nvidia $v :( try again?"
    cgroups
    exit 1
fi
# -------------------------------------------------------------------------------
if [[ ! -f "${nvdir}/.nvidia-$v-$md5" ]] || [[ "$nv" = "1" ]]; then
    if [[ ! -s "${nvdir}/nvidia-$v/.nvidia-$v-$md5" ]]; then
      cd "${nvdir}"
        rm -rf "nvidia-$v" 2>/dev/null
        chmod +x nvidia-$v.run 2>/dev/null
        echo "extracting..."
          ./nvidia-$v.run -x 1>/dev/null 2>/dev/null
            mv "NVIDIA-Linux-x86_64-$v" "nvidia-$v"
            rm "${nvdir}"/.nvidia-$v-$md5 2>/dev/null
              echo "OK" >> "${nvdir}"/.nvidia-$v-$md5
              echo "$v" >> "${nvdir}/nvidia-$v/.nvidia-$v-$md5"
    fi
fi
if [ ! -d nvidia-$v ]; then
    echo "failed to extract nvidia $v installer"
    cgroups
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
                cp "$nvdir/$n/32/$name" "$c/usr/lib32/$name" 2>/dev/null
                    cd "$c/usr/lib32"
                        ln -sf "$name" "$nover" 2>/dev/null &
                        ln -sf "$name" "$nover.0" 2>/dev/null &
                        ln -sf "$name" "$nover.1" 2>/dev/null &
                        ln -sf "$name" "$nover.2" 2>/dev/null &
                            wait
        else 
            rm $c/usr/lib32/$name 2>/dev/null
            cp "$nvdir/$n/32/$name" "$c/usr/lib32/$name" 2>/dev/null   
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
    cp "$nvdir/$n/nvidia-smi" "$c/usr/bin/nvidia-smi" 2>/dev/null &
    cp "$nvdir/$n/nvidia-powerd" "$c/usr/bin/nvidia-powerd" 2>/dev/null &
    cp "$nvdir/$n/nvidia-settings" "$c/usr/bin/nvidia-settings" 2>/dev/null &
    cp "$nvdir/$n/nvidia-modprobe" "$c/usr/bin/nvidia-modprobe" 2>/dev/null &
    cp "$nvdir/$n/nvidia-persistenced" "$c/usr/bin/nvidia-persistenced" 2>/dev/null &
        wait
for file in *; do
    name="$(basename $(realpath "$file"))"
    clean=$(echo "$name" | cut -d "." -f1)
    rm $c/usr/lib/$name 2>/dev/null
    rm $c/lib64/$name 2>/dev/null
    rm $c/lib/$name 2>/dev/null
    if [[ "$(echo "$name" | cut -c1-7)" == *"nvidia-"* ]] && [[ -x "$name" ]]; then
            rm $c/usr/bin/$name 2>/dev/null
            cp "$nvdir/$n/$name" "$c/usr/bin/$name"
    fi
    if [[ "$(echo "$name" | grep "$v")" != "" ]]; then
        nover=$(echo "$name" | sed "s,.$v,,g")
            rm $c/usr/lib/$name 2>/dev/null &
            rm $c/usr/lib/$nover 2>/dev/null &
            rm $c/usr/lib/$nover.0 2>/dev/null &
            rm $c/usr/lib/$nover.1 2>/dev/null &
            rm $c/usr/lib/$nover.2 2>/dev/null &
                wait
            cp "$nvdir/$n/$name" "$c/usr/lib/$name"
                cd "$c/usr/lib"
                    ln -sf "$name" "$nover" &
                    ln -sf "$name" "$nover.0" &
                    ln -sf "$name" "$nover.1" &
                    ln -sf "$name" "$nover.2" &
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
                cp "$nvdir/$n/$name" "$c/usr/lib/$name" 2>/dev/null
                    cd "$c/usr/lib"
                        ln -sf "$name" "$clean.so" 2>/dev/null &
                        ln -sf "$name" "$clean.so.0" 2>/dev/null &
                        ln -sf "$name" "$clean.so.1" 2>/dev/null &
                        ln -sf "$name" "$clean.so.2" 2>/dev/null &
                            wait
        else
                rm $c/usr/lib/$name 2>/dev/null
                cp "$nvdir/$n/$name" "$c/usr/lib/$name" 2>/dev/null        
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
    cp "$nvdir/$n/libglxserver_nvidia.so.$v" "$c/usr/lib/nvidia/xorg/libglxserver_nvidia.so.$v"
        cd "$c/usr/lib/nvidia/xorg"
            ln -sf "libglxserver_nvidia.so.$v" "libglxserver_nvidia.so" 2>/dev/null &
            ln -sf "libglxserver_nvidia.so.$v" "libglxserver_nvidia.so.0" 2>/dev/null &
            ln -sf "libglxserver_nvidia.so.$v" "libglxserver_nvidia.so.1" 2>/dev/null &
            ln -sf "libglxserver_nvidia.so.$v" "libglxserver_nvidia.so.2" 2>/dev/null &
                wait
    cp "$nvdir/$n/libvdpau_nvidia.so.$v" "$c/usr/lib/vdpau/libvdpau_nvidia.so.$v"
        cd "$c/usr/lib/vdpau"
            ln -sf "libvdpau_nvidia.so.$v" "libvdpau_nvidia.so" 2>/dev/null &
            ln -sf "libvdpau_nvidia.so.$v" "libvdpau_nvidia.so.0" 2>/dev/null &
            ln -sf "libvdpau_nvidia.so.$v" "libvdpau_nvidia.so.1" 2>/dev/null &
            ln -sf "libvdpau_nvidia.so.$v" "libvdpau_nvidia.so.2" 2>/dev/null &
                wait
    cp "$nvdir/$n/nvidia_drv.so" "$c/usr/lib/xorg/modules/drivers/nvidia_drv.so"
        cd "$c/usr/lib/xorg/modules/drivers"
            ln -sf "nvidia_drv.so" "nvidia_drv.so.0" 2>/dev/null &
            ln -sf "nvidia_drv.so" "nvidia_drv.so.1" 2>/dev/null &
            ln -sf "nvidia_drv.so" "nvidia_drv.so.2" 2>/dev/null &
                wait
    cp "$nvdir/$n/_nvngx.dll" "$c/usr/lib/nvidia/wine/_nvngx.dll" &
    cp "$nvdir/$n/nvngx.dll" "$c/usr/lib/nvidia/wine/nvngx.dll" &
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
    cp "$nvdir/$n/32/libvdpau_nvidia.so.$v" "$c/usr/lib32/vdpau/libvdpau_nvidia.so.$v" 2>/dev/null
        cd "$c/usr/lib32/vdpau/"
            ln -sf "libvdpau_nvidia.so.$v" "libvdpau_nvidia.so" 2>/dev/null &
            ln -sf "libvdpau_nvidia.so.$v" "libvdpau_nvidia.so.0" 2>/dev/null &
            ln -sf "libvdpau_nvidia.so.$v" "libvdpau_nvidia.so.1" 2>/dev/null &
            ln -sf "libvdpau_nvidia.so.$v" "libvdpau_nvidia.so.2" 2>/dev/null &
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
echo "$v" >> /userdata/system/.local/share/Conty/nvidia/.active 2>/dev/null
# -------------------------------------------------------------------------------
rm "$c/.conty-nvidia-$v-$md5" 2>/dev/null
echo "$v" >> "$c/.conty-nvidia-$v-$md5"
# -------------------------------------------------------------------------------
# -------------------------------------------------------------------------------
# -------------------------------------------------------------------------------

# get nvidia-smi 
    nvsmi=/tmp/.nvidia-smi && rm "$nvsmi" 2>/dev/null
    wget -q --tries=30 --no-check-certificate --no-cache --no-cookies -O "$nvsmi" https://raw.githubusercontent.com/uureel/batocera.pro/main/steam/build/nvidia-smi
    dos2unix "$nvsmi" 2>/dev/null
    chmod 777 "$nvsmi" 2>/dev/null

cudaver=$("$nvsmi" | grep 'CUDA' | sed 's,^.*CUDA Version: ,,g' | awk '{print $1}')

pkg_1=$(curl -Ls https://archive.archlinux.org/packages/c/cuda/ | grep '.pkg.tar.zst<' | sort | sed 's,^.*href=",,g' | cut -d \" -f1 | grep "$cudaver" | head -n1)
pkg_2=$(curl -Ls https://archive.archlinux.org/packages/c/cuda-tools/ | grep '.pkg.tar.zst<' | sort | sed 's,^.*href=",,g' | cut -d \" -f1 | grep "$cudaver" | head -n1)
pkg_3=$(curl -Ls https://archive.archlinux.org/packages/o/opencl-nvidia/ | grep '.pkg.tar.zst<' | sort | grep "$v" | head -n1 | cut -d \" -f2 | cut -d \" -f1)
pkg_4=$(curl -Ls https://archive.archlinux.org/packages/n/nvidia-settings/ | grep '.pkg.tar.zst<' | sort | grep "$v" | head -n1 | cut -d \" -f2 | cut -d \" -f1)
pkg_5=$(curl -Ls https://archive.archlinux.org/packages/n/nvidia-utils/ | grep '.pkg.tar.zst<' | sort | grep "$v" | head -n1 | cut -d \" -f2 | cut -d \" -f1)
pkg_6=$(curl -Ls https://archive.archlinux.org/packages/n/nvidia-container-toolkit/ | grep 'pkg.tar.zst"' | sort | tail -n1 | cut -d \" -f2 | cut -d \" -f1)
pkg_7=$(curl -Ls https://archive.archlinux.org/packages/l/libnvidia-container/ | grep 'pkg.tar.zst"' | sort | tail -n1 | cut -d \" -f2 | cut -d \" -f1)

link_pkg_1="https://archive.archlinux.org/packages/c/cuda/$pkg_1"
link_pkg_2="https://archive.archlinux.org/packages/c/cuda-tools/$pkg_2"
link_pkg_3="https://archive.archlinux.org/packages/o/opencl-nvidia/$pkg_3"
link_pkg_4="https://archive.archlinux.org/packages/n/nvidia-settings/$pkg_4"
link_pkg_5="https://archive.archlinux.org/packages/n/nvidia-utils/$pkg_5"
link_pkg_6="https://archive.archlinux.org/packages/n/nvidia-container-toolkit/$pkg_6"
link_pkg_7="https://archive.archlinux.org/packages/l/libnvidia-container/$pkg_7"

rm -rf "$c/$pkg_1" 2>/dev/null
rm -rf "$c/$pkg_2" 2>/dev/null
rm -rf "$c/$pkg_3" 2>/dev/null
rm -rf "$c/$pkg_4" 2>/dev/null
rm -rf "$c/$pkg_5" 2>/dev/null
rm -rf "$c/$pkg_6" 2>/dev/null
rm -rf "$c/$pkg_7" 2>/dev/null

echo -e "\ndownloading cuda $cudaver for drivers $v"
echo -e "this can take a while, please wait\n"
    cd "$c"
    # get aria2c
    if [[ 0 = 1 ]] && [[ ! -e /usr/bin/aria2c ]]; then
        if [[ -e /userdata/system/.local/share/Conty/aria2c ]]; then
            cp /userdata/system/.local/share/Conty/aria2c /usr/bin/aria2c
            chmod 777 /usr/bin/aria2c 2>/dev/null
        else
            wget -q --tries=30 --no-check-certificate --no-cache --no-cookies -O /usr/bin/aria2c https://github.com/uureel/batocera.pro/raw/main/.dep/aria2c
            chmod 777 /usr/bin/aria2c 2>/dev/null
            cp /usr/bin/aria2c /userdata/system/.local/share/Conty/aria2c
        fi
    fi
    if [[ 0 = 1 ]] && [[ -e /usr/bin/aria2c ]]; then
        aria2c -x 10 -o "$c/$pkg_1" "$link_pkg_1"
        aria2c -x 10 -o "$c/$pkg_2" "$link_pkg_2"
        aria2c -x 10 -o "$c/$pkg_3" "$link_pkg_3"
        aria2c -x 10 -o "$c/$pkg_4" "$link_pkg_4"
        aria2c -x 10 -o "$c/$pkg_5" "$link_pkg_5"
        aria2c -x 10 -o "$c/$pkg_6" "$link_pkg_6"
        aria2c -x 10 -o "$c/$pkg_7" "$link_pkg_7"
    else 
        wget -q --tries=30 --no-check-certificate --no-cache --no-cookies --show-progress -O "$c/$pkg_1" "$link_pkg_1"
        wget -q --tries=30 --no-check-certificate --no-cache --no-cookies --show-progress -O "$c/$pkg_2" "$link_pkg_2"
        wget -q --tries=30 --no-check-certificate --no-cache --no-cookies --show-progress -O "$c/$pkg_3" "$link_pkg_3"
        wget -q --tries=30 --no-check-certificate --no-cache --no-cookies --show-progress -O "$c/$pkg_4" "$link_pkg_4"
        wget -q --tries=30 --no-check-certificate --no-cache --no-cookies --show-progress -O "$c/$pkg_5" "$link_pkg_5"
        wget -q --tries=30 --no-check-certificate --no-cache --no-cookies --show-progress -O "$c/$pkg_6" "$link_pkg_6"
        wget -q --tries=30 --no-check-certificate --no-cache --no-cookies --show-progress -O "$c/$pkg_7" "$link_pkg_7"
    fi

echo -e "\ninstalling cuda packages"
echo -e "this can take a while, please wait\n"
    echo "> installing cuda"
    yes "Y" | tar -xf "$c/$pkg_1"
    echo "> installing cuda-tools"
    yes "Y" | tar -xf "$c/$pkg_2"
    echo "> installing opencl-nvidia"
    yes "Y" | tar -xf "$c/$pkg_3"
    echo "> installing nvidia-container-toolkit"
    yes "Y" | tar -xf "$c/$pkg_6"
    echo "> installing libnvidia-container"
    yes "Y" | tar -xf "$c/$pkg_7"
    echo "> installing nvidia-settings"
    yes "Y" | tar -xf "$c/$pkg_4"
    echo "> installing nvidia-utils"
    yes "Y" | tar -xf "$c/$pkg_5"

    cp -r "$c"/usr/bin/* "$c"/bin/* 2>/dev/null

    rm -rf "$c/$pkg_1" 2>/dev/null
    rm -rf "$c/$pkg_2" 2>/dev/null
    rm -rf "$c/$pkg_3" 2>/dev/null
    rm -rf "$c/$pkg_4" 2>/dev/null
    rm -rf "$c/$pkg_5" 2>/dev/null
    rm -rf "$c/$pkg_6" 2>/dev/null
    rm -rf "$c/$pkg_7" 2>/dev/null

echo -e "\ncuda $cudaver should now be available inside conty arch container\n"

# -------------------------------------------------------------------------------
# -------------------------------------------------------------------------------
# -------------------------------------------------------------------------------
echo
cgroups
exit 0
