#!/bin/sh

start() {
  /userdata/system/pro/livecaptions/extra/start.sh
  return 0
}

stop() {
  /userdata/system/pro/livecaptions/extra/stop.sh
  return 0
}

case "$1" in
        start)
                start &
                ;;
        stop)
                stop &
                ;;
        *)
                echo "Usage: $0 {start|stop}"
                exit 1
esac
