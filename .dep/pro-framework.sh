#!/bin/bash
###########################
# batocera.pro-framework 
# v 1
#
###########################
X='\033[0m'               # / resetcolor
RED='\033[1;31m'          # red
BLUE='\033[1;34m'         # blue
GREEN='\033[1;32m'        # green
YELLOW='\033[1;33m'       # yellow
PURPLE='\033[1;35m'       # purple
CYAN='\033[1;36m'         # cyan
#-------------------------#
DARKRED='\033[0;31m'      # darkred
DARKBLUE='\033[0;34m'     # darkblue
DARKGREEN='\033[0;32m'    # darkgreen
DARKYELLOW='\033[0;33m'   # darkyellow
DARKPURPLE='\033[0;35m'   # darkpurple
DARKCYAN='\033[0;36m'     # darkcyan
#-------------------------#
WHITE='\033[0;37m'        # white
BLACK='\033[0;30m'        # black
###########################
#-------------------------------------
X=$BLUE
A=$BLUE
H=$WHITE
#-------------------------------------

export DISPLAY=:0.0

#-------------------------------------
function start-pro-framework() {
	cd /tmp ; c=/tmp/batocera.pro-config ; rm $c 2>/dev/null
		echo "app="$app"" >> $c
		echo "url="$url"" >> $c
		echo "prefix="$prefix"" >> $c
		echo "name="$name"" >> $c
		echo "ext="$ext"" >> $c
		echo "dep="$dep"" >> $c
		echo "repo="$repo"" >> $c 
		echo "mode="$mode"" >> $c 
		echo "theme="$theme"" >> $c 
		echo "loader="$loader"" >> $c 
		echo "custom="$custom"" >> $c 
		echo "port="$port"" >> $c 
if [[ "$prefix" = "" ]]; then prefix=/userdata/system/pro/$app; fi	
if [[ "$name" = "" ]]; then name="$app"; fi 	
	cd /tmp ; c=/tmp/batocera.pro-config ; rm $c 2>/dev/null
		echo "app="$app"" >> $c
		echo "url="$url"" >> $c
		echo "prefix="$prefix"" >> $c
		echo "name="$name"" >> $c
		echo "ext="$ext"" >> $c
		echo "dep="$dep"" >> $c
		echo "repo="$repo"" >> $c 
		echo "mode="$mode"" >> $c 
		echo "theme="$theme"" >> $c 
		echo "loader="$loader"" >> $c 
		echo "custom="$custom"" >> $c 
		echo "port="$port"" >> $c 
mkdir -p "$prefix/extras" 2>/dev/null 
mkdir -p ~/pro/.dep 2>/dev/null  
} 
export -f start-pro-framework
start-pro-framework 2>/dev/null
#-------------------------------------



#-------------------------------------
function say-hi() {
app="$(cat /tmp/batocera.pro-config | grep "app=" | cut -d "=" -f2)"
prefix="$(cat /tmp/batocera.pro-config | grep "prefix=" | cut -d "=" -f2)"
clear
echo
echo
echo -e "${A}██${X}  ${H}batocera.pro "$app" installer "
sleep 2
}
export -f say-hi
#-------------------------------------



#-------------------------------------
function say-bye() {
app="$(cat /tmp/batocera.pro-config | grep "app=" | cut -d "=" -f2)"
prefix="$(cat /tmp/batocera.pro-config | grep "prefix=" | cut -d "=" -f2)"
echo
echo -e "${A}  ${X}"
echo -e "${A}██${X}  ${H}"$app" installed ${A}to $prefix"
port=$(cat /tmp/batocera.pro-port | tail -n 1 | grep "added")
if [[ "$port" != "" ]]; then
	echo -e "${A}  ${X}  ${A}& available in f1->applications and ports"
else
	echo -e "${A}  ${X}  ${A}& available in f1->applications"
fi
echo -e "${A}  ${X}        "
#echo -e "${A}╚╝${X}        "
echo
sleep 8
# rm -rf /tmp/batocera.pro* 2>/dev/null
curl http://127.0.0.1:1234/reloadgames
}
export -f say-bye 

