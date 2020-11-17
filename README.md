# docker-golang

[![MIT licensed](https://img.shields.io/badge/license-MIT-blue.svg)](https://opensource.org/licenses/MIT)
[![GitHub last commit (branch)](https://img.shields.io/github/last-commit/wolffaxn/docker-golang/master.svg)](https://github.com/wolffaxn/docker-golang)
[![Docker Pulls](https://img.shields.io/docker/pulls/wolffaxn/golang.svg)](https://hub.docker.com/r/wolffaxn/golang)
[![Docker Stars](https://img.shields.io/docker/stars/wolffaxn/golang.svg)](https://hub.docker.com/r/wolffaxn/golang)

> Docker image with golang installed.

# Setup

You'll need `docker` on your machine, as well as the `git` command.

Start a shell and clone this repository.

```
git clone https://github.com/wolffaxn/docker-golang.git
cd docker-golang
```

Start docker if not already running.

```
docker-machine start default
eval $(docker-machine env)
```

# Build and run all images using the docker command

## Set environment variables

To enable BuildKit build set the DOCKER_BUILDKIT=1 environment variable when invoking the docker build command.

```
export DOCKER_BUILDKIT=1
```

## Build (using docker command)

To build the `buster-slim` image, run the following command.

```
docker build . -t wolffaxn/golang:1.15.5-buster-slim 1.15/buster-slim
```

To build the `buster-slim-musl` image, run the following command.

```
docker build . -t wolffaxn/golang:1.15.5-buster-slim-musl 1.15/buster-slim-musl
```

## Build (using Makefile)

Run this command to build all docker images.

```
make
```

## Run (using docker command)

Now run the new image and show `go` version.

```
❯ docker run --rm -it wolffaxn/golang:1.15.5-buster-slim go version
go version go1.15.5 linux/amd64
```

and

```
❯ docker run --rm -it wolffaxn/golang:1.15.5-buster-slim-musl go version
go version go1.15.5 linux/amd64
```

Run the following command to show the `musl-gcc` version

```
❯ docker run --rm -it wolffaxn/golang:1.15.5-buster-slim-musl musl-gcc --version
gcc (Debian 8.3.0-6) 8.3.0
Copyright (C) 2018 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
```

## Build executables for macos, linux and windows

Build executable for mac platform

```
❯ docker run --rm -it -v "$(pwd)/example":/example -w /example wolffaxn/golang:1.15.5-buster-slim /bin/sh -c "GOOS=darwin GOARCH=amd64 go build -o helloworld main.go"
❯ file example/helloworld
example/helloworld: Mach-O 64-bit executable x86_64
```

Build executable for linux platform

```
❯ docker run --rm -it -v "$(pwd)/example":/example -w /example wolffaxn/golang:1.15.5-buster-slim /bin/sh -c "GOOS=linux GOARCH=amd64 go build -o helloworld main.go"
❯ file example/helloworld
example/helloworld: ELF 64-bit LSB executable, x86-64, version 1 (SYSV), statically linked, not stripped
```

Build executable for windows platform

```
❯ docker run --rm -it -v "$(pwd)/example":/example -w /example wolffaxn/golang:1.15.5-buster-slim /bin/sh -c "GOOS=windows GOARCH=amd64 go build -o helloworld main.go"
❯ file example/helloworld
example/helloworld: PE32+ executable (console) x86-64 (stripped to external PDB), for MS Windows
```

# Test

## Run 'helloworld' example

Type the following command to run the `helloworld` example.

```
❯ docker run --rm -it -v "$(pwd)/example":/example -w /example wolffaxn/golang:1.15.5-buster-slim go run main.go
hello, world
```

and

```
❯ docker run --rm -it -v "$(pwd)/example":/example -w /example wolffaxn/golang:1.15.5-buster-slim-musl go run main.go
hello, world
```

## Running the unit tests

```
❯ docker run --rm -it -v "$(pwd)/example":/example -w /example wolffaxn/golang:1.15.5-buster-slim go test
go: downloading github.com/stretchr/testify v1.6.1
go: downloading github.com/davecgh/go-spew v1.1.0
go: downloading gopkg.in/yaml.v3 v3.0.0-20200313102051-9f266ea9e77c
go: downloading github.com/pmezard/go-difflib v1.0.0
hello, world
PASS
ok  	github.com/wolffaxn/golang-example	0.005s

```

## License

Released under the MIT License. See [license](LICENSE.md) for details.
