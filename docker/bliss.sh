echo "Starting Bliss OS...This can take a while..."
echo "Adjust display to fit to screen in top menu bar settings"
echo ""
# Check if the container is already running
if [ "$(docker ps -q -f name=$CONTAINER_NAME)" ]; then
    dialog --title "Container Running" --msgbox "The Bliss OS Docker container is already running." 10 50
else
    # Check if the container exists
    if [ "$(docker ps -aq -f name=$CONTAINER_NAME)" ]; then
        # Start the existing container
        docker start $CONTAINER_NAME

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
    --device /dev/snd \
    --group-add audio \
    -e EXTRA='-display gtk,gl=on -vga qxl -spice port=5930,disable-ticketing' \
    sickcodes/dock-droid:latest