function spacer() {
echo -e "\n\n"
}
export -f spacer 
#-------------------------------------



#-------------------------------------
function download-from-to() {
app="$(cat /tmp/batocera.pro-config | grep "app=" | cut -d "=" -f2)"
prefix="$(cat /tmp/batocera.pro-config | grep "prefix=" | cut -d "=" -f2)"
	from="$1"
	to="$2"
		time=$(date +"%y%m%d-%H%M%S")
		temp="/tmp/batocera.pro-$time"
		mkdir -p "$temp"
		mkdir -p "$to" 
			cd "$temp"
				echo -e "${A}╚╝${X}  downloading  "$from""
					curl --progress-bar --remote-name --location "$1"
						size=$(du -h "$temp" | awk '{print $1}')
							echo -e "${A}╔╗${X}  downloaded,  "$size""
			cd /userdata/system/
				cp -rL "$temp/*" "$to"
				echo -e "${A}  ${X}  into:  "$to"/"
				#echo -e "${A}  ${X}        "
				rm -rf "$temp"
sleep 2
}
export -f download-from-to 
#-------------------------------------



#-------------------------------------
function download-smallfiles() {
app="$(cat /tmp/batocera.pro-config | grep "app=" | cut -d "=" -f2)"
prefix="$(cat /tmp/batocera.pro-config | grep "prefix=" | cut -d "=" -f2)"
	from="$1"
	to="$2"
		time=$(date +"%y%m%d-%H%M%S")
		temp="/tmp/batocera.pro-$time"
		mkdir -p "$temp"
		mkdir -p "$to" 
			cd "$temp"
				echo -e "${A}██${X}  ${H}downloading:   "$from""
					curl --progress-bar --remote-name --location "$1"
						size=$(du -h "$temp" | awk '{print $1}')
							echo -e "${A}  ${X}  downloaded,  "$size""
			cd /userdata/system/
				cp -rL "$temp/*" "$to"
				echo -e "${A}  ${X}  into:  "$to"/"
				#echo -e "${A}  ${X}        "
				rm -rf "$temp"
sleep 2
}
export -f download-from-to 
#-------------------------------------



