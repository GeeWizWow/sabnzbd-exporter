FROM golang:1.21.6 AS builder
WORKDIR /go/src/github.com/geewizwow/sabnzbd-exporter
COPY go.mod .
COPY go.sum .
RUN go mod download
COPY . .
ENV CGO_ENABLED=0
RUN go build -tags timetzdata -o exporter .

FROM alpine:latest
COPY --from=builder /go/src/github.com/geewizwow/sabnzbd-exporter/exporter .
CMD ["./exporter"]
