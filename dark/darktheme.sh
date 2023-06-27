#!/bin/bash
#batocera-darkmode.sh
#####################

echo -e "\n  preparing dark theme for f1/gtk/pcmanfm..."

	# prepare folder 
	f=/userdata/system/pro/dark
		mkdir -p $f 2>/dev/null

	# get files 
	url=https://github.com/uureel/batocera.pro/raw/main/dark/Adwaita-dark.zip
	cd /userdata/system/pro/dark
		wget -q "https://github.com/uureel/batocera.pro/raw/main/dark/Adwaita-dark.zip"
			unzip -oq ./Adwaita-dark.zip 
				cp -r ./Adwaita-dark /usr/share/themes/
		wget -q -O $f/dark.sh "https://raw.githubusercontent.com/uureel/batocera.pro/main/dark/dark.sh"
			dos2unix $f/dark.sh 1>/dev/null 2>/dev/null 
			chmod a+x $f/dark.sh 2>/dev/null

	# add dark theme to f1 launcher 
	if [[ "$(cat /usr/bin/filemanagerlauncher | grep "GTK_THEME=Adwaita-dark")" = "" ]]; then 
		sed -i '/export XDG_CONFIG_DIRS=\/etc\/xdg/a export GTK_THEME=Adwaita-dark' /usr/bin/filemanagerlauncher
	elif [[ "$(cat /usr/bin/filemanagerlauncher | grep "GTK_THEME=Adwaita-dark" | grep "#")" != "" ]]; then
		sed -i '/export XDG_CONFIG_DIRS=\/etc\/xdg/a export GTK_THEME=Adwaita-dark' /usr/bin/filemanagerlauncher 
	fi 
	
	# cookie 
	export GTK_THEME=Adwaita-dark

echo -e "  done \n" 