#!/usr/bin/env bash
# Sync backrest repos from Raspy5 to Synology NAS

## Dependencies
### - cifs-utils, to mount samba share
### - rsync, to sync files and directories

## [0.1.0] - 2025-03-02
### First version
### - basic sync from Raspy5 to Synology

SYNOLOGY_IP=192.168.1.8
SYNOLOGY_FOLDER=backups
SYNOLOGY_USER=mauro
RASPY5_MP=/mnt/synology_backup
RASPY5_FOLDER=/home/mauro/backup-repos

# Check if running as root
if [ "$EUID" -ne 0 ]; then
  echo "[ERR ] Run this script as root"
  exit 1
fi

if [ ! -d $RASPY5_MP ]; then
  echo "[WARN] Mountpoint $RASPY5_MP not exists; creating"
  mkdir -p $RASPY5_MP
  echo "[OK  ] Mountpoint $RASPY5_MP created"
fi

echo "[    ] Mount Synology folder on Raspy5"
mountpoint -q $RASPY5_MP
rc=$?
if [ $rc -eq 0 ]; then
  echo "[INFO] Share already mounted on Raspy5"
else
  mount -t cifs //$SYNOLOGY_IP/$SYNOLOGY_FOLDER $RASPY5_MP -o username=$SYNOLOGY_USER
  rc=$?
  if [ $rc -ne 0 ]; then
    echo "[ERR ] Error connecting to Synology; check if it's up & running"
    exit 1
  fi
  echo "[OK  ] Mount Synology folder on Raspy5"
fi

echo "[    ] Run rsync from Raspy5 to Synology"
rsync -azvhP --progress --stats $RASPY5_FOLDER/ $RASPY5_MP/raspy5-backrest-repos
echo "[OK  ] Run rsync from Raspy5 to Synology"

echo "[    ] Unmount share on Raspy5"
umount $RASPY5_MP
echo "[OK  ] Unmount share on Raspy5"

exit 0
