#!/bin/bash



# accesshttp/
killall -s SIGQUIT accesshttp.exe
#sleep 1
#./accesshttp.exe config.json


# accessws/
killall -s SIGQUIT accessws.exe
#sleep 1
#./accessws.exe config.json


# alertcenter/
killall -s SIGQUIT alertcenter.exe
#sleep 1
#./alertcenter.exe config.json


# marketprice/
killall -s SIGQUIT marketprice.exe
#sleep 1
#./marketprice.exe config.json


# matchengine/
killall -s SIGQUIT matchengine.exe
#sleep 1
#LD_PRELOAD=/mnt/data/viabtc/librdkafka/src/librdkafka.so ./matchengine.exe config.json


# readhistory/
killall -s SIGQUIT readhistory.exe
#sleep 1
#./readhistory.exe config.json



