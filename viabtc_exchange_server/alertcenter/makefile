TARGET  := alertcenter.exe
#INCS = -I ../network -I ../utils
#LIBS = -L ../utils -lutils -L ../network -lnetwork -Wl,-Bstatic -lev -lhiredis -ljansson -lmpdec -lcurl -lssl -lcrypto -Wl,-Bdynamic -lm
INCS = -I ../network -I ../utils -I ../depends -I ../../librdkafka/src
LIBS = -L ../utils -lutils -L ../network -L ../depends/hiredis -L ../../librdkafka/src -lnetwork -Wl,-Bstatic -lev -lhiredis -ljansson -lmpdec -lcurl -lssl -lcrypto -Wl,-Bdynamic -lm
include ../makefile.inc
