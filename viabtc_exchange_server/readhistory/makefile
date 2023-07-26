TARGET  := readhistory.exe
#INCS = -I ../network -I ../utils
#LIBS = -L ../utils -lutils -L ../network -lnetwork -Wl,-Bstatic -lev -ljansson -lmpdec -lmysqlclient -lz -lhiredis -Wl,-Bdynamic -lm -lpthread -ldl
INCS = -I ../network -I ../utils -I ../depends -I ../../librdkafka/src
LIBS = -L ../utils -lutils -L ../network -L ../depends/hiredis -L ../../librdkafka/src -lnetwork -Wl,-Bstatic -lev -ljansson -lmpdec -lz -lhiredis -Wl,-Bdynamic -lm -lpthread -ldl -lmysqlclient 
include ../makefile.inc
