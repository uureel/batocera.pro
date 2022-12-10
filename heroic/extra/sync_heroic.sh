#!/usr/bin/env bash 
# SYNC HEROIC LAUNCHER GAMES TO HEROIC SYSTEM ROMS
# ---------------------------------------------------
roms=/userdata/roms/heroic
images=/userdata/roms/heroic/images
icons=/userdata/system/pro/heroic/config/heroic/icons
extra=/userdata/system/pro/heroic/extra
list=$extra/gamelist.txt
games=$extra/games.txt
mkdir -p $images 2>/dev/null
rm -rf $list
ls $icons | cut -d "." -f1 >> $list 
nrgames=$(cat $list | wc -l)
if [[ -e $list ]]; then
  if [[ $nrgames > 0 ]]; then
    g=1; for g in $(seq 1 $nrgames); 
    do
    gid=$(cat $list | sed ''$g'q;d')
    icon=$(ls $icons | grep $gid | head -n1)
    cp $icons/$icon $images/$icon 2>/dev/null
    rm -rf $roms/$gid.txt 2>/dev/null
      check=$extra/check.txt; rm -rf $check
      allroms=$(ls $roms >> $check)
      romsnr=$(ls $roms | wc -l)
      r=1; for r in $(seq 1 $romsnr); 
      do
      rom=$(cat $allroms | sed ''$r'q;d')
      echo "$rom" >> $check
      ((r++))
      done
      if [[ "$(cat $check | grep $gid)" = "" ]]; then
      echo "$gid" >> $roms/$gid.txt
      fi
    ((g++))
    done 
  fi 
fi
if [[ -e $games ]]; then 
  was=$(cat $games | wc -l)
  if [[ $nrgames > $was ]]; then
    rm -rf $games 2>/dev/null
    echo "$nrgames" >> $games 
    curl http://127.0.0.1:1234/reloadgames
  fi
else 
  echo "$nrgames" >> $games 
  curl http://127.0.0.1:1234/reloadgames  
fi
rm -rf $check 2>/dev/null