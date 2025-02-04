# This Makefile requires the following additional tools:
# - crossplane (https://crossplane.io/)
# - kcl        (https://www.kcl-lang.io/)
# - yq         (https://github.com/mikefarah/yq)
# - toml-cli   (https://github.com/diversable/toml-editor-cli)

# This Makefile is designed to fail if you have un-committed changed or
# untracked files in your repository. This is to help with the detection method
# used to determine which packages need to be built/pushed.
#
# The Makefile will also fail if you are pushing to the registry and the
# CONTAINER_REGISTRY environment variable is not set.
#
# If VERSION is not set, it will default to the latest tag and the short commit
# hash. This is useful for development builds.

.DEFAULT_GOAL	:= all
SHELL=/usr/bin/env bash
APPLICATION     := $(shell go list -m | cut -d '/' -f 3)
MODULE_ROOT     := $(shell pwd)
API_SOURCE_ROOT := $(shell sed -e '/^BASE_PATH/!d' -e "s/BASE_PATH='\(.*\)'/\1/" template/create.sh)

CONTAINER_REGISTRY ?= $(error CONTAINER_REGISTRY is not set. Run CONTAINER_REGISTRY=<registry>/<yourorg> make $(MAKECMDGOALS))
VERSION ?= $(call devversion)

define git_last_tag_or_root
$(shell git describe --tags --abbrev=0 2>/dev/null || git rev-list --max-parents=0 HEAD)
endef

define git_changes
$(shell git diff --name-only $(call git_last_tag_or_root)..HEAD)
endef

define git_has_changes
$(shell echo $(call git_changes) | tr " " "\n" | grep -c $(1))
endef

define git_changed_between
$(shell ( [ $(call git_has_changes, $(1)) -gt 0 ] && echo $(call git_changes) \
	| tr " " "\n" | grep $(1) | xargs dirname | sort | uniq ))
endef

define git_latest_tag
$(shell git describe --tags --abbrev=0 2>/dev/null || echo 0.0.1)
endef

define devversion
$(call git_latest_tag)-$(shell git rev-parse --short HEAD)
endef

define crossplane_package_version
$(shell basename $(1))$(2)$(VERSION)
endef

define kcl_package_get
$(shell tar -xf $(1) kcl.mod -O | sed -e '/^$$/,$$d;/$(2)/!d;s/.*"\(.*\)"/\1/')
endef

define kcl_module_name
$(call kcl_package_get,$(1),name)
endef

define kcl_module_version
$(call kcl_package_get,$(1),version)
endef

define set_kcl_module_version
$(shell sed -i 's/^version.*/version = "$(2)"/' $(1))
endef

define kcl_module_push
$(shell echo Pushing $(1) >&2; kcl mod push --tar_path $(1) $(2)/$(call \
	kcl_module_name,$(1)):$(call kcl_module_version,$(1)))
endef

define crossbuilder_clean
$(shell cd crossbuilder && git reset --hard HEAD)
endef

define crossbuilder_update
$(shell git submodule update --remote crossbuilder)
endef

define crossbuilder_reset
@echo cleaning up && ( \
	cd crossbuilder; \
	git checkout -- go.mod go.sum ; \
	go mod tidy ) && \
	go mod tidy
endef

define crossbuilder_build
@echo Building crossbuilder && ( cd crossbuilder; \
    rm go.mod go.sum ;\
	go mod tidy; \
    echo "building xrc-gen"; \
    go build -trimpath -o bin/xrc-gen -ldflags="-X main.kubeBuilderVersion=$( \
        git describe --tags --dirty --broken --always \
    )" cmd/xrc-gen/main.go; \
    echo "building xrd-gen"; \
    go build -trimpath -o bin/xrd-gen -ldflags="-X main.kubeBuilderVersion=$( \
        git describe --tags --dirty --broken --always \
    )" cmd/xrd-gen/main.go )
endef

.PHONY: has_unstaged_changes
has_unstaged_changes:
	@echo "Checking for unstaged changes..."
	@git diff-files --quiet || (echo "Unstaged changes found. Please commit or stash them." && exit 1)

