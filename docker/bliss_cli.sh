#!/bin/bash

CONTAINER_NAME="bliss"

docker run -i \
    --privileged \
    --device /dev/kvm \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -e "DISPLAY=${DISPLAY:-:0.0}" \
    --net=host \
    -p 5555:5555 \
    -p 50922:10022 \
    --device=/dev/dri \
    --group-add video \
    --device /dev/snd \
    --group-add audio \
    -e EXTRA='-display gtk,gl=on -vga qxl -spice port=5930,disable-ticketing' \
    --name $CONTAINER_NAME \
    sickcodes/dock-droid:latest
