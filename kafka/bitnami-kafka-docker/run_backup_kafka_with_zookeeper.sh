#!/bin/sh
# hjkim, 2023.07.21



echo 'backup kafka...'
echo 'TODO...'


DATE=$(date '+%Y-%m-%d')
TIMESTAMP=$(date +%s)
DATETIME=$DATE'-'$TIMESTAMP

echo 'datetime: '$DATETIME

CONTAINERS=`docker ps -a | grep kafka | awk '{print $1 "," $NF}'`
for i in $(echo $CONTAINERS)
do
    #echo $i
    CONTAINER_ID=`echo $i | awk -F, '{print $1}'`
    CONTAINER_NAME=`echo $i | awk -F, '{print $2}'`
    #echo 'CONTAINER ID = '$CONTAINER_ID', NAME = '$CONTAINER_NAME

    #echo echo docker cp $CONTAINER_ID':/.../file' './'$DATETIME'-'$CONTAINER_NAME'-'
done
exit


