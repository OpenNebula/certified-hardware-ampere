SELF  := $(patsubst %/,%,$(dir $(abspath $(firstword $(MAKEFILE_LIST)))))

ENV_RUN      = hatch env run -e $(1) --
ENV_CSP_DEFAULT := $(shell hatch env find ampere-default)

ifdef ENV_CSP_DEFAULT
$(ENV_CSP_DEFAULT):
	hatch env create ampere-default
endif

.PHONY: submodule-requirements deployment validation specifics

submodule-requirements:
	$(MAKE) -C submodule-one-deploy requirements

# Explicitly expose these targets to the parent Makefile.
validation:
	$(MAKE) -C submodule-one-deploy-validation I=$(SELF)/inventory/ampere.yml $@

deployment: 
	$(MAKE) -C submodule-one-deploy I=$(SELF)/inventory/ampere.yml main

specifics: $(ENV_CSP_DEFAULT)
	cd $(SELF)/ && \
	$(call ENV_RUN,ampere-default) ansible-playbook $(SELF)/playbooks/ampere.yml
