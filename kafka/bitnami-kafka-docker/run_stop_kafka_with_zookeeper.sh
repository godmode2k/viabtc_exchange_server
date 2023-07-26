#!/bin/sh
# hjkim, 2023.07.21



# NOTE:
# - DO NOT USE 'down' because container will be deleted (data loss).
# - USE 'stop'
echo 'DO NOT USE "down"'
docker-compose -f docker-compose-kafka-with-zookeeper.yml stop

