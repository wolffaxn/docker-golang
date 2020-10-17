FROM wolffaxn/docker-golang:1.15.3 AS builder

WORKDIR /go
COPY . /go
RUN go build -o helloworld main.go

FROM alpine:latest

RUN apk --no-cache add ca-certificates

WORKDIR /opt
COPY --from=builder /go/helloworld .
CMD ["./helloworld"]