#-------------------------------------
function get-appimage() {
app="$(cat /tmp/batocera.pro-config | grep "app=" | cut -d "=" -f2)"
prefix="$(cat /tmp/batocera.pro-config | grep "prefix=" | cut -d "=" -f2)"
from="$1"
to="$2"
if [[ "$to" != "appdir" ]] && [[ "$to" != "$prefix" ]]; then 
to="$2"
else 
	if [[ "$to" = "appdir" ]]; then
	to="$prefix/$app.AppImage"
	fi
	if [[ "$to" = "$prefix" ]]; then
	to="$prefix/$app.AppImage"
	fi
fi
name="$3"
if [[ "$name" != "" ]]; then name="$name"; else name="$app"; fi
echo
echo -e "${A}  ${X}"
echo -e "${A}██${X}  ${H}downloading $(echo "$app")"
	if [[ "$2" = "" ]]; then to="$prefix"; fi
		time=$(date +"%y%m%d-%H%M%S")
		temp="/tmp/batocera.pro-$time"
		mkdir -p "$temp"
		mkdir -p "$to" 
		size_before=$(du -H "$temp" | tail -n 1 | awk '{print $1}')
			cd "$temp"
				echo -e "${A}  ${X}  from > ${X}$(echo "$from" | sed 's,https://,,g' | sed 's,http://,,g')${A}"
				echo -e "${A}  ${X}  to   > ${X}$(echo "$to")/$(echo "$app").AppImage${A}"
					curl --progress-bar --remote-name --location "$from"
					cp -rL $temp/* "$to"
					chmod a+x $to/$app.AppImage  
						size_after=$(du -H "$temp" | tail -n 1 | awk '{print $1}')
						size=$(($size_after-$size_before))
						if [[ "$size" -le "1000" ]]; then size=$((size)); 
							echo -e "${A}  ${X}  done, $(echo "$size") kB"
						fi 
						if [[ "$size" -gt "1000" ]]; then size=$((size/1000)); 
							echo -e "${A}  ${X}  done, $(echo "$size") MB"
						fi
							#echo -e "${A}  ${X}        "
			cd /userdata/system/
			rm -rf $temp
sleep 2
}
export -f get-appimage
#-------------------------------------



#-------------------------------------
function get-extras() {
app="$(cat /tmp/batocera.pro-config | grep "app=" | cut -d "=" -f2)"
prefix="$(cat /tmp/batocera.pro-config | grep "prefix=" | cut -d "=" -f2)"
#echo
#echo -e "${A}  ${X}"
#echo -e "${A}██${X}  ${A}downloading additional files"
	xurl=https://raw.githubusercontent.com/uureel/batocera.pro/main/$app/extras
	x=https://raw.githubusercontent.com/uureel/batocera.pro/main/$app/extras/extras.txt
	if [[ "$2" = "" ]]; then extras="$prefix/extras/extras.txt"; fi
		time=$(date +"%y%m%d-%H%M%S")
		temp="/tmp/batocera.pro-extras"
		rm -rf $temp 2>/dev/null
		mkdir -p $temp 2>/dev/null
		mkdir -p $prefix/extras 2>/dev/null
		size_before=$(du -H $temp | tail -n 1 | awk '{print $1}')
			cd $temp
					rm "$x" 2>/dev/null
					wget -q "$x" 
					nrfiles=$(cat $temp/extras.txt | wc -l)
					if [[ "$nrfiles" < "1" ]]; then exit 1; fi
echo
echo -e "${A}  ${X}"
echo -e "${A}██${X}  ${H}downloading additional ${A}$nrfiles files "
#echo -e "${A}  ${X}  $nrfiles files found"
					f=1; while [[ "$f" -le "$nrfiles" ]]
					do 
						thisfile="$(cat $temp/extras.txt | sed ''$f'q;d')"
						wget -q "$xurl/$thisfile" 
						f=$(($f+1))
					done 	
					cp -rL $temp/* $prefix/extras/
					dos2unix $prefix/extras/*.sh 2>/dev/null
					chmod a+x $prefix/extras/*.sh 2>/dev/null
						size_after=$(du -H "$temp" | tail -n 1 | awk '{print $1}')
						size=$(($size_after-$size_before))
						if [[ "$size" -le "1000" ]]; then size=$((size)); 
echo -e "${A}  ${X}  done, $(echo "$size") kB"
						fi 
						if [[ "$size" -gt "1000" ]]; then size=$((size/1000)); 
echo -e "${A}  ${X}  done, $(echo "$size") MB"
						fi
							#echo -e "${A}  ${X}        "
		cp $prefix/extras/launcher.sh $prefix/ 2>/dev/null
		cd /userdata/system/
		rm -rf "$temp" 2>/dev/null
sleep 2
}
export -f get-extras
#-------------------------------------



#-------------------------------------
function add-custom() {
app="$(cat /tmp/batocera.pro-config | grep "app=" | cut -d "=" -f2)"
prefix="$(cat /tmp/batocera.pro-config | grep "prefix=" | cut -d "=" -f2)"
	if [[ -e "$prefix/extras/add" ]]; then 
	dos2unix "$prefix/extras/custom.sh"
	chmod a+x "$prefix/extras/custom.sh"
echo
echo -e "${A}  ${X}"
echo -e "${A}██${X}  ${H}installing"
	$prefix/extras/custom.sh 2>/dev/null
echo -e "${A}  ${X}  done "
	sleep 0.2
fi
}
export -f add-custom
#-------------------------------------




#-------------------------------------
function download-dependencies() {
app="$(cat /tmp/batocera.pro-config | grep "app=" | cut -d "=" -f2)"
prefix="$(cat /tmp/batocera.pro-config | grep "prefix=" | cut -d "=" -f2)"
echo -e "${A}██${X}  ${H}downloading:   $(echo "$app")"
	from="$1"
	to="$2"
	if [[ "$2" = "" ]]; then to="/userdata/system/fi/$app"; fi
		time=$(date +"%y%m%d-%H%M%S")
		temp="/tmp/batocera.pro-$time"
		mkdir -p "$temp"
		mkdir -p "$to" 
		size_before=$(du -H "$to" | tail -n 1 | awk '{print $1}')
			cd "$temp"
				echo -e "${A}  ${X}  from:   $(echo "$from")"
				echo -e "${A}  ${X}  into:   $(echo "$to")/"
					curl --progress-bar --remote-name --location "$from"
					chmod a+x "$temp/*"
					mv "$temp/*" "$temp/$app.AppImage"
					mv "$temp/*.AppImage" "$to/"
						size_after=$(du -H "$temp" | tail -n 1 | awk '{print $1}')
						size=$(($size_after-$size_before))
						size=$(($size/1000))
							echo -e "${A}  ${X}  done,   "$size""
							#echo -e "${A}  ${X}        "
			cd /userdata/system/
			rm -rf "$temp" 2>/dev/null
sleep 2
}
export -f download-dependencies 
#-------------------------------------



#-------------------------------------
function prepare-settings() {
app="$(cat /tmp/batocera.pro-config | grep "app=" | cut -d "=" -f2)"
prefix="$(cat /tmp/batocera.pro-config | grep "prefix=" | cut -d "=" -f2)"
echo -e "${A}  ${X}"
echo -e "${A}██${X}  ${H}preparing config"
	cfg=/tmp/batocera.pro-config
	 rm /tmp/batocera.pro-config 2>/dev/null
	 wget -q -O /tmp/batocera.pro-settings
			echo "app=$app" >> $cfg
	 		echo "repo=$repo" >> $cfg
			echo "port=$port" >> $cfg 
sleep 2
}
export -f prepare-settings 
#-------------------------------------



#-------------------------------------
function set-config() {
app="$(cat /tmp/batocera.pro-config | grep "app=" | cut -d "=" -f2)"
prefix="$(cat /tmp/batocera.pro-config | grep "prefix=" | cut -d "=" -f2)"
echo -e "${A}  ${X}"
echo -e "${A}██${X}  ${H}preparing config"
	cfg=/tmp/batocera.pro-config
	 rm /tmp/batocera.pro-config 2>/dev/null
			echo "app=$app" >> $cfg
			echo "url=$url" >> $cfg
			echo "ext=$ext" >> $cfg
			echo "dep=$dep" >> $cfg
	 		echo "repo=$repo" >> $cfg
			echo "port=$port" >> $cfg
	mkdir -p $prefix/extras
sleep 2
}
export -f set-config 
#-------------------------------------




#-------------------------------------
function prepare-launcher() {
app="$(cat /tmp/batocera.pro-config | grep "app=" | cut -d "=" -f2)"
prefix="$(cat /tmp/batocera.pro-config | grep "prefix=" | cut -d "=" -f2)"
echo -e "${A}  ${X}"
echo -e "${A}██${X}  ${H}preparing launcher"
	cfg=/tmp/batocera.pro-config
	repo=""
	app=$(cat $cfg | grep "app=" | cut -d "=" -f2)
	url_launcherenv=""
	# get app launcher environment
	time=$(date +"%y%m%d-%H%M%S")
	temp="/tmp/batocera.pro-$time"
	cd $temp 
	wget -q -O "$temp/env.txt" "$url_launcherenv" 
sleep 2
}
export -f prepare-launcher 
#-------------------------------------



#-------------------------------------
function add-port() {
app="$(cat /tmp/batocera.pro-config | grep "app=" | cut -d "=" -f2)"
prefix="$(cat /tmp/batocera.pro-config | grep "prefix=" | cut -d "=" -f2)"
port="$(cat /tmp/batocera.pro-config | grep "port=" | cut -d "=" -f2)"
#echo -e "${A}  ${X}"
#echo -e "${A}  ${X}"
#echo -e "${A}  ${X}"
#echo -e "${A}██${X}  ${A}preparing port"
	#example: prepare-port "moonlight.sh" "$prefix/launcher.sh"	
	#example: prepare-port (will do the above automatically)
	#example: prepare-port "Moonlight v4.3.1.sh" "/userdata/system/another/path/AnotherFile" 
	name="$1"
	source="$2"
	#--------
	cfg=/tmp/batocera.pro-config
	app=$(cat "$cfg" | grep "app=" | cut -d "=" -f2)
	if [[ "$1" = "" ]]; then 
	name=$(cat "$cfg" | grep "port=" | cut -d "=" -f2)
		if [[ "$name" = "" ]]; then
		name="$app.sh"
		fi 
	fi
	if [[ "$2" = "" ]]; then source="$prefix/launcher.sh"; fi
		time=$(date +"%y%m%d-%H%M%S")
		temp="/tmp/batocera.pro-$time"
		mkdir -p "$temp"
			echo -e '#!/bin/bash ' >> "$temp/$name"
			echo -e "unclutter-remote -s " >> "$temp/$name"
			echo -e "$from " >> "$temp/$name"
			echo -e " " >> "$temp/$name" 
			dos2unix "$temp/$name"
			chmod a+x "$temp/$name"
			cp "$temp/$name" /userdata/roms/ports/
				cp -rL "$prefix/extras/*.sh.keys" "/userdata/roms/ports/$name.keys" 2>/dev/null
		cd /userdata/system/
		rm -rf "$temp" 2>/dev/null
		rm /tmp/batocera.pro-port 2>/dev/null
		echo "added" >> /tmp/batocera.pro-port
sleep 2
}
export -f add-port
#-------------------------------------





#-------------------------------------
function add-autostart() {
#echo -e "${A}  ${X}"
#echo -e "${A}  ${X}"
#echo -e "${A}  ${X}"
#echo -e "${A}██${X}  ${H}preparing launchers"
csh=/userdata/system/custom.sh; dos2unix $csh
startup="/userdata/system/pro-custom.sh"
rm /userdata/system/pro-custom.sh 2>/dev/null
time=$(date +"%y%m%d-%H%M%S")
temp="/tmp/batocera.pro-autostart"
rm -rf /tmp/batocera.pro-autostart 2>/dev/null
mkdir -p /tmp/batocera.pro-autostart 2>/dev/null

if [[ -f $csh ]]; then 
cp "$csh" "$csh-backup-$time"
fi

if [[ -f $csh ]];
   then
      tmp1=$temp/tcsh1.txt
      tmp2=$temp/tcsh2.txt
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
       echo -e '#!/bin/bash' >> $tmp2
       echo -e "\n$startup & \n" >> $tmp2          
      	if [[ -e "$tmp1" ]] && [[ "$(cat $tmp1 | wc -l)" > "0" ]]; then       
      	cat $tmp1 | sed -e '/./b' -e :n -e 'N;s/\n$//;tn' >> $tmp2
   		fi
       		cp $tmp2 $csh
       		dos2unix $csh
       		chmod a+x $csh  
   else  #(!f csh)   
       echo -e '#!/bin/bash' >> $csh
       echo -e "\n$startup & \n" >> $csh  
       dos2unix $csh; chmod a+x $csh  
fi 
dos2unix $csh
chmod a+x $csh

# ------------ 

mkdir -p ~/pro 2>/dev/null
pro=/userdata/system/pro
pcsh=/userdata/system/pro-custom.sh
rm $pcsh 2>/dev/null
cd /userdata/system/pro
rm /tmp/list.txt 2>/dev/null
ls -d */ >> /tmp/list.txt
if [ ! /tmp/list.txt ]; then touch /tmp/list.txt; fi
if [[ "$(cat /tmp/list.txt | wc -l)" > "0" ]]; then
rm $pcsh 2>/dev/null
echo "#!/bin/bash" >> $pcsh
	nr=$(cat /tmp/list.txt | wc -l)
	L=1
	while [ "$L" -le "$nr" ]
	do 
		thisL=$(cat /tmp/list.txt | sed ''$L'q;d')
		oldstartup=$(echo "$thisL/extra/startup" | sed 's,//,/,g')
		newstartup=$(echo "$thisL/extras/startup.sh" | sed 's,//,/,g')

			if [[ -e "$oldstartup" ]]; then 
				   echo "$pro/$oldstartup" >> $pcsh
			elif [[ -e "$newstartup" ]]; then 
				   echo "$pro/$newstartup" >> $pcsh
			fi 

		L=$(($L + 1))
	done
	dos2unix $pcsh ; chmod a+x $pcsh
fi
cd ~/  

pcsh=/userdata/system/pro-custom.sh
tmp=/tmp/pcsh_tmp ; rm $tmp 2>/dev/null 
cat $pcsh | sed -e '/./b' -e :n -e 'N;s/\n$//;tn' >> $tmp
cp $tmp $pcsh ; dos2unix $pcsh ; chmod a+x $pcsh

sleep 1

} 
export -f add-autostart




