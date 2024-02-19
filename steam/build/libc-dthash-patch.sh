#!/bin/bash

ver=$(ldd --version | head -n1 | rev | awk '{print $1}' | rev)
echo -e "\n\nPREPARING LIBC $ver DT_HASH FIX FOR STEAM...\n\n"

# prepare libc patcher
f=/tmp/fixlibc
rm $f 2>/dev/null
echo '#!/bin/bash' >> $f
echo "ver=$ver" >> $f
echo 'mkdir ~/build 2>/dev/null && rm -rf ~/build/glibc && cd ~/build' >> $f
echo 'git clone https://sourceware.org/git/glibc.git ~/build/glibc' >> $f
echo 'cd ~/build/glibc' >> $f
echo "git checkout glibc-$ver" >> $f
echo 'mkdir ~/build/glibc/build && cd ~/build/glibc/build' >> $f
echo 'echo -e "\n\nCONFIGURING...\n\n"' >> $f
echo 'export CFLAGS="$CFLAGS -O3 -fno-stack-protector -fno-PIC -D_FORTIFY_SOURCE=0"' >> $f
echo 'export LDFLAGS="$LDFLAGS -Wl,--hash-style=both -Wl,-z,norelro"' >> $f
echo 'export LDFLAGS.so="-Wl,--hash-style=both -Wl,-z,norelro"' >> $f
echo 'export LDFLAGS-rtld="-Wl,--hash-style=both -Wl,-z,norelro"' >> $f
echo '../configure \' >> $f
echo '    --prefix=/usr \' >> $f
echo '    --with-headers=/usr/include \' >> $f
echo '    --with-bugurl=https://bugs.archlinux.org/ \' >> $f
echo '    --enable-bind-now \' >> $f
echo '    --enable-cet \' >> $f
echo '    --enable-kernel=4.4 \' >> $f
echo '    --enable-multi-arch \' >> $f
echo '    --disable-stack-protector \' >> $f
echo '    --enable-systemtap \' >> $f
echo '    --disable-crypt \' >> $f
echo '    --disable-profile \' >> $f
echo '    --disable-werror \' >> $f
echo '    --libdir=/usr/lib \' >> $f
echo '    --libexecdir=/usr/lib' >> $f
echo 'echo -e "\n\nCOMPILING...\n\n"' >> $f
echo "make -j$(nproc)" >> $f
echo 'echo -e "\n\nINSTALLING...\n\n"' >> $f
echo 'sudo make install' >> $f
echo 'cd ~/' >> $f
echo 'rm -rf ~/build/glibc' >> $f

# run libc patcher
dos2unix $f 2>/dev/null
chmod 777 $f 2>/dev/null
/tmp/fixlibc

# fix borked faudio 
yes "Y" | pacman -S gstreamer
yes "Y" | pacman -S faudio
cd /tmp/
f=/tmp/lib32faudio.pkg.tar.zst
link=https://builds.garudalinux.org/repos/chaotic-aur/x86_64/lib32-faudio-tkg-git-24.02.r0.g38e9da7-1-x86_64.pkg.tar.zst
wget -O "$f" "$link"
yes "Y" | pacman -U "$f"
rm "$f"
cd ~/

# fix lutris on nvidia
cd /opt
git clone https://github.com/lutris/lutris
sed -i 's,os.geteuid() == 0,os.geteuid() == 888,g' /opt/lutris/lutris/gui/application.py 2>/dev/null
f=/bin/lutris
cp $f /bin/lutris-git 2>/dev/null
rm $f 2>/dev/null
echo '#!/bin/bash' >> $f
echo '/opt/lutris/bin/lutris "${@}"' >> $f
dos2unix $f 2>/dev/null
chmod 777 $f 2>/dev/null

# run additional fixes
sed -i '/<description>.*<\/description>/d' /etc/fonts/fonts.conf 2>/dev/null
sed -i '/<description>.*<\/description>/d' /etc/fonts/conf.d/* 2>/dev/null
cd /usr/lib
  rm $(find /usr/lib | grep nvidia) 2>/dev/null
  #find . -path ./python\* -prune -o -type f -name \*nvidia\* -exec rm {} +
cd /usr/lib32 
  rm $(find /usr/lib32 | grep nvidia) 2>/dev/null
rm /usr/bin/samba* 2>/dev/null
rm /usr/bin/smb* 2>/dev/null
rm -rf ~/build 2>/dev/null

h=/tmp/hash && rm $h 2>/dev/null
readelf -d /usr/lib/libc.so.6 | grep 'HASH' >> $h
	if [[ "$(cat $h | grep '(HASH)')" != "" ]] && [[ "$(cat $h | grep '(GNU_HASH)')" != "" ]]; then
		echo
		echo "PATCHED OK!"
		echo
	else
		echo
		echo "LOOKS LIKE PATCH FAILED..."
		echo	
	fi
rm $f 2>/dev/null
rm $h 2>/dev/null

#exit