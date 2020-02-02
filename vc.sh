#!/bin/bash
# Author: hybfkuf
# Created Time: 2020-2-2
# Version: 1.0
# Description: virt-clone clone virtual machine and sysprep

EXIT_SUCCESS=0
EXIT_FAILURE=1

VIRT_CLONE="/usr/bin/virt-clone"
VIRT_SYSPREP="/usr/bin/virt-sysprep"
read -p "Virtual Machine Template: " Template
read -p "New Virtual Machine Name: " VM
DEST_PATH="/var/lib/libvirt/images"

# echo with color
RED='\E[1;31m'
GREEN='\E[1;32m'
YELLOW='\E[1;33mm'
BLUE='\E[1;34m'
PINK='\E[1;35m'
RES='\E[0m'

# command virt-clone is exist ?
if [ ! -x "$VIRT_CLONE" ]; then
    echo "virt-clone command not found or not executable"
    exit $EXIT_FAILURE
fi

# Template is exist ?
TEMP=$(virsh list --all | grep -o "$Template" | uniq)
if [ "$TEMP" != "$Template" ]; then
    echo "Specified Template not found"
    exit $EXIT_FAILURE
fi

# DEST_PATH is exist ?
if [ ! -d "$DEST_PATH" ]; then
    echo "$DEST_PATH is not found"
    exit $EXIT_FAILURE
fi



# cloning virtual machine
echo -e "${GREEN}cloning virtual machine ......${RES}"
"$VIRT_CLONE" -o "$Template" -n "$VM" -f "$DEST_PATH"/"$VM"

# sysprep virtual machine
if [ $? -eq 0 ]; then
    echo -e "${GREEN}sysprep the vm ......${RES}"
    "$VIRT_SYSPREP" -d "$VM"
fi
