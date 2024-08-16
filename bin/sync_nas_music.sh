#!/bin/bash
# Sync music library from Synology NAS to Local

## Dependencies
### - cifs-utils, to mount samba share
### - rsync, to sync files and directories

## [0.1.0] - 2023-12-02
### First version
### - basic sync from Synology to Local

SYNOLOGY_IP=192.168.1.8
SYNOLOGY_FOLDER=music
SYNOLOGY_USER=mauro
LOCAL_MP=/mnt/synology_music
LOCAL_FOLDER=/rpool/music

# Check if running as root
if [ "$EUID" -ne 0 ]; then
  echo "[ERR ] Run this script as root"
  exit 1
fi

if [ ! -d $LOCAL_MP ]; then
  echo "[WARN] Mountpoint $LOCAL_MP not exists; creating"
  mkdir -p $LOCAL_MP
  echo "[OK  ] Mountpoint $LOCAL_MP created"
fi

echo "[    ] Mount Synology folder on Local"
mountpoint -q $LOCAL_MP
rc=$?
if [ $rc -eq 0 ]; then
  echo "[INFO] Share already mounted on Local"
else
  mount -t cifs //$SYNOLOGY_IP/$SYNOLOGY_FOLDER $LOCAL_MP -o username=$SYNOLOGY_USER
  rc=$?
  if [ $rc -ne 0 ]; then
    echo "[ERR ] Error connecting to Synology; check if it's up & running"
    exit 1
  fi
  echo "[OK  ] Mount Synology folder on Local"
fi

echo "[    ] Run rsync from Synology to Local"
rsync -avh --progress --stats $LOCAL_MP/* $LOCAL_FOLDER
echo "[OK  ] Run rsync from Synology to Local"

echo "[    ] Unmount share on Local"
umount $LOCAL_MP
echo "[OK  ] Unmount share on Local"

exit 0
