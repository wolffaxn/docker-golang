FROM debian:buster-slim

ARG BUILD_DATE

ARG GO_VERSION
ENV GO_VERSION=${GO_VERSION:-1.15.2}

# metadata
LABEL maintainer="Alexander Wolff <wolffaxn@gmail.com>" \
  org.label-schema.build-date=${BUILD_DATE}

# dependencies
RUN set -eux \
  && DEBIAN_FRONTEND=noninteractive \
  && apt-get update \
  && apt-get install -y --no-install-recommends \
  build-essential \
  ca-certificates \
  curl \
  git \
  locales \
  && rm -Rf /var/lib/apt/lists/* \
  && apt-get clean

# golang
RUN set -ex \
  && locale-gen en_US.UTF-8 \
  && curl -Lso /tmp/go.tar.gz https://golang.org/dl/go${GO_VERSION}.linux-amd64.tar.gz \
  && tar -xvzf /tmp/go.tar.gz -C /usr/local \
  && rm -rf /tmp/*

ENV PATH $PATH:/usr/local/go/bin

ENTRYPOINT ["/usr/local/go/bin/go"]
CMD ["version"]
