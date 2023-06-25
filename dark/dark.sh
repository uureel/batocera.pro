#!/bin/bash
#batocera-darkmode.sh
#####################

echo "preparing dark theme for f1/gtk/pcmanfm..."
echo

f=/userdata/system/pro/dark
	mkdir -p $f 2>/dev/null

url=https://raw.githubusercontent.com/uureel/batocera.pro/main/dark
	wget -q -O $f/Adwaita-dark.zip $url/Adwaita-dark.zip 
		unzip -qq $f/Adwaita-dark.zip 
			mv $f/Adwaita-dark /usr/share/themes/

sed -i '/export XDG_CONFIG_DIRS=\/etc\/xdg/a export GTK_THEME=Adwaita-dark' /usr/bin/filemanagerlauncher

export GTK_THEME=Adwaita-dark

echo "done."