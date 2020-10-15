FROM debian:buster-slim

ARG BUILD_DATE
ARG VCS_REF
ARG VCS_URL

ARG GO_VERSION
ENV GO_VERSION=${GO_VERSION:-1.15.3}
ARG GO_SHA256
ENV GO_SHA256 ${JAVA_SHA256:-010a88df924a81ec21b293b5da8f9b11c176d27c0ee3962dc1738d2352d3c02d}

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
