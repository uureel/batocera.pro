#!/bin/sh

start() {
  DISPLAY=:0.0 nohup /userdata/system/pro/livecaptions/extra/start.sh 1>/dev/null 2>/dev/null &
  echo 1>/dev/null
  return 0
}

stop() {
  DISPLAY=:0.0 nohup /userdata/system/pro/livecaptions/extra/stop.sh 1>/dev/null 2>/dev/null &
  echo 1>/dev/null
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
