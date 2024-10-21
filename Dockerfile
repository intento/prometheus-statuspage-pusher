FROM golang:1.16 as builder

WORKDIR /src
COPY . .

ENV CGO_ENABLED=0

RUN go build -o prometheus-statuspage-pusher

FROM ubuntu:focal-20241011

COPY --from=builder /src/prometheus-statuspage-pusher /usr/bin/prometheus-statuspage-pusher
RUN apt-get update && apt install ca-certificates -y
ENTRYPOINT [ "/usr/bin/prometheus-statuspage-pusher" ]
