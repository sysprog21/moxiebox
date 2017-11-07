-include ../config.mk
-include ../config-local.mk

EXEC = sandbox

CXXFLAGS += -Os -std=gnu++0x
LDFLAGS += -lelf

OBJS = \
	util.o \
	elf.o \
	machine.o \
	moxie.o \
	sandbox.o
deps := $(OBJS:%.o=.%.o.d)

$(EXEC): $(OBJS)
	$(CXX) $(LDFLAGS) -o $@ $^ $(LDFLAGS)

%.o: %.cc
	$(CXX) $(CXXFLAGS) -c -o $@ -MMD -MF .$@.d $<

clean:
	$(RM) $(EXEC) $(OBJS) $(deps)

-include $(deps)
