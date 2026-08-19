FROM golang:1.24-alpine AS builder

WORKDIR /app

COPY main.go .

RUN CGO_ENABLED=0 GOOS=linux go build -o otus-app main.go


FROM alpine:3.22

WORKDIR /app

COPY --from=builder /app/otus-app .

ENV PORT=80
ENV ADMIN_USER=user
ENV ADMIN_PASSWORD=spassword

EXPOSE 80

CMD ["./otus-app"]
