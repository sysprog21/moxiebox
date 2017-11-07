TOPTARGETS := all clean

include config.mk
EXECUTABLES = \
	$(MOX_CC) \
	$(MOX_AS) \
	$(MOX_AR)
CHECK := $(foreach exec,$(EXECUTABLES),\
	$(if $(shell PATH=$(PATH) which $(exec)),some string,$(error "No $(exec) in PATH)))

SUBDIRS := src runtime tests
$(TOPTARGETS): $(SUBDIRS)
$(SUBDIRS):
	$(MAKE) -C $@ $(MAKECMDGOALS)

.PHONY: $(TOPTARGETS) $(SUBDIRS)

check:
	$(MAKE) -C tests check
