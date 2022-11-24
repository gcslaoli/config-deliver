FROM golang AS builder
ARG TARGETARCH
RUN echo "Building for $TARGETARCH"
WORKDIR /build
RUN go env -w GO111MODULE=on
RUN go env -w GOPROXY=https://goproxy.cn,direct
COPY . .
RUN go build -o config-deliver-client

FROM ubuntu
WORKDIR /app
ENV TZ                      Asia/Shanghai
RUN apt-get update && apt-get install -y tzdata
COPY --from=builder /build/config-deliver-client /app/config-deliver-client
RUN chmod +x /app/config-deliver-client
CMD ./config-deliver-client