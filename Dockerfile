FROM golang:1.23 AS builder

ARG TARGETARCH

WORKDIR /app

COPY . .

# Build the binary for the target platform
RUN GOOS=linux GOARCH=${TARGETARCH} go build -v -o kubeplumber-niccheck ./main.go

FROM alpine:latest

WORKDIR /root/

COPY --from=builder /app/kubeplumber-niccheck .

ENTRYPOINT ["./kubeplumber-niccheck"]
