#!/bin/bash
# change the hostname On CentOS/REHL

function show_usage {
	echo "Usage: $0 hostname"
	exit 1;
}

if [ $# -ne 1 ]; then
	show_usage
fi

hostname=$1

sed -i /^HOSTNAME=/{s/^/#/g} /etc/sysconfig/network
echo HOSTNAME=$hostname >> /etc/sysconfig/network

#$IP=`/sbin/ifconfig eth0 | grep "inet addr" | cut -f 2 -d ':' | cut -f 1 -d ' '`
IP=`/sbin/ifconfig | grep "inet addr" | head -n1 | cut -f 2 -d ':' | cut -f 1 -d ' '`
echo "$IP $hostname" >> /etc/hosts

hostname $hostname
service network restart

