#!/bin/bash
#----------------/
# BATOCERA LOGS / GENERATE, MERGE, FORMAT FOR LEGIBILITY & UPLOAD 
#--------------/
 
export DISPLAY=:0.0


# hello world ---------------------------------------------------
	clear

	echo "  "
	echo "  "
	echo "   ██  PREPARING LOGS . . . "
	echo "  "
	echo "  "


# define log files ----------------------------------------------
	L=~/logs/LOG.txt
	L0=~/logs/tmp/L0.txt
	L1=~/logs/tmp/Ll.txt
	L2=~/logs/tmp/L2.txt
	L3=~/logs/tmp/L3.txt
	L4=~/logs/tmp/L4.txt
	L5=~/logs/tmp/L5.txt
	L6=~/logs/tmp/L6.txt
	L7=~/logs/tmp/L7.txt
	L8=~/logs/tmp/L8.txt
	L9=~/logs/tmp/L9.txt
	LA=~/logs/tmp/LA.txt
	rm -rf ~/logs/tmp 2>/dev/null
	mkdir -p ~/logs/tmp 2>/dev/null
	rm $L 2>/dev/null


# write system info ---------------------------------------------
function log0() {
	echo -e "  ┌──────────── BATOCERA LOGS ──────────────" >> "$1"
	echo -e "  │" >> "$1"
	echo -e "  │" >> "$1"
	echo -e "  │" >> "$1"
	echo -e "  ■■ DATE       $(date)" >> "$1"
	echo -e "  ■■ VERSION    $(batocera-version)" >> "$1"
	echo -e "  ■■ UPTIME    $(uptime)" >> "$1"
	echo -e "  ■■ KERNEL     $(uname -a | cut -c1-76)" >> $"$1"
	echo -e "  │             $(uname -a | cut -c77-333)" >> "$1"
	echo -e "  ■■ DISKS " >> "$1"
	dn=$(blkid | wc -l); d=1
	while [[ $d -le $dn ]]; do
		if [[ "$(blkid | sed ''$d'q;d' | grep "squashfs")" = "" ]]; then
			echo -e "  $(blkid | sed ''$d'q;d' | cut -d ":" -f1)    $(blkid | sed ''$d'q;d' | cut -d ":" -f2)" >> "$1"
		fi
	d=$(($d+1))
	done
	echo -e "  │" >> "$1"
	echo -e "  ■■ CPU " >> "$1"
	echo -e " $(cat /proc/cpuinfo | grep "model name" | head -n 1 | cut -d ":" -f2)  /  $(cat /proc/cpuinfo | awk '/^processor/{print $3}' | wc -l) THREADS  /  $(echo $(($(cat /sys/class/thermal/thermal_zone0/temp)/1000)))°C" >> "$1"
	echo -e "  │" >> "$1"
	echo -e "  ■■ GPU " >> "$1"
		gn=$(lspci | grep VGA | wc -l); g=1
			while [[ $g -le $gn ]]
				do
					echo -e "  $(lspci | grep VGA | awk '{print $5,$6,$7,$8,$9,$10,$11,$12,$13,$14,$15,$16,$17}' | sed ''$g'q;d')" >> "$1"
					g=$(($g+1))
				done
	echo -e "  │" >> "$1"
	echo -e "  ■■ MEM " >> "$1"
	echo -e "  Free/Total    $(echo $(($(cat /proc/meminfo | grep MemFree | awk '{print $2}')/1000)))/$(echo $(($(cat /proc/meminfo | grep MemTotal | awk '{print $2}')/1000))) MB" >> "$1"
	echo -e "" >> "$1"
	echo -e "" >> "$1"
}
export -f log0


