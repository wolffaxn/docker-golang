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

Show go version

```
❯ docker run --rm -it wolffaxn/docker-golang:0.9.0 go version
go version go1.15.2 linux/amd64
```

Run test example

```
❯ docker run --rm -it -v "$(pwd)/test":/go -w /go wolffaxn/docker-golang:0.9.0 go run main.go
hello, world
```

Build and run test example (works only on linux/amd64)

```
❯ docker run --rm -it -v "$(pwd)/test":/go -w /go wolffaxn/docker-golang:0.9.0 go build -o helloworld main.go
❯ cd test && ./helloworld
hello, world
```

## Test

```
❯ cd test && make
docker build -t wolffaxn/docker-golang-test .
[+] Building 2.3s (14/14) FINISHED
...
docker run --rm -it wolffaxn/docker-golang-test
hello, world
```

## License

Released under the MIT License. See [license](LICENSE.md) for details.
