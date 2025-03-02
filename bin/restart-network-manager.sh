#!/usr/bin/env bash
# Restart network manager if connection goes down

## [0.1.0] - 2025-03-02
### First version
### - ping gateway; if not respond restart NetworkManager

GATEWAY_IP=192.168.1.1

# Check if running as root
if [ "$EUID" -ne 0 ]; then
  echo "[ERR ] Run this script as root"
  exit 1
fi

ping -c4 -q $GATEWAY_IP > /dev/null
rc=$?
if [ $rc -ne 0 ]; then
  systemctl restart NetworkManager
fi

exit 0
