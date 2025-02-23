#!/usr/bin/env bash
# Sync vz dump from Zima to Synology NAS

## Dependencies
### - cifs-utils, to mount samba share
### - rsync, to sync files and directories

## [0.1.0] - 2025-02-23
### First version
### - basic sync from Zima to Synology

SYNOLOGY_IP=192.168.1.8
SYNOLOGY_FOLDER=backups
SYNOLOGY_USER=mauro
ZIMA_MP=/mnt/synology_backup/
ZIMA_FOLDER=/var/lib/vz/dump/

# Check if running as root
if [ "$EUID" -ne 0 ]; then
  echo "[ERR ] Run this script as root"
  exit 1
fi

if [ ! -d $ZIMA_MP ]; then
  echo "[WARN] Mountpoint $ZIMA_MP not exists; creating"
  mkdir -p $ZIMA_MP
  echo "[OK  ] Mountpoint $ZIMA_MP created"
fi

echo "[    ] Mount Synology folder on Zima"
mountpoint -q $ZIMA_MP
rc=$?
if [ $rc -eq 0 ]; then
  echo "[INFO] Share already mounted on Zima"
else
  mount -t cifs //$SYNOLOGY_IP/$SYNOLOGY_FOLDER $ZIMA_MP -o username=$SYNOLOGY_USER
  rc=$?
  if [ $rc -ne 0 ]; then
    echo "[ERR ] Error connecting to Synology; check if it's up & running"
    exit 1
  fi
  echo "[OK  ] Mount Synology folder on Zima"
fi

echo "[    ] Run rsync from Synology to Zima"
rsync -azvhP --progress --stats --delete $ZIMA_FOLDER $ZIMA_MP/zima_vm_ct
echo "[OK  ] Run rsync from Synology to Zima"

echo "[    ] Unmount share on Zima"
umount $ZIMA_MP
echo "[OK  ] Unmount share on Zima"

exit 0
