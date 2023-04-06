#!/bin/bash
##################################################################################################################################
#---------------------------------------------------------------------------------------------------------------------------------




app=plexamp




#---------------------------------------------------------------------------------------------------------------------------------
##################################################################################################################################
export DISPLAY=:0.0 ; cd /tmp/ ; rm "/tmp/pro-framework.sh" 2>/dev/null ; rm "/tmp/$app.sh" 2>/dev/null ;
wget --no-cache -q -O "/tmp/pro-framework.sh" "https://raw.githubusercontent.com/uureel/batocera.pro/main/.dep/pro-framework.sh" ; 
wget --no-cache -q -O "/tmp/$app.sh" "https://raw.githubusercontent.com/uureel/batocera.pro/main/$app/$app.sh" ; 
dos2unix /tmp/pro-framework.sh ; dos2unix "/tmp/$app.sh" ;  
source /tmp/pro-framework.sh  
bash "/tmp/$app.sh"
# batocera.pro // 