# write first log / stdout --------------------------------------
function log1() {
if [ -e ~/logs/es_launch_stdout.log ]; then
	stdout=~/logs/es_launch_stdout.log
	LO=$(cat $stdout | wc -l) 
	if [[ "$(cat $stdout | sed ''$LO'q;d')" == "" ]]; then LO=$(($LO - 1)); fi
	LO3D=$(printf "%03d" $LO)
	echo -e "" >> "$1"
	echo -e "" >> "$1"
	echo -e "  █████████" >> "$1"
	echo -e "  ████ ████" >> "$1"
	echo -e "  ████ ████" >> "$1"
	echo -e "  █████████" >> "$1"
	echo -e "" >> "$1"
	echo -e " ╔═══ LOG1 ■ STDOUT ■ /userdata/system/logs/es_launch_stdout.log" >> "$1"
	echo -e " ║         ┌──────────────────────────────────────────────────────────" >> "$1"
	L=1
	while [[ $L -le $LO ]]; 
		do
			L3D=$(printf "%03d" $L)
			line=$(cat $stdout | sed ''$L'q;d')
				if [[ "$line" != "" ]]; then
					echo " ║ $L3D/$LO3D │ $(echo $line | cut -c1-77)" >> "$1"
					if [[ "$(echo "$line" | cut -c78-154)" != "" ]]; then 
						echo -e " ║         │ $(echo "$line" | cut -c78-154)" >> "$1"
					fi
					if [[ "$(echo "$line" | cut -c155-231)" != "" ]]; then 
						echo -e " ║         │ $(echo "$line" | cut -c155-231)" >> "$1"
					fi
					if [[ "$(echo $line | cut -c232-308)" != "" ]]; then 
						echo -e " ║         │ $(echo "$line" | cut -c232-308)" >> "$1"
					fi
					if [[ "$(echo $line | cut -c309-385)" != "" ]]; then 
						echo -e " ║         │ $(echo "$line" | cut -c309-385)" >> "$1"
					fi
					if [[ "$(echo $line | cut -c386-462)" != "" ]]; then 
						echo -e " ║         │ $(echo "$line" | cut -c386-462)" >> "$1"
					fi
				fi
			L=$(($L+1))
		done
	echo -e " ║" >> "$1"
	echo -e " ╚═════════■ /stdout" >> "$1"
	echo -e "" >> "$1"
	echo -e "" >> "$1"
fi	
}
export -f log1


# write second log / stderr -------------------------------------
function log2() {
if [ -e ~/logs/es_launch_stderr.log ]; then
	stderr=~/logs/es_launch_stderr.log
	LE=$(cat $stderr | wc -l)
	if [[ "$(cat $stderr | sed ''$LE'q;d')" == "" ]]; then LE=$(($LE - 1)); fi
	LE3D=$(printf "%03d" $LE)
	echo -e "" >> "$1"
	echo -e "" >> "$1"
	echo -e "  █████████" >> "$1"
	echo -e "  ███ █ ███" >> "$1"
	echo -e "  ███ █ ███" >> "$1"
	echo -e "  █████████" >> "$1"
	echo -e "" >> "$1"
	echo -e " ╔═══ LOG2 ■ STDERR ■ /userdata/system/logs/es_launch_stderr.log" >> "$1"
	echo -e " ║         ┌──────────────────────────────────────────────────────────" >> "$1"
	L=1
	while [[ $L -le $LE ]];
		do 
			L3D=$(printf "%03d" $L)
			line=$(cat $stderr | sed ''$L'q;d')
				if [[ "$line" != "" ]]; then
					echo " ║ $L3D/$LE3D │ $(echo $line | cut -c1-77)" >> "$1"
					if [[ "$(echo "$line" | cut -c78-154)" != "" ]]; then 
						echo -e " ║         │ $(echo "$line" | cut -c78-154)" >> "$1"
					fi
					if [[ "$(echo "$line" | cut -c155-231)" != "" ]]; then 
						echo -e " ║         │ $(echo "$line" | cut -c155-231)" >> "$1"
					fi
					if [[ "$(echo $line | cut -c232-308)" != "" ]]; then 
						echo -e " ║         │ $(echo "$line" | cut -c232-308)" >> "$1"
					fi
					if [[ "$(echo $line | cut -c309-385)" != "" ]]; then 
						echo -e " ║         │ $(echo "$line" | cut -c309-385)" >> "$1"
					fi
					if [[ "$(echo $line | cut -c386-462)" != "" ]]; then 
						echo -e " ║         │ $(echo "$line" | cut -c386-462)" >> "$1"
					fi
				fi
			L=$(($L+1))
		done
	echo -e " ║" >> "$1"
	echo -e " ╚═════════■ /stderr" >> "$1"
	echo -e "" >> "$1"
	echo -e "" >> "$1"
fi
}
export -f log2


