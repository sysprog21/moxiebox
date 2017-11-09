TOPTARGETS := all clean

include config.mk
EXECUTABLES = \
	$(MOX_CC) \
	$(MOX_AS) \
	$(MOX_AR)
CHECK := $(foreach exec,$(EXECUTABLES),\
	$(if $(shell PATH=$(PATH) which $(exec)),some string,$(error "No $(exec) in PATH)))

GIT_HOOKS := .git/hooks/applied

SUBDIRS := src runtime tests
$(TOPTARGETS): $(GIT_HOOKS) $(SUBDIRS)
$(SUBDIRS):
	$(MAKE) -C $@ $(MAKECMDGOALS)

$(GIT_HOOKS):
	@scripts/install-git-hooks
	@echo

.PHONY: $(TOPTARGETS) $(SUBDIRS)

check:
	$(MAKE) -C tests check
