.PHONY: build
APPLICATION    := $(shell go list -m | cut -d '/' -f 3)
build:
	@echo "Building..."
	@git submodule init
	@bash ./crossbuilder/scripts/gen