# write lsusb ---------------------------------------------------
function log3() {
	echo -e "" >> "$1"
	echo -e "" >> "$1"
	echo -e "  ││││││  ██  LSUSB " >> "$1"
	dn=$(lsusb | wc -l); d=1
	while [[ $d -le $dn ]]
		do
		if [[ $d -ge 1 ]]; then echo -e "  │    │  " >> "$1"; fi
			d2=$(printf "%02d" $d)
			echo -e "  │ $d2 ■  $(lsusb | sed ''$d'q;d' | cut -c1-77)" >> "$1"
						if [[ "$(lsusb | sed ''$d'q;d' | cut -c78-154)" != "" ]]; then 
							echo -e "  │    │  $(lsusb | sed ''$d'q;d' | cut -c78-154)" >> "$1"
						fi
						if [[ "$(lsusb | sed ''$d'q;d' | cut -c155-231)" != "" ]]; then 
							echo -e "  │    │  $(lsusb | sed ''$d'q;d' | cut -c155-231)" >> "$1"
						fi
			d=$(($d+1))
		done
	echo -e "  └────┘  " >> "$1"
	echo -e "" >> "$1"
	echo -e "" >> "$1"
}
export -f log3


# write lspci ---------------------------------------------------
function log4() {
	echo -e "" >> "$1"
	echo -e "" >> "$1"
	echo -e "  ││││││││││││││││  ██  LSPCI" >> "$1"
	dn=$(lspci | wc -l); d=1 
	while [[ $d -le $dn ]]
		do
		if [[ $d = 1 ]]; then echo -e "  │    ┌─────────┘  " >> "$1"; fi
		#if [[ $d -gt 1 ]]; then echo -e "  │    ┌─────────  " >> "$1"; fi
		if [[ $d -gt 1 ]]; then echo -e "  │    │  " >> "$1"; fi
			d2=$(printf "%02d" $d)
			echo -e "  │ $d2 ■  $(lspci | sed ''$d'q;d' | cut -c1-77)" >> "$1"
						if [[ "$(lspci | sed ''$d'q;d' | cut -c78-154)" != "" ]]; then 
							echo -e "  │    │  $(lspci | sed ''$d'q;d' | cut -c78-154)" >> "$1"
						fi
						if [[ "$(lspci | sed ''$d'q;d' | cut -c155-231)" != "" ]]; then 
							echo -e "  │    │  $(lspci | sed ''$d'q;d' | cut -c155-231)" >> "$1"
						fi
			d=$(($d+1))
		done
	echo -e "  └────┘  " >> "$1"
	echo -e "" >> "$1"
	echo -e "" >> "$1"
}
export -f log4 


# write glxinfo -------------------------------------------------
function log5() {
if [ -e /usr/bin/glxinfo ]; then
link=$(glxinfo | nc termbin.com 9999)
	echo -e "" >> "$1"
	echo -e "" >> "$1"
	echo -e "       ┌───────────┐" >> "$1"
	echo -e "  ██████  GLXINFO  ██>  $link" >> "$1"
	dn=$(glxinfo | grep version | grep : | wc -l); d=1
	while [[ $d -le $dn ]]
		do
		if [[ $d -ge 1 ]]; then echo -e "  │  " >> "$1"; fi
			d2=$(printf "%02d" $d)
			line=$(glxinfo | grep version | grep : | sed ''$d'q;d')
			echo -e "  │  $(echo "$line" | cut -c1-77)" >> "$1"
						if [[ "$(echo "$line" | cut -c78-154)" != "" ]]; then 
							echo -e "  │  $(echo "$line" | cut -c78-154)" >> "$1"
						fi
						if [[ "$(echo "$line" | cut -c155-231)" != "" ]]; then 
							echo -e "  │  $(echo "$line" | sed ''$d'q;d' | cut -c155-231)" >> "$1"
						fi
			d=$(($d+1))
		done
	echo -e "  └────  " >> "$1"
	echo -e "" >> "$1"
	echo -e "" >> "$1"
fi
}
export -f log5


