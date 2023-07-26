#!/bin/sh
# hjkim, 2023.07.21



echo 'delete kafka containers'
docker-compose -f docker-compose-kafka-with-zookeeper.yml stop
docker-compose -f docker-compose-kafka-with-zookeeper.yml down

echo 'SEE:'
echo 'local volume'
echo ' - bitnami-kafka-docker_kafka_data'
echo ' - bitnami-kafka-docker_zookeeper_data'
echo '$ docker volume ls'
echo '$ docker volume rm bitnami-kafka-docker_kafka_data'
echo '$ docker volume rm bitnami-kafka-docker_zookeeper_data'

