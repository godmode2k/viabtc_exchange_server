#!/bin/sh
# hjkim, 2023.07.21



echo 'DO NOT USE "down"'
docker-compose -f docker-compose-kafka-with-zookeeper.yml stop

sleep 1

docker-compose -f docker-compose-kafka-with-zookeeper.yml up -d