.PHONY: has_untracked_changes
has_untracked_changes:
	@echo "Checking for untracked files..."
	@test $$(git ls-files --others --exclude-standard | wc -l) -eq 0 || ( \
		echo "Untracked files found. Please commit or stash them." && exit 1)

.PHONY: clean
clean: ## Clean build artifacts
	@echo "Cleaning build..."
	@rm -rf $(MODULE_ROOT)/build

# Build all crossplane compositions
.PHONY: build
build: clean ## Build all APIS
	@echo "Building..."
	@echo $(call crossbuilder_clean)
	@echo $(call crossbuilder_update)
	$(call crossbuilder_build)
	$(call crossbuilder_reset)
	@echo "Building crossplane compositions..."
	@crossbuilder/bin/xrc-gen

define _packagekcl
	$(foreach p, $(KCL_MODULES), $(call set_kcl_module_version,$(p)/kcl.mod,$(VERSION)))
	@for m in $(KCL_MODULES); do \
		echo "Checking for dependency changes in $$m ..."; \
		n=$$(sed -e '/^$$/,$$d;/name/!d;s/.*"\(.*\)"/\1/' $$m/kcl.mod); \
		for d in $(KCL_MODULES); do \
			if toml get $$d/kcl.mod dependencies | grep -q $$n; then \
				toml set $$d/kcl.mod dependencies.$$(grep $$n $$d/kcl.mod \
					| awk '{print $$1}').tag $(VERSION) > $$d/kcl.mod.new; \
				mv $$d/kcl.mod.new $$d/kcl.mod; \
				mname=$$(sed -e '/^$$/,$$d;/name/!d;s/.*"\(.*\)"/\1/' $$m/kcl.mod); \
				toml set $$d/kcl.mod.lock dependencies.$$(grep $$n $$d/kcl.mod \
					| awk '{print $$1}').version $(VERSION) > $$d/kcl.mod.lock.new; \
				mv $$d/kcl.mod.lock.new $$d/kcl.mod.lock; \
				toml set $$d/kcl.mod.lock dependencies.$$(grep $$n $$d/kcl.mod \
					| awk '{print $$1}').oci_tag $(VERSION) > $$d/kcl.mod.lock.new; \
				mv $$d/kcl.mod.lock.new $$d/kcl.mod.lock; \
				toml set $$d/kcl.mod.lock dependencies.$$(grep $$n $$d/kcl.mod \
					| awk '{print $$1}').full_name $${mname}_$(VERSION) > $$d/kcl.mod.lock.new; \
				mv $$d/kcl.mod.lock.new $$d/kcl.mod.lock; \
			fi; \
		done; \
	done
	@mkdir -p $(MODULE_ROOT)/build/kcl; \
	for module in $(KCL_MODULES); do \
		echo "Building $$module ..."; \
		cd $$module && kcl mod pkg --target $(MODULE_ROOT)/build/kcl; \
		cd $(MODULE_ROOT); \
	done
endef

define is_zero
$(if $(filter $(1),$(2)),,$(2))
endef

# Package all KCL modules that have changed since the last tag
.PHONY: package-kcl
package-kcl: clean ## Package all KCL modules
	$(eval KCL_MODULES := $(call git_changed_between, $(API_SOURCE_ROOT).\*/kcl.mod))
	$(eval COUNT := $(words $(KCL_MODULES)))
	$(if $(call is_zero(0, $(COUNT))),$(info No KCL modules found), $(call _packagekcl))
	@echo "Building $(COUNT) kcl packages..."

