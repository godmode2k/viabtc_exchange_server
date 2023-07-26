#!/bin/sh
# hjkim, 2023.07.21



# MUST copy init config file for initialize configuration when restarting.
# Init required to prevent shutdown containers because its occurs by changed network info when restarted.
echo 'Copying init files sentinel*.conf...'
cp backup/sentinel*.conf .
# sentinel*.conf must be writeable
chmod 666 ./sentinel*.conf

docker-compose up -d

