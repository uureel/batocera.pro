#!/usr/bin/env bash 
# SYNC HEROIC LAUNCHER GAMES TO HEROIC SYSTEM ROMS
# ---------------------------------------------------
roms=/userdata/roms/heroic
images=/userdata/roms/heroic/images
icons=/userdata/system/pro/heroic/config/heroic/icons
extra=/userdata/system/pro/heroic/extra
list=$extra/gamelist.txt
games=$extra/games.txt
check=$extra/check.txt; rm -rf $check 2>/dev/null
all=$extra/all.txt; rm -rf $all 2>/dev/null
reload=0
mkdir -p "$images" 2>/dev/null
rm -rf "$list"
ls "$icons" | cut -d "." -f1 >> "$list" 
nrgames=$(cat "$list" | wc -l)
if [[ -e "$list" ]]; then
  if [[ $nrgames > 0 ]]; then
    g=1; for g in $(seq 1 $nrgames); 
    do
    gid=$(cat "$list" | sed ''$g'q;d')
    icon=$(ls "$icons" | grep "$gid" | head -n1)
    cp "$icons/$icon" "$images/$icon" 2>/dev/null
      # check if rom needs to be created
      find /userdata/roms/heroic -maxdepth 1 -not -type d | sed 's,^.*/heroic/,,g' | sed 's,gamelist.xml,,g' >> $all
      dos2unix $all 2>/dev/null
      romsnr=$(cat $all | wc -l)
      r=1; while [[ "$r" -le "$romsnr" ]]; 
      do
      thisrom=$(cat $all | sed ''$r'q;d')
      if [[ $thisrom != "" ]]; then
      romcheck=$(cat "$roms/$thisrom")
      #  &remove empty roms
         ## &remove roms if previously existing games were removed from heroic \\\
         if [[ -e "$images/$romcheck.png" ]] && [[ -e "$icons/$romcheck.png" ]]; 
         then
          echo -e "$romcheck" >> $check
         fi
         if [[ -e "$images/$romcheck.jpg" ]] && [[ -e "$icons/$romcheck.jpg" ]]; 
         then
          echo -e "$romcheck" >> $check
         fi
         if [[ -e "$images/$romcheck.jpg" ]] && [[ ! -e "$icons/$romcheck.jpg" ]]; 
         then
           rm "$roms/$thisrom" 2>/dev/null; reload=1
           rm "$images/$romcheck.jpg" 2>/dev/null; reload=1
         fi
         if [[ -e "$images/$romcheck.png" ]] && [[ ! -e "$icons/$romcheck.png" ]]; 
         then
           rm "$roms/$thisrom" 2>/dev/null; reload=1
           rm "$images/$romcheck.png" 2>/dev/null; reload=1
         fi
         ## ///
      #  //
      fi
      ((r++))
      done
      if [[ "$(cat $check | grep $gid | head -n 1)" = "" ]]; then
      rm -rf "$roms/$gid.txt" 2>/dev/null
      echo "$gid" >> "$roms/$gid.txt"
      fi
      # /
    ((g++))
    done
  fi
fi
if [[ -e "$games" ]]; then
  was=$(cat "$games" | wc -l)
  if [[ "$nrgames" > "$was" ]] || [[ "$reload" = "1" ]]; then
    rm -rf "$games" 2>/dev/null
    echo "$nrgames" >> "$games" 
    curl http://127.0.0.1:1234/reloadgames
  fi
else 
  echo "$nrgames" >> "$games" 
  curl http://127.0.0.1:1234/reloadgames  
fi
rm -rf $check 2>/dev/null
rm -rf $all 2>/dev/null