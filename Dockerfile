FROM golang:latest
ENV GO111MODULE=on
WORKDIR /module
COPY . /module/
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 \
  go build -a -tags netgo \
    -ldflags '-w -extldflags "-static"' \
    -o bar

FROM scratch
COPY --from=0 /module/bar .
ENTRYPOINT ["/bar"]
