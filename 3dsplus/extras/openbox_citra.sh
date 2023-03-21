#!/bin/bash
#----------
if [[ "$(cat /etc/openbox/rc.xml | grep "citra-qt")" = "" ]]; then 
	cp /userdata/system/pro/3dsplus/extras/rc_citra.xml /etc/openbox/rc.xml 2>/dev/null
	chmod a+x /userdata/system/pro/3dsplus/extras/startx 2>/dev/null
	chmod a+x /userdata/system/pro/3dsplus/extras/xinitrc 2>/dev/null
	sleep 0.1
	su -c "/userdata/system/pro/3dsplus/extras/startx &" root 1>/dev/null 2>/dev/null & 
fi
