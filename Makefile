split-version = $(word $1,$(subst ., ,$2))

# docker image name
DOCKER_IMAGE = wolffaxn/golang

# base directory
BASE_DIR:=$(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
# get build date
BUILD_DATE := $(shell date -u +'%Y-%m-%dT%H:%M:%SZ')
# get the latest commit
GIT_COMMIT := $(shell git rev-parse --short HEAD)
# get remote origin url
GIT_URL := $(shell git config --get remote.origin.url)
# get version
VERSION := $(strip $(shell cat VERSION))
# split version into major and minor version
SUB_DIR := $(call split-version,1,$(VERSION)).$(call split-version,2,$(VERSION))

. PHONY: all
all: build-buster-slim build-buster-slim-musl

build-%:
	$(eval OS = $(basename $*.*))

	# build docker image
	docker build \
	--build-arg BUILD_DATE=$(BUILD_DATE) \
	--build-arg VCS_REF=$(GIT_COMMIT) \
	--build-arg VCS_URL=$(GIT_URL) \
	-t $(DOCKER_IMAGE):$(VERSION)-$(OS) ${BASE_DIR}/$(SUB_DIR)/$(OS)

	@echo Successfully built: $(DOCKER_IMAGE):$(VERSION)-$(OS)
	@echo
