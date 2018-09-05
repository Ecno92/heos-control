#!/bin/sh
TIMEOUT=2

# Edit the variables below
VOLUME=22
SID=1028
MID=s124127
PID=1274799944
HEOS_IP=192.168.1.101
USERNAME=email@example.com
PASSWORD=YoUrPassw0rd

play() {
    echo -e "heos://system/sign_in?un=${USERNAME}&pw=${PASSWORD}" | curl -s telnet://$HEOS_IP:1255 -m $TIMEOUT > /dev/null
    echo -e "heos://player/get_players" | curl -s telnet://$HEOS_IP:1255 -m $TIMEOUT > /dev/null
    echo -e "heos://player/set_volume?pid=${PID}&level=${VOLUME}\r" | curl -s telnet://$HEOS_IP:1255 -m $TIMEOUT > /dev/null
    echo -e "heos://browse/play_stream?pid=${PID}&sid=${SID}&mid=${MID}\r" | curl -s telnet://$HEOS_IP:1255 -m $TIMEOUT > /dev/null
}

stop() {
    echo -e "heos://player/set_play_state?pid=${PID}&state=stop\r" | curl -s telnet://$HEOS_IP:1255 -m $TIMEOUT > /dev/null
}

"$@"
exit 0
