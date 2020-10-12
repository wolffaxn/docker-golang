FROM debian:buster-slim

ARG BUILD_DATE
ARG VCS_REF
ARG VCS_URL

ARG GO_VERSION
ENV GO_VERSION=${GO_VERSION:-1.15.2}

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
  && tar -xvzf /tmp/go.tar.gz -C /usr/local \
  && rm -rf /tmp/*

ENV PATH $PATH:/usr/local/go/bin

ENTRYPOINT ["/usr/local/go/bin/go"]
CMD ["version"]
