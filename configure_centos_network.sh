#!/bin/bash
# After installing the CentOS, you can use this script to configure the network with DHCP. 

sed -i 's/^ONBOOT="no"/ONBOOT="yes"/' /etc/sysconfig/network-scripts/ifcfg-eth0 | bash -x
service network restart
