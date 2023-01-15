#!/usr/bin/env bash 


G='\033[1;32m'
R='\033[1;31m'
X='\033[0m'


echo
echo
echo -e "${R}RYUJINX CONTROLLER FIX FOR BATOCERA-SWITCH"
echo
echo
echo -e "${R}HOW TO USE: ${X}"
echo -e "${X}1. OPEN [RYUJINX-AVALONIA] FROM [F1-APPS]"
echo -e "${X}2. APPLY AND SAVE YOUR CONTROLLER CONFIG"
echo -e "${X}3. RUN THIS SCRIPT"
echo
echo
echo


getavaid="$(cat /userdata/system/configs/Ryujinx/Config.json | grep '"id":' | cut -d \" -f4)"


if [[ "$getavaid" = "" ]] || [[ "$getavaid" = "0" ]]; then 
	echo -e "${R} COULDN'T FIND CONTROLLER ID, YOU NEED TO CONFIGURE "
	echo -e "${R} THE CONTROLLER IN F1 -> APPS -> RYUJINX-AVALONIA "
	echo 
	echo -e "${R} THEN RUN THIS SCRIPT AGAIN "
	echo
	echo -e "${X} "
	echo
	exit 0
fi


if [[ "$getavaid" != "" ]] && [[ "$getavaid" != "0" ]]; then

	avaid=""$(echo $getavaid)""

	genline=$(cat /userdata/system/switch/configgen/generators/ryujinx/ryujinxMainlineGenerator.py | grep "cvalue\['id")

	replace="$genline"
	replaced=$(echo "$genline" | sed 's,^.*= ,,g')
	with="                cvalue['id'] = \"$getavaid\""


	if [[ "$replace" = "$with" ]]; then 
	echo -e "${G}=========${G}==================================="
	echo -e "${X}GENERATOR IS ALREADY PATCHED "
	echo
	echo -e "${G}"$replaced""
	echo -e "${G}=========${G}==================================="
	echo
	echo -e "${X} "
	echo
	exit 0
	fi


	if [[ "$replace" != "$with" ]]; then 
	sed -i "s/.*$replace*/$with/" /userdata/system/switch/configgen/generators/ryujinx/ryujinxMainlineGenerator.py

	echo -e "${R}REPLACED ${X}==================================="
	echo -e "$replaced"
	echo
	echo -e "${R}WITH ${X}"
	echo -e "\"$avaid\""
	echo -e "============================================"
	echo
	echo -e "${X} "
	echo
	exit 0
	fi

fi

