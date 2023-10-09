#!/bin/bash 
cp /userdata/system/pro/sunshine/extras/sunshine.desktop /usr/share/applications/ 2>/dev/null 
sleep 44
su -c "nohup /userdata/system/pro/sunshine/batocera-sunshine start &" &
sleep 4
	while true; do 
	    pid="$(pidof sunshine)"
	    port1="$(netstat -tuln | grep 47990)"
	    port2="$(netstat -tuln | grep 48010)"
	    
	    if [[ -z "$pid" ]] || [[ -z "$port1" ]] || [[ -z "$port2" ]]; then 
	        su -c "nohup /userdata/system/pro/sunshine/batocera-sunshine start &" &
	        sleep 5
	    fi
	    
	    sleep 10
	done
exit 0
