TOPTARGETS := all clean

EXECUTABLES = \
	moxie-none-moxiebox-gcc \
	moxie-none-moxiebox-gprof \
	moxie-none-moxiebox-gdb
CHECK := $(foreach exec,$(EXECUTABLES),\
	$(if $(shell PATH=$(PATH) which $(exec)),some string,$(error "No $(exec) in PATH)))

SUBDIRS := src runtime tests
$(TOPTARGETS): $(SUBDIRS)
$(SUBDIRS):
	$(MAKE) -C $@ $(MAKECMDGOALS)

.PHONY: $(TOPTARGETS) $(SUBDIRS)

check:
	$(MAKE) -C tests check
