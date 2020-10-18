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
ENV GO_VERSION=${GO_VERSION:-1.15.3}
ARG GO_SHA256
ENV GO_SHA256=${JAVA_SHA256:-010a88df924a81ec21b293b5da8f9b11c176d27c0ee3962dc1738d2352d3c02d}

ARG MUSL_VERSION
ENV MUSL_VERSION=${MUSL_VERSION:-1.2.1}

ENV GOPATH /go
ENV PATH $GOPATH/bin:/usr/local/go/bin:/usr/local/musl/bin:$PATH

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
  # musl
  curl -Lso /tmp/musl.tar.gz https://musl.libc.org/releases/musl-${MUSL_VERSION}.tar.gz; \
  tar -xvzf /tmp/musl.tar.gz -C /tmp; \
  cd /tmp/musl-${MUSL_VERSION}; \
  ./configure; \
  make; \
  make install; \
  rm -rf /tmp/*; \
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