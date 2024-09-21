#!/usr/env/bin make

MAINIMAGE ?= $(REGISTRY)/$(PROJECTID)/$(REPO)/$(shell basename $(CURDIR))-main
MAINVERSION ?= latest

SIDECARIMAGE ?= $(REGISTRY)/$(PROJECTID)/$(REPO)/$(shell basename $(CURDIR))-sidecar
SIDECARVERSION ?= latest

# Build & push main container
.PHONY: build-main
build-main:
	@echo "Building main container"
	docker buildx build --platform linux/amd64 -t $(MAINIMAGE):$(MAINVERSION) . --no-cache --push

# Build & push sidecar container
.PHONY: build-sidecar
build-sidecar:
	@echo "Building sidecar container"
	cd sidecar && docker buildx build --platform linux/amd64 -t $(SIDECARIMAGE):$(SIDECARVERSION) . --no-cache --push
