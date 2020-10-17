.PHONY: default
default: test

DOCKER_IMAGE ?= wolffaxn/docker-golang-example

.PHONY: test
test: docker-build docker-run

.PHONY: docker-build
docker-build:
	docker build -t $(DOCKER_IMAGE) .

.PHONY: docker-run
docker-run:
	docker run --rm -it $(DOCKER_IMAGE)
