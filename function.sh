#!/bin/bash
# Author: hybfkuf
# Created Date: 2020-3-2
# Description: function


function blue(){ echo -e "\033[34m\033[01m$1\033[0m";}
function green(){ echo -e "\033[32m\033[01m$1\033[0m";}
function red(){ echo -e "\033[31m\033[01m$1\033[0m";}


function rand() {
    min=$1
    max=$(($2-$min+1))
    num=$(cat /dev/urandom | head -n 10 | cksum | awk -F ' ' '{print $1}')
    #num=$(openssl rand -base64 20 | cksum | awk '{print $1}')
    #num=$(cat /proc/sys/kernel/random/uuid | cksum | awk '{print $1}')
    echo $(($num%$max+$min))
}


function check_selinux(){
    CHECK=$(grep SELINUX= /etc/selinux/config | grep -v "#")
    if [ "$CHECK" == "SELINUX=enforcing" ]; then
        red "================================================="
        red "SELinux is enforcing, please reboot "
        red "================================================="
        read -p "Yes or Not? Default is Yes [Y/n] : " yn
	    [ -z "${yn}" ] && yn="y"
	    if [[ $yn == [Yy] ]]; then
    	    sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/selinux/config
            setenforce 0
	        echo -e "Rebooting ..."
	        reboot
	    fi
        exit
    fi
    if [ "$CHECK" == "SELINUX=permissive" ]; then
        red "================================================="
        red "SELinux is permissive, please reboot"
        red "================================================="
        read -p " Yes or Not? Default is Yes [Y/n] :" yn
	    [ -z "${yn}" ] && yn="y"
	    if [[ $yn == [Yy] ]]; then
	        sed -i 's/SELINUX=permissive/SELINUX=disabled/g' /etc/selinux/config
            setenforce 0
	        echo -e "Rebooting ..."
	        reboot
	    fi
        exit
    fi
}


function check_release() {
    source /etc/os-release
    RELEASE=$ID
    VERSION=$VERSION_ID
}
