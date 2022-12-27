#!/bin/bash
DISPLAY=:0.0 xterm -en en_US.UTF-8 -u8 -bg black -fg white -fa Monospace -fs 5 -sb -e bash -c "/usr/bin/logs 2>/dev/null" 2>/dev/null &
