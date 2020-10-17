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
❯ docker run --rm -it wolffaxn/docker-golang:1.15.3 go version
go version go1.15.3 linux/amd64
```

Run example

```
❯ docker run --rm -it -v "$(pwd)/example":/go -w /go wolffaxn/docker-golang:1.15.3 go run main.go
hello, world
```

Build executable for mac platform

```
❯ docker run --rm -it -v "$(pwd)/example":/go -w /go wolffaxn/docker-golang:1.15.3 /bin/sh -c "GOOS=darwin GOARCH=amd64 go build -o helloworld main.go"
❯ file example/helloworld
example/helloworld: Mach-O 64-bit executable x86_64
```

Build executable for linux platform

```
❯ docker run --rm -it -v "$(pwd)/example":/go -w /go wolffaxn/docker-golang:1.15.3 go build -o helloworld main.go
❯ file example/helloworld
example/helloworld: ELF 64-bit LSB executable, x86-64, version 1 (SYSV), statically linked, not stripped
```

or

```
❯ docker run --rm -it -v "$(pwd)/example":/go -w /go wolffaxn/docker-golang:1.15.3 /bin/sh -c "GOOS=linux GOARCH=amd64 go build -o helloworld main.go"
❯ file example/helloworld
example/helloworld: ELF 64-bit LSB executable, x86-64, version 1 (SYSV), statically linked, not stripped
```

Build executable for windows platform

```
❯ docker run --rm -it -v "$(pwd)/example":/go -w /go wolffaxn/docker-golang:1.15.3 /bin/sh -c "GOOS=windows GOARCH=amd64 go build -o helloworld main.go"
❯ file example/helloworld
example/helloworld: PE32+ executable (console) x86-64 (stripped to external PDB), for MS Windows
```

## Example

Build and run example

```
❯ cd example
❯ make
docker build -t wolffaxn/docker-golang-example .
[+] Building 0.6s (14/14) FINISHED
...
docker run --rm -it wolffaxn/docker-golang-example
hello, world
```

## License

Released under the MIT License. See [license](LICENSE.md) for details.
