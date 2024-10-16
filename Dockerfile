FROM golang:1.23.2 as builder
WORKDIR /app

RUN go mod init hi-go

COPY *.go ./

RUN CGO_ENABLED=0 GOOS=linux go build -o /hi-go

FROM gcr.io/distroless/base-debian11

WORKDIR /

COPY --from=builder /hi-go /hi-go

USER nonroot:nonroot
ENTRYPOINT ["/hi-go"]
