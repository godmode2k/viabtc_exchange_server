#!/bin/sh

# configuration
# hjkim, 2023.07.18



# EDIT ---------------------------------- [
# SRC path
SRC_PATH_OLD="\/mnt\/data\/viabtc"
SRC_PATH_NEW="\/viabtc_exchange_server"
SRC_PATH="/viabtc_exchange_server"

# Kafka
KAFKA_INFO_OLD="127.0.0.1:9092"
KAFKA_INFO_NEW="127.0.0.1:9092"

# Redis
REDIS_INFO0_OLD="my_redis_master"
REDIS_INFO1_OLD="127.0.0.1:26380"
REDIS_INFO2_OLD="127.0.0.1:26381"
REDIS_INFO3_OLD="127.0.0.1:26382"
#
REDIS_INFO0_NEW="my_redis_master"
REDIS_INFO1_NEW="127.0.0.1:26380"
REDIS_INFO2_NEW="127.0.0.1:26381"
REDIS_INFO3_NEW="127.0.0.1:26382"

# Database
_DB_INFO_HOST_VAL_OLD="127.0.0.1"
_DB_INFO_PORT_VAL_OLD="3306"
_DB_INFO_USER_VAL_OLD="root"
_DB_INFO_PASS_VAL_OLD="mysql"
#
_DB_INFO_HOST_VAL_NEW="127.0.0.1"
_DB_INFO_PORT_VAL_NEW="3306"
_DB_INFO_USER_VAL_NEW="root"
_DB_INFO_PASS_VAL_NEW="mysql"
#
DB_INFO_HOST_OLD="\"host\":\ \"$_DB_INFO_HOST_VAL_OLD\","
DB_INFO_PORT_OLD="\"port\":\ $_DB_INFO_PORT_VAL_OLD,"
DB_INFO_USER_OLD="\"user\":\ \"$_DB_INFO_USER_VAL_OLD\","
DB_INFO_PASS_OLD="\"pass\":\ \"$_DB_INFO_PASS_VAL_OLD\","
#
DB_INFO_HOST_NEW="\"host\":\ \"$_DB_INFO_HOST_VAL_NEW\","
DB_INFO_PORT_NEW="\"port\":\ $_DB_INFO_PORT_VAL_NEW,"
DB_INFO_USER_NEW="\"user\":\ \"$_DB_INFO_USER_VAL_NEW\","
DB_INFO_PASS_NEW="\"pass\":\ \"$_DB_INFO_PASS_VAL_NEW\","

# Database: for script 'init_trade_history.sh'
# 'MYSQL_' means just env name
SCRIPT_DB_INFO_HOST_OLD="MYSQL_HOST=\"$_DB_INFO_HOST_VAL_OLD\""
SCRIPT_DB_INFO_PORT_OLD="MYSQL_PORT=\"$_DB_INFO_PORT_VAL_OLD\""
SCRIPT_DB_INFO_USER_OLD="MYSQL_USER=\"$_DB_INFO_USER_VAL_OLD\""
SCRIPT_DB_INFO_PASS_OLD="MYSQL_PASS=\"$_DB_INFO_PASS_VAL_OLD\""
#
SCRIPT_DB_INFO_HOST_NEW="MYSQL_HOST=\"$_DB_INFO_HOST_VAL_NEW\""
SCRIPT_DB_INFO_PORT_NEW="MYSQL_PORT=\"$_DB_INFO_PORT_VAL_NEW\""
SCRIPT_DB_INFO_USER_NEW="MYSQL_USER=\"$_DB_INFO_USER_VAL_NEW\""
SCRIPT_DB_INFO_PASS_NEW="MYSQL_PASS=\"$_DB_INFO_PASS_VAL_NEW\""
# EDIT ---------------------------------- ]



# -----------------------------------------------



# log directory
mkdir -p "$SRC_PATH/logs/trade/accesshttp"
mkdir -p "$SRC_PATH/logs/trade/accessws"
mkdir -p "$SRC_PATH/logs/trade/alertcenter"
mkdir -p "$SRC_PATH/logs/trade/marketprice"
mkdir -p "$SRC_PATH/logs/trade/matchengine"
mkdir -p "$SRC_PATH/logs/trade/readhistory"



