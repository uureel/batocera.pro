#!/bin/bash

ver=$(ldd --version | head -n1 | rev | awk '{print $1}' | rev)
echo -e "\n\nPREPARING LIBC $ver DT_HASH FIX FOR STEAM...\n\n"

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

dos2unix $f 2>/dev/null
chmod 777 $f 2>/dev/null

/tmp/fixlibc
rm $f 2>/dev/null
#exit