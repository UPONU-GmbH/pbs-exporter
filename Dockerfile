FROM golang:latest as build


WORKDIR /src
COPY . .
RUN go mod download
RUN go build -o /pbs-exporter

FROM ubuntu:22.04

RUN apt-get update && apt-get upgrade -y && \
    rm -rf /var/lib/apt/lists/*

COPY --from=build /pbs-exporter /usr/local/bin/pbs-exporter

ENTRYPOINT ["/usr/local/bin/pbs-exporter"]

