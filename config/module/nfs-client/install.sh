#!/usr/bin/env bash

apt-get update -yyq
apt-get install -yqq nfs-common
mkdir -p /mnt/pool
mount -t nfs ${NFS_AGENT}:/srv/storage /mnt/pool
