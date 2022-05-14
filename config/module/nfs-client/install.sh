#!/usr/bin/env bash

apt-get update -yyq
apt-get install -yqq nfs-common
rm -rf /mnt/pool
mkdir -p /mnt/pool
mount -t nfs -o allow_other ${NFS_AGENT}:/srv/storage /mnt/pool
