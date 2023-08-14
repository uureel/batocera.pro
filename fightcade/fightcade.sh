#!/usr/bin/env bash 
######################################################################
# BATOCERA-FIGHTCADE // FIGHTCADE.BATOCERA.PRO INSTALLER
######################################################################
#/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
#
# -- check system before proceeding
if [[ "$(uname -m)" != *"86_64"* ]]; then echo -e "\n\nFIGHTCADE2 NEEDS X86_64 CPU (INTEL/AMD), SORRY\n\n" && exit 1; fi
clear; echo
kernel=$(uname -a | awk '{print $3}' 2>/dev/null)
if [[ "$kernel" < "5.18" ]]; then 
echo -e "${RED}ERROR: THIS SYSTEM IS NOT SUPPORTED"
echo -e "${RED}YOU NEED BATOCERA VERSION 35+"
sleep 3
exit 0; exit 1; exit 2
fi 
free="$(df /userdata | awk 'END {print int($4/(1024*1024))}')"
if [[ "$free" -le "4" ]]; then 
echo -e "${RED}ERROR: YOU NEED AT LEAST 4GB OF FREE DISK SPACE ON /USERDATA "
echo -e "${RED}YOU HAVE $free GB"
sleep 3
exit 0; exit 1; exit 2
fi 
#
#/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
#
spinner()
{
    local pid=$1
    local delay=0.2
    local spinstr='|/-\'
    while [ "$(ps a | awk '{print $1}' | grep $pid)" ]; do
        local temp=${spinstr#?}
        printf "PLEASE WAIT . . .  %c   " "$spinstr"
        local spinstr=$temp${spinstr%"$temp"}
        sleep $delay
        printf "\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b"
    done
    printf "   \b\b\b\b"
}
#
#/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
# prepare paths and files for installation 
cd ~/
killall fc2-electron 2>/dev/null
fightcade=/userdata/system/pro/fightcade; mkdir -p $fightcade/extras 2>/dev/null
tmp=/tmp/batocera-fightcade; rm -rf $tmp 2>/dev/null; mkdir -p /tmp 2>/dev/null
# --------------------------------------------------------------------
# -- prepare dependencies for this app and the installer: 
url=https://raw.githubusercontent.com/uureel/batocera-fightcade/main/installer
wget -q -O $tmp/installer.sh $url/fightcade.sh 2>/dev/null 
dos2unix $tmp/installer.sh 2>/dev/null; chmod a+x $tmp/installer.sh 2>/dev/null
wget -q -O /tmp/libselinux.so.1 $url/libselinux.so.1 2>/dev/null 
wget -q -O /tmp/tar $url/tar 2>/dev/null; chmod a+x /tmp/tar 2>/dev/null
cp /tmp/libselinux.so.1 /lib/ 2>/dev/null
cp /tmp/tar /bin/tar 2>/dev/null
# --------------------------------------------------------------------
# show console info: 
clear
echo -e "--------------------------------------------------------"
echo -e "--------------------------------------------------------"
echo -e ""
echo -e "BATOCERA.PRO/FIGHTCADE INSTALLER"
echo -e ""
echo -e "--------------------------------------------------------"
echo -e "--------------------------------------------------------"
echo
# --------------------------------------------------------------------
sleep 0.33
echo -e "THIS WILL INSTALL BATOCERA-FIGHTCADE"
echo -e "WITH ALL DEPENDENCIES FOR BATOCERA V36/37/38"
echo
echo -e "FIGHTCADE WILL BE AVAILABLE IN PORTS AND F1->APPLICATIONS "
echo -e "AND INSTALLED IN /USERDATA/SYSTEM/PRO/FIGHTCADE"
echo
sleep 3
echo
#
#/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
# -- download the package 
# -- set temp for curl download
dl=/userdata/system/pro/fightcade/extras/downloads
rm -rf $dl 2>/dev/null; mkdir $dl 2>/dev/null; cd $dl 
echo
echo -e "DOWNLOADING FIGHTCADE [1/9] . . ."
curl --progress-bar --remote-name --location https://github.com/uureel/batocera-fightcade/raw/main/package/fightcade.tar.gz.partaa
echo -e "DOWNLOADING FIGHTCADE [2/9] . . ."
curl --progress-bar --remote-name --location https://github.com/uureel/batocera-fightcade/raw/main/package/fightcade.tar.gz.partab
echo -e "DOWNLOADING FIGHTCADE [3/9] . . ."
curl --progress-bar --remote-name --location https://github.com/uureel/batocera-fightcade/raw/main/package/fightcade.tar.gz.partac
echo -e "DOWNLOADING FIGHTCADE [4/9] . . ."
curl --progress-bar --remote-name --location https://github.com/uureel/batocera-fightcade/raw/main/package/fightcade.tar.gz.partad
echo -e "DOWNLOADING FIGHTCADE [5/9] . . ."
curl --progress-bar --remote-name --location https://github.com/uureel/batocera-fightcade/raw/main/package/fightcade.tar.gz.partae
echo -e "DOWNLOADING FIGHTCADE [6/9] . . ."
curl --progress-bar --remote-name --location https://github.com/uureel/batocera-fightcade/raw/main/package/fightcade.tar.gz.partaf
echo -e "DOWNLOADING FIGHTCADE [7/9] . . ."
curl --progress-bar --remote-name --location https://github.com/uureel/batocera-fightcade/raw/main/package/fightcade.tar.gz.partag
echo -e "DOWNLOADING FIGHTCADE [8/9] . . ."
curl --progress-bar --remote-name --location https://github.com/uureel/batocera-fightcade/raw/main/package/fightcade.tar.gz.partah
echo -e "DOWNLOADING FIGHTCADE [9/9] . . ."
curl --progress-bar --remote-name --location https://github.com/uureel/batocera-fightcade/raw/main/package/fightcade.tar.gz.partai
#
# check downloads integrity 
p1=$dl/fightcade.tar.gz.partaa
p2=$dl/fightcade.tar.gz.partab
p3=$dl/fightcade.tar.gz.partac
p4=$dl/fightcade.tar.gz.partad
p5=$dl/fightcade.tar.gz.partae
p6=$dl/fightcade.tar.gz.partaf
p7=$dl/fightcade.tar.gz.partag
p8=$dl/fightcade.tar.gz.partah
p9=$dl/fightcade.tar.gz.partai
if [[ -f "$p1" ]] && [[ -f "$p2" ]] && [[ -f "$p3" ]] && [[ -f "$p4" ]] && [[ -f "$p5" ]] && [[ -f "$p6" ]] && [[ -f "$p7" ]] && [[ -f "$p8" ]] && [[ -f "$p9" ]]; 
    then 
    p1m=$(md5sum $p1 | awk '{print $1}')
    p2m=$(md5sum $p2 | awk '{print $1}')
    p3m=$(md5sum $p3 | awk '{print $1}')
    p4m=$(md5sum $p4 | awk '{print $1}')
    p5m=$(md5sum $p5 | awk '{print $1}')
    p6m=$(md5sum $p6 | awk '{print $1}')
    p7m=$(md5sum $p7 | awk '{print $1}')
    p8m=$(md5sum $p8 | awk '{print $1}')
    p9m=$(md5sum $p9 | awk '{print $1}')
    if [[ "$p1m" = "978124aae588ef07d856a1ef0c9c669c" ]] && [[ "$p2m" = "8a9f5f08ef33879ff79c6026f785247b" ]] && [[ "$p3m" = "3edd3cf329397daa0d39ebd23928aac2" ]] && [[ "$p4m" = "7603a41027baba2de7ee78791ccb01b3" ]] && [[ "$p5m" = "ead03d97ac853097c2c0a3af70fdefca" ]] && [[ "$p6m" = "5a90b5818b1966067ea06fd42bd54ffb" ]] && [[ "$p7m" = "0b5073cf440b3f41f38582a1ee773ee1" ]] && [[ "$p8m" = "bdbc04d91cedb9fce8505fb04e127237" ]] && [[ "$p9m" = "6cbbf0708e94bb00bc45227af1acdc43" ]]; 
        then 
            #
            size=$(du -h ~/pro/fightcade/extras/downloads | tail -n 1 | awk '{print $1}' | sed 's,G,,g')
            echo -e "DONE, $size "
        else 
            echo
            echo -e "DOWNLOAD WENT BAD! ;( "
            sleep 2
            echo -e "RESTARTING INSTALLER . . ."
            sleep 2
            exit 1 & curl -L fightcade.batocera.pro | bash
    fi
fi
# 
#/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
#
echo
echo -e "MERGING . . ."
cd /userdata/system/pro/fightcade/extras/downloads
cat /userdata/system/pro/fightcade/extras/downloads/fightcade.tar.gz.parta* >/userdata/system/pro/fightcade/extras/downloads/fightcade.tar.gz
echo -e "DONE,"
#
#/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
#
echo
echo -e "EXTRACTING. . . ."
cd /userdata/system/pro/
mv /userdata/system/pro/fightcade/extras/downloads/fightcade.tar.gz /userdata/system/pro/
chmod a+x /bin/tar 2>/dev/null
/bin/tar -xf /userdata/system/pro/fightcade.tar.gz 
rm -rf /userdata/system/pro/fightcade/extras/downloads 2>/dev/null
size=$(du -h ~/pro/fightcade | tail -n 1 | awk '{print $1}' | sed 's,G,,g')
echo -e "$size GB"
echo -e "DONE,"
#
#/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
#
echo
echo -e "INSTALLING . . ."
#
# check d2u/a+x 
dos2unix /userdata/system/pro/fightcade/extras/startup.sh 2>/dev/null
dos2unix /userdata/system/pro/fightcade/extras/wine.sh 2>/dev/null
dos2unix /userdata/system/pro/fightcade/Fightcade2.sh 2>/dev/null
chmod a+x /userdata/system/pro/fightcade/extras/startup.sh 2>/dev/null
chmod a+x /userdata/system/pro/fightcade/extras/wine.sh 2>/dev/null
chmod a+x /userdata/system/pro/fightcade/Fightcade2.sh 2>/dev/null
/userdata/system/pro/fightcade/extras/startup.sh 2>/dev/null
# 
#/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
# 
# -------------------------------------------------------------------
# ADD TO BATOCERA AUTOSTART > /USERDATA/SYSTEM/CUSTOM.SH TO ENABLE F1
# -------------------------------------------------------------------
# 
csh=/userdata/system/custom.sh; dos2unix $csh 2>/dev/null
startup="/userdata/system/pro/fightcade/extras/startup.sh"
if [[ -f $csh ]];
   then
      tmp1=/tmp/tcsh1
      tmp2=/tmp/tcsh2
      remove="$startup"
      rm $tmp1 2>/dev/null; rm $tmp2 2>/dev/null
      nl=$(cat "$csh" | wc -l); nl1=$(($nl + 1))
         l=1; 
         for l in $(seq 1 $nl1); do
            ln=$(cat "$csh" | sed ""$l"q;d" );
               if [[ "$(echo "$ln" | grep "$remove")" != "" ]]; then :; 
                else 
                  if [[ "$l" = "1" ]]; then
                        if [[ "$(echo "$ln" | grep "#" | grep "/bin/" | grep "bash" )" != "" ]]; then :; else echo "$ln" >> "$tmp1"; fi
                     else 
                        echo "$ln" >> $tmp1;
                  fi
               fi            
            ((l++))
         done
         # 
         rm $tmp2 2>/dev/null
           echo -e '#!/bin/bash' >> $tmp2
           echo -e "\n$startup " >> $tmp2          
           cat "$tmp1" | sed -e '/./b' -e :n -e 'N;s/\n$//;tn' >> "$tmp2"
           cp $tmp2 $csh 2>/dev/null; dos2unix $csh 2>/dev/null; chmod a+x $csh 2>/dev/null  
   else  #(!f csh)   
       echo -e '#!/bin/bash' >> $csh
       echo -e "\n$startup\n" >> $csh  
       dos2unix $csh 2>/dev/null; chmod a+x $csh 2>/dev/null  
fi 
dos2unix ~/custom.sh 2>/dev/null
chmod a+x ~/custom.sh 2>/dev/null
# 
#/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
# 
# get updated files:
# --- 
url=https://raw.githubusercontent.com/uureel/batocera-fightcade/main/installer
# startup 
wget -q -O /userdata/system/pro/fightcade/extras/startup.sh $url/startup.sh 2>/dev/null 
dos2unix /userdata/system/pro/fightcade/extras/startup.sh 1>/dev/null 2>/dev/null
chmod a+x /userdata/system/pro/fightcade/extras/startup.sh 2>/dev/null
# launcher 
wget -q -O /userdata/system/pro/fightcade/Fightcade2.sh $url/Fightcade2.sh 2>/dev/null 
dos2unix /userdata/system/pro/fightcade/Fightcade2.sh 1>/dev/null 2>/dev/null
chmod a+x /userdata/system/pro/fightcade/Fightcade2.sh 2>/dev/null
# winesync 
wget -q -O /userdata/system/pro/fightcade/extras/winesync.sh $url/winesync.sh 2>/dev/null 
dos2unix /userdata/system/pro/fightcade/extras/winesync.sh 1>/dev/null 2>/dev/null
chmod a+x /userdata/system/pro/fightcade/extras/winesync.sh 2>/dev/null
# syncwine 
wget -q -O /userdata/system/pro/fightcade/extras/syncwine.sh $url/syncwine.sh 2>/dev/null 
dos2unix /userdata/system/pro/fightcade/extras/syncwine.sh 1>/dev/null 2>/dev/null
chmod a+x /userdata/system/pro/fightcade/extras/syncwine.sh 2>/dev/null
# unwine 
wget -q -O /userdata/system/pro/fightcade/extras/unwine.sh $url/unwine.sh 2>/dev/null 
dos2unix /userdata/system/pro/fightcade/extras/unwine.sh 1>/dev/null 2>/dev/null
chmod a+x /userdata/system/pro/fightcade/extras/unwine.sh 2>/dev/null
# wine 
#wget -q -O /userdata/system/pro/fightcade/extras/wine.sh $url/wine.sh 2>/dev/null 
#dos2unix /userdata/system/pro/fightcade/extras/wine.sh 2>/dev/null
#chmod a+x /userdata/system/pro/fightcade/extras/wine.sh 2>/dev/null
# pad2key 
url=https://raw.githubusercontent.com/uureel/batocera-fightcade/main/installer
wget -q -O /userdata/roms/ports/Fightcade2.sh.keys $url/Fightcade2.sh.keys 2>/dev/null 
# 
#/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
#
# + additional updates/fixes for v37: 
url=https://github.com/uureel/batocera-fightcade/raw/main/installer
wget -q -O /userdata/system/pro/fightcade/extras/wine.sh $url/wine.sh 2>/dev/null
  dos2unix /userdata/system/pro/fightcade/extras/wine.sh 1>/dev/null 2>/dev/null 
  chmod a+x /userdata/system/pro/fightcade/extras/wine.sh 2>/dev/null 
wget -q -O /userdata/system/pro/fightcade/extras/liblua5.2.so.0 $url/liblua5.2.so.0 2>/dev/null 
wget -q -O /userdata/system/pro/fightcade/extras/liblua5.3.so.0 $url/liblua5.3.so.0 2>/dev/null 
wget -q -O /userdata/system/pro/fightcade/extras/libzip.so.4 $url/libzip.so.4 2>/dev/null 
wget -q -O /userdata/system/pro/fightcade/extras/libzip.so.5 $url/libzip.so.5 2>/dev/null 
# 
#/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
#
# add Fightcade2 to ports
cp /userdata/system/pro/fightcade/Fightcade2.sh /userdata/roms/ports/Fightcade2.sh 2>/dev/null
# reload gamelists 
curl http://127.0.0.1:1234/reloadgames 
echo -e "DONE,"
# 
#/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
# 
# set icon for f1 launcher 
if [[ -f /userdata/system/pro/fightcade/extras/fightcade.desktop ]]; then 
    sed -i 's/icon.png/icong.png/g' /userdata/system/pro/fightcade/extras/fightcade.desktop 2>/dev/null
    /userdata/system/pro/fightcade/extras/startup.sh 2>/dev/null 
fi
# add --disable-gpu to fightcade launcher for compatibility  
if [[ -f /userdata/system/pro/fightcade/fightcade/Fightcade2.sh ]]; then
    if [[ $(cat "/userdata/system/pro/fightcade/fightcade/Fightcade2.sh" | grep "disable-gpu") = "" ]] || [[ $(cat "/userdata/system/pro/fightcade/fightcade/Fightcade2.sh" | grep "no-sandbox") != "" ]]; then
    sed -i 's/--no-sandbox/--no-sandbox --disable-gpu/g' /userdata/system/pro/fightcade/fightcade/Fightcade2.sh 2>/dev/null
    fi 
fi
# 
#/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
#
# finished installing // 
echo 
echo 
echo -e "FIGHTCADE INSTALLED :) " 
echo 
# done
exit 0 
