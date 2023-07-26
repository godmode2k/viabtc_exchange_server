#!/bin/sh
# hjkim, 2023.07.21



echo 'delete redis-sentinel containers'
docker-compose stop
docker-compose down

echo 'SEE:'
echo 'local volume'
echo ' - redis-sentinel-docker-example_sentinel1.conf'
echo ' - redis-sentinel-docker-example_sentinel2.conf'
echo ' - redis-sentinel-docker-example_sentinel3.conf'
echo '$ docker volume ls'
echo '$ docker volume rm redis-sentinel-docker-example_sentinel1.conf'
echo '$ docker volume rm redis-sentinel-docker-example_sentinel2.conf'
echo '$ docker volume rm redis-sentinel-docker-example_sentinel3.conf'

