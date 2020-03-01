#!/bin/bash

# Modifed Data: 2020-1-17
# Author: hybfkuf
# Description:
#   echo to terminal and with color


# Method 1

RED='\E[1;31m'
GREEN='\E[1;32m'
YELLOW='\E[1;33m'
BLUE='\E[1;34m'
PINK='\E[1;35m'
RES='\E[0m'

echo -e "${RED}Hello Shell${RES}"
echo -e "${GREEN}Hello Shell${RES}"
echo -e "${BLUE}Hello Shell${RES}"
echo -e "${PINK}Hello Shell${RES}"


# Method 2
SETCOLOR_SUCCESS="echo -en \\033[1;32m"
SETCOLOR_FAILURE="echo -en \\033[1;31m"
SETCOLOR_WARNING="echo -en \\033[1;33m"
SETCOLOR_NORMAL="echo -en \\033[1;39m"

echo SUCCESS && $SETCOLOR_SUCCESS
echo FAILURE && $SETCOLOR_FAILURE
echo WARNING && $SETCOLOR_WARNING
echo NORMAl && $SETCOLOR_NORMAL
