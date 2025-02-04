ARG GO_VERSION=1
ARG TARGETOS=linux
ARG TARGETARCH=amd64

FROM rust:1-alpine3.21 as builder
RUN apk add --no-cache pcc-libs-dev musl-dev pkgconfig openssl-dev
RUN cargo install toml-cli

FROM --platform=${BUILDPLATFORM} golang:${GO_VERSION} AS image

ENV GOOS=${TARGETOS}
ENV GOARCH=${TARGETARCH}

RUN apt update
RUN apt install bash curl git make gcc
RUN apt clean autoclean autoremove -y
COPY --from=builder /usr/local/cargo/bin/toml /usr/local/bin/toml
RUN wget -q https://kcl-lang.io/script/install-cli.sh -O - | bash
RUN wget -q https://raw.githubusercontent.com/crossplane/crossplane/main/install.sh -O - | bash
RUN mv crossplane /usr/local/bin/crossplane

RUN addgroup crossbuilder --gid 1000 \
    && adduser --gid 1000 --uid 1000 crossbuilder
USER crossbuilder
