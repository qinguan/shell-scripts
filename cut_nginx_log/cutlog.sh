#!/bin/bash

logdir="/data/nginx/logs"
sdir="/data/nginx/script"
pid=`cat /data/nginx/nginx.pid`
DATE=`date -d "5 min ago" +%Y%m%d%H%M`
for i in `ls $logdir/*access*.log`; do
        mv $i $i.$DATE
done
kill -s USR1 $pid
for j in $(ls $logdir/*.$DATE); do
        gzip $j
done
[ -d /data/nginx/logs ] && find /data/nginx/logs/ -maxdepth 1 -type f -atime +60 -name "*access*.log*gz"  -exec rm -f {} \;
