FROM debian:buster-slim AS base

ENV DEBIAN_FRONTEND=noninteractive
RUN set -eux; \
  apt-get update -qq; \
  apt-get install -qq --no-install-recommends \
  # build-essential without dpkg-dev (see https://packages.debian.org/stable/devel/build-essential)
  g++ \
  gcc \
  libc6-dev \
  make \
  #
  ca-certificates \
  ; \
  rm -Rf /var/lib/apt/lists/*

FROM base AS builder

ARG GO_VERSION
ENV GO_VERSION=${GO_VERSION:-1.15.5}
ARG GO_SHA256
ENV GO_SHA256=${GO_SHA256:-9a58494e8da722c3aef248c9227b0e9c528c7318309827780f16220998180a0d}

ENV GOPATH /go
ENV PATH $GOPATH/bin:/usr/local/go/bin:$PATH

ENV DEBIAN_FRONTEND=noninteractive
RUN set -eux; \
  apt-get update -qq; \
  apt-get install -qq --no-install-recommends \
  curl \
  ; \
  # golang
  curl -Lso /tmp/go.tar.gz https://golang.org/dl/go${GO_VERSION}.linux-amd64.tar.gz; \
  echo "${GO_SHA256} /tmp/go.tar.gz" | sha256sum -c -; \
  tar -xvzf /tmp/go.tar.gz -C /usr/local; \
  rm -rf /tmp/*; \
  mkdir -p "$GOPATH/bin" "$GOPATH/pkg" "$GOPATH/src"; \
  chmod -R 777 "$GOPATH"; \
  # cleanup
  apt-get purge --auto-remove -y curl; \
  apt-get clean; \
  rm -Rf /var/lib/apt/lists/*

WORKDIR $GOPATH

FROM builder

ARG BUILD_DATE
ARG VCS_REF
ARG VCS_URL

# metadata
LABEL maintainer="Alexander Wolff <wolffaxn@gmail.com>" \
  org.label-schema.build-date=${BUILD_DATE} \
  org.label-schema.docker.dockerfile="/Dockerfile" \
  org.label-schema.vcs-ref=${VCS_REF} \
  org.label-schema.vcs-url=${VCS_URL}
