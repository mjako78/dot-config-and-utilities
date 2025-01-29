#!/bin/bash

function usage() {
  echo "usage: livehosts.sh <subnetMask>"
  echo "       subnetMask   the subnet mask to query; example: 192.168.1.0/24"
}

if [ $# -ne 1 ]; then
  echo "[ERR ] Wrong number of arguments"
  usage
  exit 1
fi

echo "The following hosts are alive in subnet $1"
nmap "$1" -n -sP | grep report | awk '{print $5}'

exit 0