.PHONY: kcl
kcl: requires_cr package-kcl ## Package and push all KCL modules (REQUIRED: CONTAINER_REGISTRY)
	$(eval PACKAGES := $(shell find build/kcl -name '*.tar' -printf "%p " 2>/dev/null))
	$(eval REGISTRY := oci://$(CONTAINER_REGISTRY))

	$(if $(call is_zero 0, $(words $(PACKAGES))),\
		$(info No KCL packages found), \
		$(foreach p, $(PACKAGES), $(eval _ := $(call kcl_module_push, $(p), $(REGISTRY)))) \
	)

# Filters out all packages that do not have a crossplane.yaml file
.PHONY: package-crossplane
package-crossplane: build ## Package all crossplane packages
	$(eval XP_PACKAGES := $(call git_changed_between,^apis/.*/.*))
	$(eval PACKAGES := $(foreach p, $(XP_PACKAGES), \
		$(shell find $(p) -name 'crossplane.yaml' -printf "%h " 2>/dev/null)))

	$(eval COUNT := $(words $(PACKAGES)))
	$(eval OUTPUT := $(MODULE_ROOT)/build/crossplane)
	$(if $(call is_zero 0, $(words $(PACKAGES))), \
		$(info No crossplane packages found), \
		$(foreach p, $(PACKAGES), \
			$(shell mkdir -p $(OUTPUT); \
				yq -i "(.metadata.labels.\"pkg.crossplane.io/version\" = \"$(VERSION)\")" \
					apis/$$(basename $(p))/crossplane.yaml; \
				crossplane xpkg build -f $(p) \
				-o $(OUTPUT)/$(call crossplane_package_version,$(p),-).xpkg; \
				echo \(XP\) Packaged $(call crossplane_package_version,$(p),-) >&2) \
		))
	@echo "Building $(COUNT) crossplane packages..."

.PHONY: crossplane
crossplane: requires_cr package-crossplane ## Package and push all crossplane packages (REQUIRED: CONTAINER_REGISTRY)
	$(eval OUTPUT := $(MODULE_ROOT)/build/crossplane)
	$(eval REGISTRY := $(CONTAINER_REGISTRY))
	$(if $(call is_zero 0, $(words $(PACKAGES))), \
		$(info No crossplane packages found), \
		$(foreach p,$(PACKAGES), \
			$(shell crossplane xpkg push -f $(OUTPUT)/$(call \
				crossplane_package_version,$(p),-).xpkg \
				$(REGISTRY)/$(call crossplane_package_version,$(p),:); \
				echo Pushed $(REGISTRY)/$(call crossplane_package_version,$(p),:) >&2 \
			) \
	))

.PHONY: requires_cr
requires_cr:
	@echo Using container registry $(CONTAINER_REGISTRY)

.PHONY: test ## Run go tests
test:
	@echo "Running go tests..."
	@go test ./...

.PHONY: kcltest ## Run kcl tests on recently changed modules
kcltest:
	$(eval KCL_MODULES := $(call git_changed_between, $(API_SOURCE_ROOT).\*/kcl.mod))
	@echo "Running kcl tests..."
	@for p in $(KCL_MODULES); do \
		echo "Running tests for $$p ..."; \
		echo $$(pwd); \
		cd $(MODULE_ROOT)/$$p; \
		kcl test ./... \
		cd $(MODULE_ROOT); \
	done

.PHONY: create ## Create a new API module
create:
	@echo "Creating new API..."
	@template/create.sh

.PHONY: package
package: requires_cr clean has_unstaged_changes has_untracked_changes crossplane kcl ## Package and push all modules (REQUIRED: CONTAINER_REGISTRY)

.PHONY: all
all: requires_cr clean has_unstaged_changes has_untracked_changes test build package kcltest ## Build and package all modules (REQUIRED: CONTAINER_REGISTRY)

.PHONY: indocker
indocker: requires_cr ## Build in docker
	@echo "Building in docker..."
	@docker build . -t crossbuilder
	@docker run -it -e CONTAINER_REGISTRY=$(CONTAINER_REGISTRY) \
		-w /home/crossbuilder/src \
		-v $(shell pwd):/home/crossbuilder/src \
		-v ~/.docker:/home/crossbuilder/.docker -u $(shell id -u):$(shell id -g) \
		crossbuilder make all

.PHONY: help
help: ## Show this help message
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \
		\033[36m<target>\033[0m\n"} /^[a-zA-Z%\\\/_0-9-]+:.*?##/ \
		{ printf "  \033[36m%-20s\033[0m %s\n", $$1, $$2 } /^##@/ \
		{ printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)