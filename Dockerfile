FROM debian:buster-slim

ARG BUILD_DATE
ARG VCS_REF
ARG VCS_URL

ARG GO_VERSION
ENV GO_VERSION=${GO_VERSION:-1.15.2}
ARG GO_SHA256
ENV GO_SHA256 ${JAVA_SHA256:-b49fda1ca29a1946d6bb2a5a6982cf07ccd2aba849289508ee0f9918f6bb4552}

# metadata
LABEL maintainer="Alexander Wolff <wolffaxn@gmail.com>" \
  org.label-schema.build-date=${BUILD_DATE} \
  org.label-schema.docker.dockerfile="/Dockerfile" \
  org.label-schema.vcs-ref=${VCS_REF} \
  org.label-schema.vcs-url=${VCS_URL}

# dependencies
ENV DEBIAN_FRONTEND=noninteractive
RUN set -eux \
  && apt-get update -qq \
  && apt-get install -qq --no-install-recommends \
  build-essential \
  ca-certificates \
  curl \
  git \
  locales \
  && rm -Rf /var/lib/apt/lists/* \
  && apt-get clean

# golang
RUN set -eux \
  && locale-gen en_US.UTF-8 \
  && curl -Lso /tmp/go.tar.gz https://golang.org/dl/go${GO_VERSION}.linux-amd64.tar.gz \
  && echo "${GO_SHA256} /tmp/go.tar.gz" | sha256sum -c - \
  && tar -xvzf /tmp/go.tar.gz -C /usr/local \
  && rm -rf /tmp/*

ENV GOPATH /go
ENV PATH $GOPATH/bin:/usr/local/go/bin:$PATH

RUN set -eux \
  && mkdir -p "$GOPATH/bin" "$GOPATH/pkg" "$GOPATH/src" \
  && chmod -R 777 "$GOPATH"

WORKDIR $GOPATH
