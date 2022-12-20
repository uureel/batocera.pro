#!/bin/bash
url=https://raw.githubusercontent.com/uureel/batocera.pro/main/f1/extra
wget -q -O /userdata/system/configs/libxdo.so.3 $url/libxdo.so.3 2>/dev/null
wget -q -O /userdata/system/configs/xdotool $url/xdotool 2>/dev/null
wget -q -O /userdata/roms/ports/F1.sh $url/F1.sh 2>/dev/null
wget -q -O /userdata/roms/ports/F1.press $url/F1.press 2>/dev/null
chmod a+x /userdata/system/configs/xdotool 2>/dev/null
chmod a+x /userdata/roms/ports/F1.press 2>/dev/null
chmod a+x /userdata/roms/ports/F1.sh 2>/dev/null
cp /userdata/system/configs/libxdo.so.3 /lib/ 2>/dev/null
cp /userdata/system/configs/xdotool /usr/bin/ 2>/dev/null
sleep 1
/userdata/roms/ports/F1.press &

