#!/bin/bash
# Fightcade2 launcher for Linux
# (c)2013-2020 Pau Oliva Fora (@pof) @ batocera.pro arch container edit
# ---------------------------------------------------------------------
cd /opt/fightcade2
FC2="/opt/fightcade2/fc2-electron/fc2-electron"
#PARAM=${1+"$@"}
PARAM=""
THIS_SCRIPT_PATH=`readlink -f $0 2>/dev/null || pwd`
THIS_SCRIPT_DIR=`dirname "${THIS_SCRIPT_PATH}"`
# ---------------------------------------------------------------------
# create default fbneo config if none exists
if [ ! -e "/opt/fightcade2/emulator/fbneo/config/fcadefbneo.ini" ]; then
cp /opt/fightcade2/emulator/fbneo/config/fcadefbneo.default.ini /opt/fightcade2/emulator/fbneo/config/fcadefbneo.ini
fi
# ---------------------------------------------------------------------
# always use modeless menu
sed -i "s/bModelessMenu 0/bModelessMenu 1/g" /opt/fightcade2/emulator/fbneo/config/fcadefbneo.ini
# ---------------------------------------------------------------------
# register fcade:// url handlers
if [ -x /usr/bin/xdg-mime ]; then
mkdir -p ~/.local/share/applications/
echo "[Desktop Entry]
Type=Application
Encoding=UTF-8
Name=Fightcade Replay
Exec=/opt/fightcade2/emulator/fcade.sh %U
Terminal=false
MimeType=x-scheme-handler/fcade
" > ~/.local/share/applications/fcade-quark.desktop
xdg-mime default fcade-quark.desktop x-scheme-handler/fcade
sed -i "s:Icon=.*:Icon=${THIS_SCRIPT_DIR}/fc2-electron/resources/app/icon.png:" /opt/fightcade2/Fightcade.desktop
cat /opt/fightcade2/Fightcade.desktop |sed -e "s:Exec=.*:Exec=/opt/fightcade2/batocera-fightcade2.sh:" > ~/.local/share/applications/Fightcade.desktop
fi
# ---------------------------------------------------------------------
if [ -x /usr/bin/gconftool-2 ]; then
gconftool-2 -t string -s /desktop/gnome/url-handlers/fcade/command "${THIS_SCRIPT_DIR}/emulator/fcade.sh %s"
gconftool-2 -s /desktop/gnome/url-handlers/fcade/needs_terminal false -t bool
gconftool-2 -t bool -s /desktop/gnome/url-handlers/fcade/enabled true
fi
# ---------------------------------------------------------------------
#start fc2
/opt/fightcade2/fc2-electron/fc2-electron --no-sandbox --test-type "${@}"
