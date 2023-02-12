#!/bin/bash
# netcheck 
net="on" 
case "$(curl -s --max-time 2 -I http://github.com | sed 's/^[^ ]*  *\([0-9]\).*/\1/; 1q')" in
  [23]) net1="on" && comm="HTTP connectivity is up";;
  5) net1="off" && comm="The web proxy won't let us through";;
  *) net1="off" && comm="The network is down or very slow";;
esac 
ping -q -w 1 -c 1 github.com > /dev/null && net2="on" || net2="off"
wget -q --spider http://github.com
if [ $? -eq 0 ]; then net3="on"; else net3="off"; fi
##
if [[ "$net1" = "on" ]] || [[ "$net2" = "on" ]] || [[ "$net3" = "on" ]]; then net="on"; else net="off"; fi 
##
echo
echo "netcheck:"
echo
echo "net1 = $net1"
echo "net2 = $net2"
echo "net3 = $net3"
echo 
echo "net is $net"
echo