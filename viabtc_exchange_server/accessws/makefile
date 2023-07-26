TARGET  := accessws.exe
#INCS = -I ../network -I ../utils
#LIBS = -L ../utils -lutils -L ../network -lnetwork -Wl,-Bstatic -lev -ljansson -lmpdec -lrdkafka -lz -lssl -lcrypto -lhiredis -lcurl -Wl,-Bdynamic -lm -lpthread -ldl
INCS = -I ../network -I ../utils -I ../depends -I ../../librdkafka/src
LIBS = -L ../utils -lutils -L ../network -L ../depends/hiredis -L ../../librdkafka/src -lnetwork -Wl,-Bstatic -lev -ljansson -lmpdec -lrdkafka -lz -llz4 -lssl -lcrypto -lhiredis  -Wl,-Bdynamic -lm -lpthread -ldl -lcurl
include ../makefile.inc
