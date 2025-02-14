#!/usr/bin/env bash

# Check for open ports
# depends on ss command

# Check if running as root
function check_root() {
  if [ "$EUID" -ne 0 ]; then
    echo "[ERR ] Run this script as root"
    exit 1
  fi
}

# Check dependencies
function check_deps() {
  which ss &> /dev/null
  rc=$?
  if [ $rc -ne 0 ]; then
    echo "[ERR ] Missing 'ss' package"
    exit 1
  fi
}

check_root
check_deps

ss -tulpn

exit 0
