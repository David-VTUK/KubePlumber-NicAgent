FROM golang:1.23 AS builder

ARG TARGETARCH

WORKDIR /app

COPY . .

# Build the binary for the target platform
RUN GOOS=linux GOARCH=${TARGETARCH} CGO_ENABLED=0 go build -v -o kubeplumber-niccheck ./main.go

FROM golang:1.23-alpine3.21

WORKDIR /root/

COPY --from=builder /app/kubeplumber-niccheck .

ENTRYPOINT ["./kubeplumber-niccheck"]
