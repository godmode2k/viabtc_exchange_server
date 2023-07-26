TARGET  := libutils.a
#INCS = -I ../network
INCS = -I ../network -I ../depends -I ../../librdkafka/src
include ../makefile.inc
$(TARGET) : $(OBJS)
	ar -rs $@ $^
