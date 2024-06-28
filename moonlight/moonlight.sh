#!/usr/bin/env bash 
# BATOCERA.PRO INSTALLER

# Define App Info
APPNAME="moonlight"
# Fetch the latest AppImage URL from GitHub releases
APPLINK=$(curl -s https://api.github.com/repos/moonlight-stream/moonlight-qt/releases/latest | grep "browser_download_url.*AppImage" | cut -d '"' -f 4)
APPHOME="github.com/moonlight-stream"

# Define Launcher Command
COMMAND='mkdir /userdata/system/pro/'$APPNAME'/home 2>/dev/null; mkdir /userdata/system/pro/'$APPNAME'/config 2>/dev/null; mkdir /userdata/system/pro/'$APPNAME'/roms 2>/dev/null; LD_LIBRARY_PATH="/userdata/system/pro/.dep:${LD_LIBRARY_PATH}" HOME=/userdata/system/pro/'$APPNAME'/home XDG_CONFIG_HOME=/userdata/system/pro/'$APPNAME'/config QT_SCALE_FACTOR="1" GDK_SCALE="1" XDG_DATA_HOME=/userdata/system/pro/'$APPNAME'/home DISPLAY=:0.0 /userdata/system/pro/'$APPNAME'/'$APPNAME'.AppImage'

# Convert APPNAME to uppercase and lowercase variations
APPNAME="${APPNAME^^}"
ORIGIN="${APPHOME^^}"
appname=$(echo "$APPNAME" | awk '{print tolower($0)}')
AppName=$appname
APPPATH=/userdata/system/pro/$appname/$AppName.AppImage

# Show console/ssh info
clear
echo
echo
echo
echo -e "PREPARING $APPNAME INSTALLER, PLEASE WAIT . . ."
echo
echo
echo
echo

# Output colors
X='\033[0m'
W='\033[0m'
RED='\033[0m'
BLUE='\033[0m'
GREEN='\033[0m'
PURPLE='\033[0m'
DARKRED='\033[0m'
DARKBLUE='\033[0m'
DARKGREEN='\033[0m'
DARKPURPLE='\033[0m'

# Prepare paths and files for installation
cd ~/
pro=/userdata/system/pro
mkdir $pro 2>/dev/null
mkdir $pro/extra 2>/dev/null
mkdir $pro/$appname 2>/dev/null
mkdir $pro/$appname/extra 2>/dev/null

# Pass launcher command as cookie for main function
command=$pro/$appname/extra/command
rm $command 2>/dev/null
echo "$COMMAND" >> $command 2>/dev/null

# Prepare dependencies for this app and the installer
mkdir -p ~/pro/.dep 2>/dev/null && cd ~/pro/.dep && wget --tries=10 --no-check-certificate --no-cache --no-cookies -q -O ~/pro/.dep/dep.zip https://github.com/uureel/batocera.pro/raw/main/.dep/dep.zip && yes "y" | unzip -oq ~/pro/.dep/dep.zip && cd ~/
wget --tries=10 --no-check-certificate --no-cache --no-cookies -q -O $pro/$appname/extra/icon.png https://github.com/uureel/batocera.pro/raw/main/$appname/extra/icon.png
chmod a+x $dep/* 2>/dev/null
cd ~/
chmod 777 ~/pro/.dep/*
for file in /userdata/system/pro/.dep/lib*; do sudo ln -s "$file" "/usr/lib/$(basename $file)"; done

# Run before installer
killall wget 2>/dev/null && killall $AppName 2>/dev/null && killall $AppName 2>/dev/null && killall $AppName 2>/dev/null
cols=$($dep/tput cols)
rm -rf /userdata/system/pro/$appname/extra/cols
echo $cols >> /userdata/system/pro/$appname/extra/cols

# Show console/ssh info
clear
echo
echo
echo
echo -e "BATOCERA.PRO/$APPNAME INSTALLER"
echo
echo
echo
echo
sleep 0.33
clear
echo
echo
echo
echo -e "BATOCERA.PRO/$APPNAME INSTALLER"
echo
echo
echo
echo
sleep 0.33
clear
echo
echo
line $cols '-'
echo
echo -e "BATOCERA.PRO/$APPNAME INSTALLER"
line $cols '-'
echo
echo
echo
sleep 0.33
clear
echo
line $cols '-'
echo
echo
echo -e "BATOCERA.PRO/$APPNAME INSTALLER"
line $cols '-'
echo
echo
sleep 0.33
clear
line $cols '='
echo
echo
echo -e "BATOCERA.PRO/$APPNAME INSTALLER"
line $cols '='
echo
echo
sleep 0.33
echo -e "THIS WILL INSTALL $APPNAME FOR BATOCERA"
echo -e "USING $ORIGIN"
echo
echo -e "$APPNAME WILL BE AVAILABLE IN PORTS"
echo -e "AND ALSO IN THE F1->APPLICATIONS MENU"
echo -e "AND INSTALLED IN /USERDATA/SYSTEM/PRO/$APPNAME"
echo
echo -e "FOLLOW THE BATOCERA DISPLAY"
echo
echo -e ". . ."
echo

# Define the batocera-pro-installer function
function batocera-pro-installer {
    APPNAME="$1"
    appname="$2"
    AppName="$3"
    APPPATH="$4"
    APPLINK="$5"
    ORIGIN="$6"
    
    # Colors
    X='\033[0m'
    W='\033[0m'
    RED='\033[0m'
    BLUE='\033[0m'
    GREEN='\033[0m'
    PURPLE='\033[0m'
    DARKRED='\033[0m'
    DARKBLUE='\033[0m'
    DARKGREEN='\033[0m'
    DARKPURPLE='\033[0m'
    
    # Display theme
    L=$W
    T=$W
    R=$RED
    B=$BLUE
    G=$GREEN
    P=$PURPLE
    
    cols=$(cat /userdata/system/pro/.dep/display.cfg | tail -n 1)
    cols=$(bc <<<"scale=0;$cols/1.3") 2>/dev/null
    line(){
        echo 1>/dev/null
    }
    clear
    echo
    echo
    echo
    echo -e "${W}BATOCERA.PRO/${G}$APPNAME${W} INSTALLER ${W}"
    echo
    echo
    echo
    echo
    sleep 0.33
    clear
    echo
    echo
    echo
    echo -e "${W}BATOCERA.PRO/${W}$APPNAME${W} INSTALLER ${W}"
    echo
    echo
    echo
    echo
    sleep 0.33
    clear
    echo
    echo
    line $cols '-'
    echo
    echo -e "${W}BATOCERA.PRO/${G}$APPNAME${W} INSTALLER ${W}"
    line $cols '-'
    echo
    echo
    echo
    sleep 0.33
    clear
    echo
    line $cols '-'
    echo
    echo
    echo -e "${W}BATOCERA.PRO/${W}$APPNAME${W} INSTALLER ${W}"
    line $cols '-'
    echo
    echo
    sleep 0.33
    clear
    line $cols '='
    echo
    echo
    echo -e "${W}BATOCERA.PRO/${G}$APPNAME${W} INSTALLER ${W}"
    line $cols '='
    echo
    echo
    sleep 0.33
    echo -e "${W}THIS WILL INSTALL $APPNAME FOR BATOCERA"
    echo -e "${W}USING $ORIGIN"
    echo
    echo -e "${W}$APPNAME WILL BE AVAILABLE IN PORTS"
    echo -e "${W}AND ALSO IN THE F1->APPLICATIONS MENU"
    echo -e "${W}AND INSTALLED IN /USERDATA/SYSTEM/PRO/$APPNAME"
    echo
    
    # Check system before proceeding
    if [[ "$(uname -a | grep "x86_64")" != "" ]]; then 
        :
    else
        echo
        echo -e "${RED}ERROR: SYSTEM NOT SUPPORTED"
        echo -e "${RED}YOU NEED BATOCERA X86_64${X}"
        echo
        sleep 5
        exit 0
    fi
    
    # Temp for curl download
    pro=/userdata/system/pro
    temp=/userdata/system/pro/$appname/extra/downloads
    rm -rf $temp 2>/dev/null
    mkdir -p $temp 2>/dev/null
    
    # Download Moonlight
    echo -e "${G}DOWNLOADING${W}"
    sleep 1
    echo -e "${T}$APPLINK" | sed 's,https://,> ,g' | sed 's,http://,> ,g' 2>/dev/null
    cd $temp
    curl --progress-bar --remote-name --location "$APPLINK"
    cd ~/
    mv $temp/* $APPPATH 2>/dev/null
    chmod a+x $APPPATH 2>/dev/null
    rm -rf $temp/*.AppImage
    SIZE=$(($(wc -c $APPPATH | awk '{print $1}')/1048576)) 2>/dev/null
    echo -e "${T}$APPPATH ${T}$SIZE( )MB ${G}OK${W}" | sed 's/( )//g'
    echo
    sleep 1.333
    
    # Installing
    echo -e "${G}INSTALLING${W}"
    launcher=/userdata/system/pro/$appname/Launcher
    rm -rf $launcher
    echo '#!/bin/bash ' >> $launcher
    echo 'unclutter-remote -s' >> $launcher
    echo "$(cat /userdata/system/pro/$appname/extra/command)" >> $launcher
    dos2unix $launcher
    chmod a+x $launcher
    rm /userdata/system/pro/$appname/extra/command 2>/dev/null
    
    # Prepare F1 - Applications - App shortcut
    shortcut=/userdata/system/pro/$appname/extra/$appname.desktop
    rm -rf $shortcut 2>/dev/null
    echo "[Desktop Entry]" >> $shortcut
    echo "Version=1.0" >> $shortcut
    echo "Icon=/userdata/system/pro/$appname/extra/icon.png" >> $shortcut
    echo "Exec=/userdata/system/pro/$appname/Launcher" >> $shortcut
    echo "Terminal=false" >> $shortcut
    echo "Type=Application" >> $shortcut
    echo "Categories=Game;batocera.linux;" >> $shortcut
    echo "Name=$appname" >> $shortcut
    f1shortcut=/usr/share/applications/$appname.desktop
    dos2unix $shortcut
    chmod a+x $shortcut
    cp $shortcut $f1shortcut 2>/dev/null
    
    # Prepare Ports file
    version=$(echo $APPLINK | sed 's,^.*Moonlight-,,g' | sed 's,-x86_64.AppImage,,g')
    port=/userdata/system/pro/$appname/Moonlight.sh
    rm -rf $port 2>/dev/null
    echo '#!/bin/bash ' >> $port
    echo 'unclutter-remote -s' >> $port
    echo 'mkdir /userdata/system/pro/'$appname'/home 2>/dev/null' >> $port
    echo 'mkdir /userdata/system/pro/'$appname'/config 2>/dev/null' >> $port
    echo 'mkdir /userdata/system/pro/'$appname'/roms 2>/dev/null' >> $port
    echo 'HOME=/userdata/system/pro/'$appname'/home \' >> $port
    echo 'XDG_DATA_HOME=/userdata/system/pro/'$appname'/home \' >> $port
    echo 'XDG_CONFIG_HOME=/userdata/system/pro/'$appname'/config \' >> $port
    echo 'QT_SCALE_FACTOR="1" GDK_SCALE="1" \' >> $port
    echo 'DISPLAY=:0.0 /userdata/system/pro/'$appname'/'$appname'.AppImage' >> $port
    dos2unix $port
    chmod a+x $port
    ports=/userdata/roms/ports
    if [[ -e "$ports/Moonlight.sh" ]]; 
    then 
        if [[ "$(cat "$ports/Moonlight.sh" | grep "/userdata/system/pro/moonlight" | tail -n 1)" != "" ]]; 
        then 
            cp $port "$ports/Moonlight.sh"
        else
            cp $port "$ports/Moonlight $version.sh"
        fi
    else 
        cp $port "$ports/Moonlight.sh"
    fi
    
    # Prepare prelauncher to avoid overlay
    pre=/userdata/system/pro/$appname/extra/startup
    rm -rf $pre 2>/dev/null
    echo "#!/usr/bin/env bash" >> $pre
    echo "cp /userdata/system/pro/$appname/extra/$appname.desktop /usr/share/applications/ 2>/dev/null" >> $pre
    dos2unix $pre
    chmod a+x $pre
    
    # Add prelauncher to custom.sh to run at reboot
    csh=/userdata/system/custom.sh
    if [[ -e $csh ]] && [[ "$(cat $csh | grep "/userdata/system/pro/$appname/extra/startup")" = "" ]]; then
        echo -e "\n/userdata/system/pro/$appname/extra/startup" >> $csh
    fi
    if [[ -e $csh ]] && [[ "$(cat $csh | grep "/userdata/system/pro/$appname/extra/startup" | grep "#")" != "" ]]; then
        echo -e "\n/userdata/system/pro/$appname/extra/startup" >> $csh
    fi
    if [[ -e $csh ]]; then :; else
        echo -e "\n/userdata/system/pro/$appname/extra/startup" >> $csh
    fi
    dos2unix $csh
    
    sleep 1
    echo -e "${G}> ${W}DONE${W}"
    echo
    sleep 1
    echo
    echo -e "${W}> $APPNAME INSTALLED ${G}OK${W}"
    line $cols '='
    echo "1" >> /userdata/system/pro/$appname/extra/status 2>/dev/null
    sleep 3
    
    # Reload for ports file
    curl http://127.0.0.1:1234/reloadgames
}
export -f batocera-pro-installer 2>/dev/null

# Run the installer
batocera-pro-installer "$APPNAME" "$appname" "$AppName" "$APPPATH" "$APPLINK" "$ORIGIN"

# BATOCERA.PRO INSTALLER //
function autostart() {
    csh="/userdata/system/custom.sh"
    pcsh="/userdata/system/pro-custom.sh"
    pro="/userdata/system/pro"
    rm -f $pcsh
    temp_file=$(mktemp)
    find $pro -type f \( -path "*/extra/startup" -o -path "*/extras/startup.sh" \) > $temp_file
    echo "#!/bin/bash" > $pcsh
    sort $temp_file >> $pcsh
    rm $temp_file
    chmod a+x $pcsh
    temp_csh=$(mktemp)
    grep -vxFf $pcsh $csh > $temp_csh
    mapfile -t lines < $temp_csh
    if [[ "${lines[0]}" != "#!/bin/bash" ]]; then
        lines=( "#!/bin/bash" "${lines[@]}" )
    fi
    if ! grep -Fxq "$pcsh &" $temp_csh; then
        lines=( "${lines[0]}" "$pcsh &" "${lines[@]:1}" )
    fi
    printf "%s\n" "${lines[@]}" > $csh
    chmod a+x $csh
    rm $temp_csh
}
export -f autostart
autostart
exit 0
