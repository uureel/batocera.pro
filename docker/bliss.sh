#!/bin/bash

echo "Starting Bliss OS...This can take a while..."
echo "Adjust display to fit to screen in top menu bar settings after QEMU starts"
echo ""
sleep 5
clear

CONTAINER_NAME="bliss"


docker start bliss
