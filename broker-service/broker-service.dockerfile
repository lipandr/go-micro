# base go image
FROM golang:1.23.0-alpine as builder

RUN mkdir /app

COPY . /app

WORKDIR /app

RUN CGO_ENABLED=0 GOOS=linux go build -o brokerApp ./cmd/api

RUN chmod +x /app/brokerApp

# build a tiny docker image
FROM alpine:latest

RUN mkdir /app

COPY --from=builder /app/brokerApp /app

CMD ["app/brokerApp"]