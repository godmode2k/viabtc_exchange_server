#!/bin/sh
# hjkim, 2023.07.21



# RDB
#
# RDB file path
# 127.0.0.1:6379> CONFIG get dir
#
# dump manually: SAVE (blocking), BGSAVE (non-blocking)
#
# dump the dataset to disk every 60 seconds if at least 1 key(s) changed
# save 60 1
#
#
#
# AOF
# /usr/local/bin/redis-check-aof --fix /data/appendonly.aof
# /etc/redis/redis.conf
# Append only mode is disabled by default.
# appendonly yes



echo 'backup redis dump...'
echo 'TODO...'


DATE=$(date '+%Y-%m-%d')
TIMESTAMP=$(date +%s)
DATETIME=$DATE'-'$TIMESTAMP

echo 'datetime: '$DATETIME

CONTAINERS=`docker ps -a | grep _redis | awk '{print $1 "," $NF}' | sed -e 's/redis-sentinel-docker-example_//'`
for i in $(echo $CONTAINERS)
do
    #echo $i
    CONTAINER_ID=`echo $i | awk -F, '{print $1}'`
    CONTAINER_NAME=`echo $i | awk -F, '{print $2}'`
    #echo 'CONTAINER ID = '$CONTAINER_ID', NAME = '$CONTAINER_NAME

    echo echo docker cp $CONTAINER_ID':/.../dump.rdb' './'$DATETIME'-'$CONTAINER_NAME'-dump.rdb'
done
exit


