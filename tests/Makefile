top_srcdir = ..

CFLAGS = \
	-I$(top_srcdir)/runtime \
	-Wall \
	-Os -g -pipe \
	-fno-stack-protector \
	-ffunction-sections -fdata-sections \
	-fno-asynchronous-unwind-tables

LDFLAGS = \
	--sysroot=`pwd`/.. \
	-Wl,--gc-sections \
	-Wl,--as-needed

TESTS = \
	basic \
	exit0 \
	exit1 \
	rtlib \
	sha256

all: $(TESTS)

%: %.c
	$(MOX_CC) $(CFLAGS) -c $<
	$(MOX_CC) $(LDFLAGS) -o $@ $@.o

PASS_COLOR = \e[32;01m
NO_COLOR = \e[0m

UNAME_S := $(shell uname -s)
ifeq ($(UNAME_S),Darwin)
	PRINTF = printf
else
	PRINTF = env printf
endif

check: $(TESTS)
	@for t in $(TESTS); do \
		$(MOX_SIZE) $$t; \
		./run-$$t.sh && \
		$(PRINTF) "\t$(PASS_COLOR)[ $$t ]$(NO_COLOR)\n\n"; \
	done

clean:
	$(RM) *.o $(TESTS)

-include ../config.mk
