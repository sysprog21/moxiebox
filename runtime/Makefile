TARGET = ../lib/libsandboxrt.a
CFLAGS += -g \
	-Os -pipe \
	-ffunction-sections -fdata-sections

all: $(TARGET)

OBJS = \
	crt0.o \
	memchr.o \
	memcmp.o \
	memcpy.o \
	memmap.o \
	memset.o \
	setreturn.o \
	sha256.o \
	strchr.o \
	strcmp.o \
	strcpy.o \
	strlen.o \
	strncpy.o \
	strstr.o \
	sys-_exit.o \
	sys-mmap.o

deps := $(OBJS:%.o=.%.o.d)

$(TARGET): $(OBJS)
	mkdir -p ../lib
	$(MOX_AR) rvs $(TARGET) $(OBJS)
	cp -f crt0.o ../lib

%.o: %.c
	$(MOX_CC) $(CFLAGS) -c -o $@ -MMD -MF .$@.d $<

%.o: %.S
	$(MOX_AS) -o $@ $<

clean:
	$(RM) $(OBJS) $(TARGET) $(deps)

# Formal verification
CBMCH = $(shell cbmc --help)
CBMCFLAGS = \
	--unwind 8 --partial-loops --bounds-check --pointer-check \
	--div-by-zero-check --signed-overflow-check

verify: sha256.c sha256_test.c
	cbmc $? -DSELF_TEST $(CBMCFLAGS) $(findstring --memory-leak-check,$(CBMCH))

-include $(deps)
-include ../config.mk
