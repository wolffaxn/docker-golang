# docker-golang

[![MIT licensed](https://img.shields.io/badge/license-MIT-blue.svg)](https://opensource.org/licenses/MIT)
[![GitHub last commit (branch)](https://img.shields.io/github/last-commit/wolffaxn/docker-golang/master.svg)](https://github.com/wolffaxn/docker-golang)

> Docker image for running golang.

## Build

Run this command to build an image.

```
make
```

To enable BuildKit build set the DOCKER_BUILDKIT=1 environment variable when invoking the docker build command,
such as:

```
export DOCKER_BUILDKIT=1
make
```

## Run

```
❯ docker run --rm -it wolffaxn/docker-golang:0.9.0
go version go1.15.2 linux/amd64

```

## License

Released under the MIT License. See [license](LICENSE.md) for details.
