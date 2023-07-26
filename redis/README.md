
# redis-sentinel-docker-example


## Github

https://github.com/vhf/redis-sentinel-docker-example

```
$ git clone https://github.com/vhf/redis-sentinel-docker-example.git
```


## Configure

```
// EDIT docker-compose.yml [
removes "networks: {...}"
replace: expose -> ports

redis1:
    image: redis:4.0.0
    ports:
        - "6380:6379"
redis2:
    image: redis:4.0.0
    ports:
        - "6381:6379"
redis3:
    image: redis:4.0.0
    ports:
        - "6382:6379"

sentinel1:
    ports:
        - "26380:26379"
    volumes:
        - ./sentinel1.conf:/etc/sentinel.conf
sentinel2:
    ports:
        - "26381:26379"
    volumes:
        - ./sentinel2.conf:/etc/sentinel.conf
sentinel3:
    ports:
        - "26382:26379"
    volumes:
        - ./sentinel3.conf:/etc/sentinel.conf

...
volumes:
    sentinel1.conf:
    sentinel2.conf:
    sentinel3.conf:
// ]
```


## Run

Note: sentinel.conf must be writeable

```
$ cd redis-sentinel-docker-example

// MUST copy init config file for initialize configuration when restarting.
// Init required to prevent shutdown containers because its occurs by changed network info when restarted.
$ cp backup/sentinel*.conf .

// sentinel*.conf must be writeable
$ chmod 666 ./sentinel*.conf

$ sudo docker-compose up -d


# DO NOT USE 'down' because container will be deleted (data loss).
$ sudo docker-compose stop


i.e.,

// start
$ cp backup/sentinel*.conf .
$ chmod 666 ./sentinel*.conf
$ sudo docker-compose up -d

// stop and restart
$ sudo docker-compose stop
$ cp backup/sentinel*.conf .
$ chmod 666 ./sentinel*.conf
$ sudo docker-compose up -d

// you can also use script
$ sudo sh run_start_redis_sentinel.sh
$ sudo sh run_stop_redis_sentinel.sh



issue:
 ...UnixHTTPConnectionPool(host='localhost', port=None): Read timed out. (read timeout=60)...
workaround:
 // restart Docker service
 $ sudo service docker restart
```


