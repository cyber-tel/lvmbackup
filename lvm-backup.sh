#!/bin/bash

PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

d=$(date +%F)
f=$2
g=$1
v=${f}-backup-${d}
t=/var/backups/${d}-${g}-${f}.dd.gz

logger -t lvmbackup "Creating snapshot ${v}"
lvcreate -L1G -s -n ${v} -p r $g/$f
logger -t lvmbackup "Writing data to ${t}"
dd if=/dev/Cyber/${v} bs=10M | gzip > ${t}
logger -t lvmbackup "Removing snapshot ${v}"
lvremove -f ${g}/${v}

