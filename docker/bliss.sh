docker run -it \
    --privileged \
    --device /dev/kvm \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -e "DISPLAY=${DISPLAY:-:0.0}" \
    --net=host \
    -p 5555:5555 \
    -p 50922:10022 \
    --device=/dev/dri \
    --group-add video  \
    -e EXTRA='-display gtk,gl=on -vga qxl -spice port=5930,disable-ticketing' \
    sickcodes/dock-droid:latest
