
# Kafka


## Github

// wurstmeister/kafka <br>
https://github.com/wurstmeister/kafka-docker <br> <br>

(USE THIS) <br>
// bitnami kafka docker <br>
https://github.com/bitnami/containers/tree/main/bitnami/kafka <br>

```
// wurstmeister/kafka
$ git clone https://github.com/wurstmeister/kafka-docker.git


(USE THIS)
// bitnami kafka docker
https://github.com/bitnami/containers/tree/main/bitnami/kafka
```


## Download

// wurstmeister/kafka <br>
https://github.com/wurstmeister/kafka-docker/archive/1.1.0.tar.gz <br> <br>

(USE THIS) <br>
// bitnami kafka docker <br>
$ https://raw.githubusercontent.com/bitnami/containers/main/bitnami/kafka/docker-compose.yml <br>

```
// wurstmeister/kafka
$ sudo docker pull wurstmeister/kafka


(USE THIS)
// bitnami kafka docker
$ curl -sSL https://raw.githubusercontent.com/bitnami/containers/main/bitnami/kafka/docker-compose.yml > docker-compose.yml
```


## Configure

```
// wurstmeister/kafka
edit docker-compose.yml

// for single broker (localhost)
KAFKA_ADVERTISED_HOST_NAME: 127.0.0.1


(USE THIS)
// bitnami kafka docker
USE <docker-compose-kafka-with-zookeeper.yml>

default: KAFKA_CFG_ADVERTISED_LISTENERS=PLAINTEXT://127.0.0.1:9092

KAFKA_CFG_ADVERTISED_LISTENERS=PLAINTEXT://<Public IP>:9092


Configure <docker-compose-kafka-with-zookeeper.yml>
version: "3"

services:
    zookeeper:
        #image: docker.io/bitnami/zookeeper:3.8
        image: docker.io/bitnami/zookeeper:latest
        ports:
            - "2181:2181"
        volumes:
            - "zookeeper_data:/bitnami"
        environment:
            - ALLOW_ANONYMOUS_LOGIN=yes
    kafka:
        #image: docker.io/bitnami/kafka:3.4
        image: docker.io/bitnami/kafka:latest
        ports:
            - "9092:9092"
        volumes:
            - "kafka_data:/bitnami"
        environment:
            #- KAFKA_BROKER_ID=
            - ALLOW_PLAINTEXT_LISTENER=yes
            - KAFKA_ENABLE_KRAFT=no
            - KAFKA_CFG_ZOOKEEPER_CONNECT=zookeeper:2181
            - KAFKA_CFG_LISTENERS=PLAINTEXT://:9092
            #- KAFKA_CFG_ADVERTISED_LISTENERS=PLAINTEXT://127.0.0.1:9092
            - KAFKA_CFG_ADVERTISED_LISTENERS=PLAINTEXT://10.0.2.5:9092
        depends_on:
            - zookeeper

volumes:
    zookeeper_data:
        driver: local
    kafka_data:
        driver: local
```


## Run

```
// wurstmeister/kafka
$ cd kafka-docker-1.1.0
$ sudo docker-compose -f docker-compose-single-broker.yml up -d


(USE THIS)
// bitnami kafka docker
// $ curl -sSL https://raw.githubusercontent.com/bitnami/containers/main/bitnami/kafka/docker-compose.yml > docker-compose.yml
// $ sudo docker-compose up -d

// start
$ sudo docker-compose -f docker-compose-kafka-with-zookeeper.yml up -d
// stop
$ sudo docker-compose -f docker-compose-kafka-with-zookeeper.yml stop

// you can also use script
$ sudo sh run_start_kafka_with_zookeeper.sh
$ sudo sh run_stop_kafka_with_zookeeper.sh
```


## Test

```
// wurstmeister/kafka
// Producer
$ ./kafka-console-producer.sh --bootstrap-server localhost:9092 --topic test

// Consumer
$ ./kafka-console-consumer.sh --bootstrap-server localhost:9092 --topic test
```


## librdkafk
```
* librdkafk
  // clone
  $ git clone https://github.com/edenhill/librdkafka.git
  or
  $ git clone https://github.com/confluentinc/librdkafka.git

  // download (version)
  $ wget -O /librdkafka-v2.2.0.tar.gz https://github.com/confluentinc/librdkafka/archive/refs/tags/v2.2.0.tar.gz
  or
  $ curl -o /librdkafka-v2.2.0.tar.gz -L https://github.com/confluentinc/librdkafka/archive/refs/tags/v2.2.0.tar.gz
  $ tar xzvf /librdkafka-v2.2.0.tar.gz -C / && ln -s /librdkafka-2.2.0 /librdkafka
```



