
# ViaBTC Exchange Server


Summary
----------
> ViaBTC-Exchange-Server on Docker </br>


Environment
----------
> build all and tested on GNU/Linux

    GNU/Linux: Ubuntu 20.04_x64 LTS
    Docker (+ Docker-Compose)
    Kafka
    Redis-Sentinel
    Database: MySQL or MariaDB
    ViaBTC-Exchange-Server (https://github.com/viabtc/viabtc_exchange_server)


## Directory

```
* dockerfile-dist

* kafka (SEE: README.md)
 - bitnami-kafka-docker
 - kafka-docker-1.1.0 (wurstmeister/kafka)

* redis (SEE: README.md)
 - redis-sentinel (redis-sentinel-docker-example)

* origin_viabtc_exchange_server
 - source-based (https://github.com/viabtc/viabtc_exchange_server)
```


## Changed

* You can find added new search keyword "//! ADD NEW:" in source code (./viabtc_exchange_server/).

```
1. Build
 OS: Ubuntu 20.04 LTS x86_64
 Docker (Ubuntu 20.04),
 Kafka: librdkafka v2.2.0, Kafka (bitnami-kafka-docker: Docker image)
 Redis: redis v4.0.10, redis-sentinel (Docker image)
 ViaBTC-Exchange-Server: Ubuntu 20.04 LTS x86_64 (with MySQL 8.x, MariaDB)


2. Listing/Delisting without restart services. [in-progress]


3. Redis Server connection issue when run ViaBTC services inside Docker.
 i.e., you can see logs below.

 Redis Host (private or public?): 172.20.0.3:6379
 this PID (153) running inside Docker.
 now, Docker container (private) -> Redis Host (public): 10.0.2.5:6380


4. Change fee calculates.
 in bid, change fee calculates base-currency to quote-currency
 instead of ViaBTC's approach (base-currency - fee).

 before: bid (AAA/BBB) -> (AAA - fee)
 after: bid (AAA/BBB) -> (BBB - fee)

 You can also replace this back to origin. (matchengine/me_market.c)
```


## Build

```
1. EDIT Dockerfile

* source code filename (date)
  COPY ./viabtc_exchange_server_src_yyyy.mm.dd.tar /
  RUN tar xvf /viabtc_exchange_server_src_yyyy.mm.dd.tar

* librdkafk
  # // clone
  RUN git clone https://github.com/edenhill/librdkafka.git
  or
  RUN git clone https://github.com/confluentinc/librdkafka.git

  # // download (version)
  RUN wget -O /librdkafka-v2.2.0.tar.gz https://github.com/confluentinc/librdkafka/archive/refs/tags/v2.2.0.tar.gz
  #RUN curl -o /librdkafka-v2.2.0.tar.gz -L https://github.com/confluentinc/librdkafka/archive/refs/tags/v2.2.0.tar.gz
  RUN tar xzvf /librdkafka-v2.2.0.tar.gz -C / && ln -s /librdkafka-2.2.0 /librdkafka


2. EDIT configure

* config.json (log path, Kafka, Redis, Database, ...)
 - for all service processes (matchengine, alertcenter, readhistory, accesshttp, accessws, marketprice)
 -
 - You can use 'set_info.sh' script file

* init_trade_history.sh (Database init script (Database info))
 - You can use 'set_info.sh' script file

* set_info.sh (configure script)
 - config.json (log path, Kafka, Redis, Database, ...)
 - init_trade_history.sh (Database init script (Database info))


3. Build and Run
 $ docker build -f Dockerfile.viabtc_exchange_server_backends -t viabtc_exchange_server:1.0 .


 // Kafka
 $ cd kafka/bitnami-kafka-docker
 EDIT 'docker-compose-kafka-with-zookeeper.yml'
  - KAFKA_CFG_ADVERTISED_LISTENERS=PLAINTEXT://<Public IP>:9092
 $ sudo sh run_start_kafka_with_zookeeper.sh


 // Redis-Sentinel
 $ cd redis/redis-sentinel/redis-sentinel-docker-example
 $ sudo sh run_start_redis_sentinel.sh


 // MySQL or MariaDB
 $ docker run -d -e MYSQL_ROOT_PASSWORD="..." -p 33060:3306 mysql:latest
 or
 $ docker run -d -e MARIADB_ROOT_PASSWORD="..." -p 33060:3306 mariadb:latest


 // ViaBTC Exchange Server
 $ docker run --rm -it --name "viabtc_exchange_server" viabtc_exchange_server:1.0
 $ docker exec -it <container id> bash
 or
 $ docker exec -it -u root <container id> bash

 (container) $ sh set_info.sh # EDIT (log path, Kafka, Redis, Database, ...)
 (container) $ sh init_trade_history.sh # EDIT (Database info)

 (container) $ cd /viabtc_exchange_server
 (container) $ sh restart_all.sh
 (container) $ sh stop_all.sh
```


## Test

```
--------------------------------------------
HTTP API
--------------------------------------------
https://github.com/viabtc/viabtc_exchange_server/wiki/HTTP-Protocol

// $ curl http://127.0.0.1:8080 -d '{"method": "", "params": [], "id": 1}'



curl http://127.0.0.1:8080/ -d '{"method": "balance.query", "params": [1, "BTC"], "id": 1}'
{
	"error": null,
		"result": {
			"BTC": {
				"available": "0",
				"freeze": "0"
			}
		},
		"id": 1
}



// Asset
------------------------------------

curl http://127.0.0.1:8080/ -d '{"method": "asset.list", "params": [], "id": 1}'
curl http://127.0.0.1:8080/ -d '{"method": "asset.summary", "params": [], "id": 1}'



// Balance
------------------------------------

// balance
curl http://127.0.0.1:8080/ -d '{"method": "balance.query", "params": [1, "BTC"], "id": 1}'
// balance history: limit count: 100
curl http://127.0.0.1:8080/ -d '{"method": "balance.history", "params": [1, "BTC", "", 0, 0, 0, 100], "id": 1}'

// set
curl http://127.0.0.1:8080/ -d '{"method": "balance.update", "params": [1, "BTC", "deposit", 100, "100.1234", {}], "id": 1}'
curl http://127.0.0.1:8080/ -d '{"method": "balance.update", "params": [1, "BTC", "deposit", 101, "100.1234", {}], "id": 1}'
curl http://127.0.0.1:8080/ -d '{"method": "balance.update", "params": [1, "BTC", "withdraw", 100, "-10.34", {}], "id": 1}'



// Trade
------------------------------------

[Order Book]

// Order list: sell
curl http://127.0.0.1:8080/ -d '{"method": "order.book", "params": ["BTCBCH", 1, 0, 100], "id": 1}'

// Order list: buy
curl http://127.0.0.1:8080/ -d '{"method": "order.book", "params": ["BTCBCH", 2, 0, 100], "id": 1}'

// Order list: depth
curl http://127.0.0.1:8080/ -d '{"method": "order.depth", "params": ["BTCBCH", 0, "0"], "id": 1}'


// inquire
curl http://127.0.0.1:8080/ -d '{"method": "order.pending", "params": [1, "BTCBCH", 0, 100], "id": 1}'
curl http://127.0.0.1:8080/ -d '{"method": "order.pending_detail", "params": ["BTCBCH", 0], "id": 1}'
// - all, limit 1
curl http://127.0.0.1:8080/ -d '{"method": "order.finished", "params": [1, "BTCBCH", 0, 0, 0, 1, 0], "id": 1}'
// - sell, limit 1
curl http://127.0.0.1:8080/ -d '{"method": "order.finished", "params": [1, "BTCBCH", 0, 0, 0, 1, 1], "id": 1}'
// - buy, limit 1
curl http://127.0.0.1:8080/ -d '{"method": "order.finished", "params": [1, "BTCBCH", 0, 0, 0, 1, 2], "id": 1}'
// - executed order details: order id 100
curl http://127.0.0.1:8080/ -d '{"method": "order.finished_detail", "params": [100], "id": 1}'
// - order details: order id 100, limit 1
curl http://127.0.0.1:8080/ -d '{"method": "order.deals", "params": [100, 0, 0], "id": 1}'


[Trade]

// place limit order
// - sell 10.1234 at 8000
curl http://127.0.0.1:8080/ -d '{"method": "order.put_limit", "params": [1, "BTCBCH", 1, "10.1234", "8000", "0.002", "0.001", "text"], "id": 1}'
// - buy 10 at 8000
curl http://127.0.0.1:8080/ -d '{"method": "order.put_limit", "params": [1, "BTCBCH", 2, "10", "8000", "0.002", "0.001", "text"], "id": 1}'

// place market order
// - sell
curl http://127.0.0.1:8080/ -d '{"method": "order.put_market", "params": [1, "BTCBCH", 1, "10.1234", "0.002", "text"], "id": 1}'

// cancel order: order id 100
curl http://127.0.0.1:8080/ -d '{"method": "order.cancel", "params": [1, "BTCBCH", 100], "id": 1}'



// Market
------------------------------------

curl http://127.0.0.1:8080/ -d '{"method": "market.list", "params": [], "id": 1}'
curl http://127.0.0.1:8080/ -d '{"method": "market.summary", "params": [], "id": 1}'
curl http://127.0.0.1:8080/ -d '{"method": "market.summary", "params": ["BTCBCH"], "id": 1}'


// Market price (last)
curl http://127.0.0.1:8080/ -d '{"method": "market.last", "params": ["BTCBCH"], "id": 1}'

// executed history
// - limit count: 100
curl http://127.0.0.1:8080/ -d '{"method": "market.deals", "params": ["BTCBCH", 100, 0], "id": 1}'

// user executed history
// - limit count: 100
curl http://127.0.0.1:8080/ -d '{"method": "market.user_deals", "params": [1, "BTCBCH", 0, 100], "id": 1}'


// Kline
curl http://127.0.0.1:8080/ -d '{"method": "market.kline", "params": ["BTCBCH", 1, 100, 1], "id": 1}'


// status
// - period (cycle period): 86400 for last 24 hours
curl http://127.0.0.1:8080/ -d '{"method": "market.status", "params": ["BTCBCH", 86400], "id": 1}'


// status today
curl http://127.0.0.1:8080/ -d '{"method": "market.status_today", "params": ["BTCBCH"], "id": 1}'
```