function additionalcheck() {

csh=/userdata/system/custom.sh; dos2unix $csh
check1="/userdata/system/pro/"
check2="/extra/startup"
time=$(date +"%y%m%d-%H%M%S")
temp="/tmp/batocera.pro-autostart"
rm -rf /tmp/batocera.pro-autostart 2>/dev/null
mkdir -p /tmp/batocera.pro-autostart 2>/dev/null

if [[ -f $csh ]]; then 
cp "$csh" "$csh-backup-$time"
fi

if [[ -f $csh ]]; then
      tmp1=$temp/tcsh1.txt
      tmp2=$temp/tcsh2.txt
      remove="$startup"
      rm $tmp1 2>/dev/null; rm $tmp2 2>/dev/null
      nl=$(cat "$csh" | wc -l); nl1=$(($nl + 1))
         l=1; 
         for l in $(seq 1 $nl1); do
            ln=$(cat "$csh" | sed ""$l"q;d" );
               if [[ "$(echo "$ln" | grep "$check1")" != "" ]] && [[ "$(echo "$ln" | grep "$check2")" != "" ]]; 
               	then :; else
                  echo "$ln" >> $tmp1;
               fi            
            ((l++))
         done
fi 
cp "$tmp1" "$csh"
dos2unix "$csh"
chmod a+x "$csh"


if [[ "$(cat "$pcsh" | grep "#/userdata/system/pro/$app/extras/startup.sh")" != "" ]]; 
	then :; 
	else 
		if [[ "$(cat "$pcsh" | grep "/userdata/system/pro/$app/extras/startup.sh")" = "" ]]; 
			then echo "/userdata/system/pro/$app/extras/startup.sh" >> $pcsh
		fi
fi

}



###################################
      function get-xterm-fontsize {
         cfg=/tmp/batocera.pro-font
         rm /tmp/batocera.pro-font 2>/dev/null

# include display output: 
   tput=/userdata/system/pro/.dep/tput
   libtinfo=/userdata/system/pro/.dep/libtinfo.so.6
   mkdir -p /userdata/system/pro/.dep 2>/dev/null
      if [[ ( -e "$tput" && "$(wc -c "$tput" | awk '{print $1}')" < "444" ) || ( ! -e "$tput" ) ]]; then
         rm "$tput" 2>/dev/null
         wget -q -O "$tput" https://raw.githubusercontent.com/uureel/batocera.pro/main/.dep/.tput
      fi
      if [[ ( -e "$libtinfo" && "$(wc -c "$libtinfo" | awk '{print $1}')" < "444" ) || ( ! -e "$libtinfo" ) ]]; then
         rm "$libtinfo" 2>/dev/null
         wget -q -O $libtinfo https://raw.githubusercontent.com/uureel/batocera.pro/main/.dep/.libtinfo.so.6
      fi
   chmod a+x "$tput" 2>/dev/null
   cp "$libtinfo" "/lib/libtinfo.so.6" 2>/dev/null
   cp "$tput" /usr/bin/tput 2>/dev/null

            rm /tmp/cols 2>/dev/null
            killall -9 xterm 2>/dev/null
            DISPLAY=:0.0 xterm -fullscreen -fg black -bg black -fa Monospace -en UTF-8 -e bash -c "unset COLUMNS & tput cols >> /tmp/cols" 2>/dev/null
            killall -9 xterm 2>/dev/null
         res=$(xrandr | grep " connected " | awk '{print $3}' | cut -d x -f1)
         columns=$(cat /tmp/cols); echo "$res=$columns" >> "$cfg"
         cols=$(cat /tmp/cols | tail -n 1 | cut -d "=" -f2 2>/dev/null) 2>/dev/null
         font=$(bc <<<"scale=0;$cols/14" 2>/dev/null) 2>/dev/null
         rm /tmp/batocera.pro-font 2>/dev/null ; echo "$font" >> /tmp/batocera.pro-font
      }
      export -f get-xterm-fontsize
###################################


function get-display() {
app="$(cat /tmp/batocera.pro-config | grep "app=" | cut -d "=" -f2)"
mode="$(cat /tmp/batocera.pro-config | grep "mode=" | cut -d "=" -f2)"
theme="$(cat /tmp/batocera.pro-config | grep "theme=" | cut -d "=" -f2)"
loader="$(cat /tmp/batocera.pro-config | grep "loader=" | cut -d "=" -f2)"
# include display output: 
#
url_tput=https://raw.githubusercontent.com/uureel/batocera.pro/main/.dep/tput
url_libtinfo=https://raw.githubusercontent.com/uureel/batocera.pro/main/.dep/libtinfo.so.6
	#
   tput=/userdata/system/pro/.dep/tput
   libtinfo=/userdata/system/pro/.dep/libtinfo.so.6
   mkdir -p /userdata/system/pro/.dep 2>/dev/null
      if [[ ( -e "$tput" && "$(wc -c "$tput" | awk '{print $1}')" < "444" ) || ( ! -e "$tput" ) ]]; then
         rm "$tput" 2>/dev/null
         wget -q -O "$tput" $url_tput
      fi
      if [[ ( -e "$libtinfo" && "$(wc -c "$libtinfo" | awk '{print $1}')" < "444" ) || ( ! -e "$libtinfo" ) ]]; then
         rm "$libtinfo" 2>/dev/null
         wget -q -O $libtinfo $url_libtinfo
      fi
   chmod a+x "$tput" 2>/dev/null
   cp "$libtinfo" "/lib/libtinfo.so.6" 2>/dev/null
   cp "$tput" /usr/bin/tput 2>/dev/null

get-xterm-fontsize 2>/dev/null
#
# ensure fontsize: 
cfg=/tmp/batocera.pro-font
cols=$(cat "$cfg" | tail -n 1 | cut -d "=" -f2 2>/dev/null) 2>/dev/null
colres=$(cat "$cfg" | tail -n 1 | cut -d "=" -f1 2>/dev/null) 2>/dev/null
res=$(xrandr | grep " connected " | awk '{print $3}' | cut -d x -f1)
fallback=10 
#
#####
   if [[ -e "$cfg" ]] && [[ "$cols" != "80" ]]; then 
      if [[ "$colres" = "$res" ]]; then
         font=$(bc <<<"scale=0;$cols/14" 2>/dev/null) 2>/dev/null
      fi
      #|
      if [[ "$colres" != "$res" ]]; then
         rm "$cfg" 2>/dev/null
            try=1
            until [[ "$cols" != "80" ]] 
            do
            get-xterm-fontsize 2>/dev/null
            cols=$(cat "$cfg" | tail -n 1 | cut -d "=" -f2 2>/dev/null) 2>/dev/null
            try=$(($try+1)); if [[ "$try" -ge "10" ]]; then font=$fallback; cols=1; fi
            done 
            if [[ "$cols" != "1" ]]; then font=$(bc <<<"scale=0;$cols/14" 2>/dev/null) 2>/dev/null; fi
      fi
   # 
   else
   # 
      get-xterm-fontsize 2>/dev/null
      cols=$(cat "$cfg" | tail -n 1 | cut -d "=" -f2 2>/dev/null) 2>/dev/null
         try=1
         until [[ "$cols" != "80" ]] 
         do
            get-xterm-fontsize 2>/dev/null
            cols=$(cat "$cfg" | tail -n 1 | cut -d "=" -f2 2>/dev/null) 2>/dev/null
            try=$(($try+1)); if [[ "$try" -ge "10" ]]; then font=$fallback; cols=1; fi
         done 
         if [[ "$cols" != "1" ]]; then font=$(bc <<<"scale=0;$cols/14" 2>/dev/null) 2>/dev/null; fi
         if [ "$font" = "" ]; then font=$fallback; fi
   fi    #
   ##### #
         font=$(bc <<<"scale=0;$font/1")

rm /tmp/batocera.pro-font 2>/dev/null
echo "$font" >> /tmp/batocera.pro-font

}
export -f get-display





function run-xterm() {

get-display 

app="$(cat /tmp/batocera.pro-config | grep "app=" | cut -d "=" -f2)"
mode="$(cat /tmp/batocera.pro-config | grep "mode=" | cut -d "=" -f2)"
theme="$(cat /tmp/batocera.pro-config | grep "theme=" | cut -d "=" -f2)"
loader="$(cat /tmp/batocera.pro-config | grep "loader=" | cut -d "=" -f2)"
if [[ "$mode" = "" ]]; then mode=screen; fi
if [[ "$theme" = "" ]]; then theme=color; fi
if [[ "$loader" = "" ]]; then loader=yes; fi 
cd /tmp/ 
wget -q -O "/tmp/batocera.pro-loader.mp4" "https://raw.githubusercontent.com/uureel/batocera.pro/main/.dep/loader.mp4"
wget -q -O "/tmp/batocera.pro-$app.sh" "https://raw.githubusercontent.com/uureel/batocera.pro/main/$app/$app.sh"
dos2unix "/tmp/$app.sh" 2>/dev/null ; chmod a+x "/tmp/$app.sh" 2>/dev/null

font="$(cat /tmp/batocera.pro-font | tail -n 1)"

script="$1"
if [[ "$script" = "" ]]; then script="/tmp/batocera.pro-script"; fi

#	sleep 0.1111; DISPLAY=:0.0 unclutter-remote -h & cvlc -f --no-audio --no-video-title-show --no-mouse-events --no-keyboard-events --no-repeat --rate 4 /tmp/loader.mp4 2>/dev/null & sleep 4 && killall -9 vlc 2>/dev/null &
#   DISPLAY=:0.0 unclutter-remote -h & xterm -fs $font -fullscreen -fg black -bg black -fa Monospace -en UTF-8 -e bash -c "/tmp/$app.sh"


            if [[ "$mode" = "screen" ]]; then 
            if [[ "$loader" = "yes" ]]; then sleep 0; DISPLAY=:0.0 unclutter-remote -h & cvlc -f --no-audio --no-video-title-show --no-mouse-events --no-keyboard-events --no-repeat --rate 10 /userdata/system/fi/l.mp4 2>/dev/null & sleep 2 && killall -9 vlc 2>/dev/null; fi &
            DISPLAY=:0.0 unclutter-remote -h & xterm -fs $font -fullscreen -fg white -bg black -fa Monospace -en UTF-8 -e bash -c "$script" 2>/dev/null
            fi
            if [[ "$mode" = "text" ]]; then 
            bash $script $theme
            fi

}
export -f run-xterm 