# write vulkaninfo ----------------------------------------------
function log6() {
if [ -e /usr/bin/vulkaninfo ]; then
link=$(vulkaninfo | nc termbin.com 9999)
	echo -e "" >> "$1"
	echo -e "" >> "$1"
	echo -e "       ┌──────────────┐" >> "$1"
	echo -e "  ██████  VULKANINFO  ██>  $link" >> "$1"
	dn=$(vulkaninfo | grep version | grep VK_LAYER | wc -l); d=1
	while [[ $d -le $dn ]]
		do
		if [[ $d -ge 1 ]]; then echo -e "  │  " >> "$1"; fi
			d2=$(printf "%02d" $d)
			line=$(vulkaninfo | grep version | grep VK_LAYER | sed ''$d'q;d')
			echo -e "  │  $(echo "$line" | cut -c1-73)" >> "$1"
						if [[ "$(echo "$line" | cut -c74-150)" != "" ]]; then 
							echo -e "  │  $(echo "$line" | cut -c74-150)" >> "$1"
						fi
						if [[ "$(echo "$line" | cut -c151-227)" != "" ]]; then 
							echo -e "  │  $(echo "$line" | cut -c151-227)" >> "$1"
						fi
			d=$(($d+1))
		done
	echo -e "  └────  " >> "$1"
	echo -e "" >> "$1"
	echo -e "" >> "$1"
fi
}
export -f log6


# write batocera.log --------------------------------------------
function log7() {
if [ -e ~/logs/batocera.log ]; then
	echo -e "" >> "$1"
	echo -e "" >> "$1"
	echo -e "  ██  BATOCERA.LOG " >> "$1"
	dn=$(cat ~/logs/batocera.log | wc -l); d=1
	while [[ $d -le $dn ]]
		do
		if [[ $d -ge 1 ]]; then echo -e "  │  " >> "$1"; fi
			d2=$(printf "%02d" $d)
			line=$(cat ~/logs/batocera.log | sed ''$d'q;d')
			echo -e "  │  $(echo "$line" | cut -c1-73)" >> "$1"
						if [[ "$(echo "$line" | cut -c74-150)" != "" ]]; then 
							echo -e "  │  $(echo "$line" | cut -c74-150)" >> "$1"
						fi
						if [[ "$(echo "$line" | cut -c151-227)" != "" ]]; then 
							echo -e "  │  $(echo "$line" | cut -c151-227)" >> "$1"
						fi
			d=$(($d+1))
		done
	echo -e "  └────  " >> "$1"
	echo -e "" >> "$1"
	echo -e "" >> "$1"
fi
}
export -f log7


# generate logs / multithreaded ---------------------------------
	log0 "$L0" 2>/dev/null & 
	log1 "$L1" 2>/dev/null & 
	log2 "$L2" 2>/dev/null & 
	log3 "$L3" 2>/dev/null & 
	log4 "$L4" 2>/dev/null & 
	log5 "$L5" 2>/dev/null & 
	log6 "$L6" 2>/dev/null &
	log7 "$L7" 2>/dev/null &
	wait


# generate the combined log -------------------------------------
	cat "$L0" >> "$L" 2>/dev/null	# system info
	cat "$L3" >> "$L" 2>/dev/null	# lsusb
	cat "$L4" >> "$L" 2>/dev/null	# lspci
	cat "$L5" >> "$L" 2>/dev/null	# glxinfo
	cat "$L6" >> "$L" 2>/dev/null	# vulkaninfo
	cat "$L7" >> "$L" 2>/dev/null	# batocera.log
	cat "$L1" >> "$L" 2>/dev/null	# stdout
	cat "$L2" >> "$L" 2>/dev/null	# stderr

	rm -rf ~/logs/tmp 2>/dev/null


# display the combined log on screen ----------------------------
	clear
	echo
	echo
	cat $L


# upload the combined log / display link ------------------------
	link=$(cat "$L" | nc termbin.com 9999 | sed '1q;d')
	linkl=$(echo "$link" | wc -c)

	echo
	echo
	echo -e "  ███"
	echo -e "  ███"
	echo -e "  ███  UPLOADED LOGS"
	echo -e "  ███"
	echo -e "  ███"
	echo -e "  ║" 
	echo -e "  ║" 
	echo -e "  ╚═$(printf '%0.s═' $(seq 1 $linkl))/"
	echo
	echo -e "   $link"
	echo
	echo -e "  /═$(printf '%0.s═' $(seq 1 $linkl))█"
	echo
	echo
	echo

	read EXIT
	echo -e "  ██  CLOSING . . ."
	echo
	echo
	echo


# ---------------------------------------------------------------
# done; 
exit 0

