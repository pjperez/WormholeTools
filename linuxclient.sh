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
LINK="https://whdowns.blob.core.windows.net/whclient/softether-vpnclient-v4.19-9599-beta-2015.10.19-linux-x64-64bit.tar.gz"
FILE="$(echo $LINK | awk -F "/" '{print $NF}')"


# Download, uncompress and compile the client
wget $LINK
tar xvfz $FILE
cd vpnclient
make

# Start the VPN client daemon
./vpnclient start

# Let's copy the files into the folder 
mv ../*.vpn .
mv ../linuxconfig .
./vpncmd /CLIENT 127.0.0.1:5555 /IN:linuxconfig

# Get a new IP address and show the 
dhclient vpn_vpn