# ViaBTC config.json
# Edit <'log path', 'DB info', ...>
# for all service processes (matchengine, alertcenter, readhistory, accesshttp, accessws, marketprice)
#
# Working Directory info
# replace: /mnt/data/viabtc -> /viabtc_exchange_server
sed -i -e "s/$SRC_PATH_OLD/$SRC_PATH_NEW/g" $SRC_PATH/accesshttp/config.json
sed -i -e "s/$SRC_PATH_OLD/$SRC_PATH_NEW/g" $SRC_PATH/accessws/config.json
sed -i -e "s/$SRC_PATH_OLD/$SRC_PATH_NEW/g" $SRC_PATH/alertcenter/config.json
sed -i -e "s/$SRC_PATH_OLD/$SRC_PATH_NEW/g" $SRC_PATH/marketprice/config.json
sed -i -e "s/$SRC_PATH_OLD/$SRC_PATH_NEW/g" $SRC_PATH/matchengine/config.json
sed -i -e "s/$SRC_PATH_OLD/$SRC_PATH_NEW/g" $SRC_PATH/readhistory/config.json
#
# Kafka Server info
sed -i -e "s/$KAFKA_INFO_OLD/$KAFKA_INFO_NEW/g" $SRC_PATH/accessws/config.json
sed -i -e "s/$KAFKA_INFO_OLD/$KAFKA_INFO_NEW/g" $SRC_PATH/marketprice/config.json
sed -i -e "s/$KAFKA_INFO_OLD/$KAFKA_INFO_NEW/g" $SRC_PATH/matchengine/config.json
#
# Redis Server info
sed -i -e "s/$REDIS_INFO0_OLD/$REDIS_INFO0_NEW/g" $SRC_PATH/alertcenter/config.json
sed -i -e "s/$REDIS_INFO1_OLD/$REDIS_INFO1_NEW/g" $SRC_PATH/alertcenter/config.json
sed -i -e "s/$REDIS_INFO2_OLD/$REDIS_INFO2_NEW/g" $SRC_PATH/alertcenter/config.json
sed -i -e "s/$REDIS_INFO3_OLD/$REDIS_INFO3_NEW/g" $SRC_PATH/alertcenter/config.json
##
sed -i -e "s/$REDIS_INFO0_OLD/$REDIS_INFO0_NEW/g" $SRC_PATH/marketprice/config.json
sed -i -e "s/$REDIS_INFO1_OLD/$REDIS_INFO1_NEW/g" $SRC_PATH/marketprice/config.json
sed -i -e "s/$REDIS_INFO2_OLD/$REDIS_INFO2_NEW/g" $SRC_PATH/marketprice/config.json
sed -i -e "s/$REDIS_INFO3_OLD/$REDIS_INFO3_NEW/g" $SRC_PATH/marketprice/config.json
#
# MySQL/MariaDB Server info
sed -i -e "s/$DB_INFO_HOST_OLD/$DB_INFO_HOST_NEW/g" $SRC_PATH/matchengine/config.json
sed -i -e "s/$DB_INFO_PORT_OLD/$DB_INFO_PORT_NEW/g" $SRC_PATH/matchengine/config.json
sed -i -e "s/$DB_INFO_USER_OLD/$DB_INFO_USER_NEW/g" $SRC_PATH/matchengine/config.json
sed -i -e "s/$DB_INFO_PASS_OLD/$DB_INFO_PASS_NEW/g" $SRC_PATH/matchengine/config.json
##
sed -i -e "s/$DB_INFO_HOST_OLD/$DB_INFO_HOST_NEW/g" $SRC_PATH/readhistory/config.json
sed -i -e "s/$DB_INFO_PORT_OLD/$DB_INFO_PORT_NEW/g" $SRC_PATH/readhistory/config.json
sed -i -e "s/$DB_INFO_USER_OLD/$DB_INFO_USER_NEW/g" $SRC_PATH/readhistory/config.json
sed -i -e "s/$DB_INFO_PASS_OLD/$DB_INFO_PASS_NEW/g" $SRC_PATH/readhistory/config.json



# restart_all.sh, stop_all.sh
# librdkafka
sed -i -e "s/$SRC_PATH_OLD/\//g" $SRC_PATH/restart_all.sh
sed -i -e "s/$SRC_PATH_OLD/\//g" $SRC_PATH/stop_all.sh



# Imports SQL schema
#  - if has an error, insert 'USE trade_history; or USE trade_log;' below 'CREATE database <trade_...>;'
#
# Edit <DB info> for 'init_trade_history.sh'
#
sed -i -e "s/$SCRIPT_DB_INFO_HOST_OLD/$SCRIPT_DB_INFO_HOST_NEW/g" $SRC_PATH/sql/init_trade_history.sh
sed -i -e "s/$SCRIPT_DB_INFO_PORT_OLD/$SCRIPT_DB_INFO_PORT_NEW/g" $SRC_PATH/sql/init_trade_history.sh
sed -i -e "s/$SCRIPT_DB_INFO_USER_OLD/$SCRIPT_DB_INFO_USER_NEW/g" $SRC_PATH/sql/init_trade_history.sh
sed -i -e "s/$SCRIPT_DB_INFO_PASS_OLD/$SCRIPT_DB_INFO_PASS_NEW/g" $SRC_PATH/sql/init_trade_history.sh
#
# Import
#cd $SRC_PATH/sql && mysql -h $_DB_INFO_HOST_VAL_NEW -u $_DB_INFO_USER_VAL_NEW --password="$_DB_INFO_PASS_VAL_NEW" -P $_DB_INFO_PORT_VAL_NEW < create_trade_history.sql
#cd $SRC_PATH/sql && mysql -h $_DB_INFO_HOST_VAL_NEW -u $_DB_INFO_USER_VAL_NEW --password="$_DB_INFO_PASS_VAL_NEW" -P $_DB_INFO_PORT_VAL_NEW < create_trade_log.sql
#
# Initialize
# DB info required
#cd $SRC_PATH/sql && init_trade_history.sh



