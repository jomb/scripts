#!/usr/bin/bash
# Example: ./testTCPport.sh eth1 22 10.121.10.0/24

INTERFACE=$1
PORT=$2
NETWORK=$3

if [ -z "$INTERFACE" ] || [ -z "$PORT" ] || [ -z "$NETWORK" ]; then
  echo 'One or more variables are undefined'
  exit 3
fi

testTCPport=$( nmap -n -e $INTERFACE -PN -p $PORT $NETWORK  | grep open -B3 | grep Nmap | awk '{printf " " $5}' )

if [ -z "$testTCPport"  ]; then
	echo "No issue"
	exit 0
else
	echo "Port $PORT opened on: $testTCPport"
        exit 2
fi
