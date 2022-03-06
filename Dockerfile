FROM golang:1.17-alpine AS build
WORKDIR /httpserver/
ENV CGO_ENABLED=0
ENV GO111MODULE=on
ENV GOPROXY=https://goproxy.cn,direct
COPY ./ /httpserver
RUN GOOS=linux go build -installsuffix cgo -o httpserver main.go


FROM busybox
ENV ENV local
EXPOSE 8090
COPY --from=build /httpserver /
ENTRYPOINT ["/httpserver"]