#!/bin/bash
#
# Test script to automate the Linux client download and configuration.
# It downloads, compiles and starts the SoftEther VPN client then it feeds the linuxconfig file for SoftEther commands
# and the myhub.vpn downloaded from wormhole.network for client configuration.
#
#  Wormhole Network - 2016
#
# This code is made public for our customers and anyone else interested. It might not always reflect the latest version in production.
#
#
LINK="http://softether-download.com/files/softether/v4.19-9599-beta-2015.10.19-tree/Linux/SoftEther_VPN_Client/64bit_-_Intel_x64_or_AMD64/softether-vpnclient-v4.19-9599-beta-2015.10.19-linux-x64-64bit.tar.gz"
FILE="$(echo $LINK | awk -F "/" '{print $NF}')"
VPNCONFIGFILE="myhub.vpn"

wget $LINK
tar xvfz $FILE
cd vpnclient
make
./vpnclient start
# Let's copy the files into the folder 
mv ../$VPNCONFIGFILE .
mv ../linuxconfig .
./vpncmd /CLIENT 127.0.0.1:5555 /IN:linuxconfig
dhclient vpn_vpn
echo DONE
