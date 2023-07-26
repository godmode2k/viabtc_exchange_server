#!/bin/bash



# accesshttp/
killall -s SIGQUIT accesshttp.exe
sleep 1
#./accesshttp.exe config.json
./accesshttp/accesshttp.exe ./accesshttp/config.json
echo
echo


# accessws/
killall -s SIGQUIT accessws.exe
sleep 1
#./accessws.exe config.json
./accessws/accessws.exe ./accessws/config.json
echo
echo


# alertcenter/
killall -s SIGQUIT alertcenter.exe
sleep 1
#./alertcenter.exe config.json
./alertcenter/alertcenter.exe ./alertcenter/config.json
echo
echo


# matchengine/
killall -s SIGQUIT matchengine.exe
sleep 1
#LD_PRELOAD=/mnt/data/viabtc/librdkafka/src/librdkafka.so ./matchengine.exe config.json
LD_PRELOAD=../librdkafka/src/librdkafka.so ./matchengine/matchengine.exe ./matchengine/config.json
echo
echo


# readhistory/
killall -s SIGQUIT readhistory.exe
sleep 1
#./readhistory.exe config.json
./readhistory/readhistory.exe ./readhistory/config.json
echo
echo


# marketprice/
killall -s SIGQUIT marketprice.exe
sleep 1
#./marketprice.exe config.json
./marketprice/marketprice.exe ./marketprice/config.json
echo
echo



