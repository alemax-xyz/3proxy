FROM clover/base AS base

RUN groupadd \
        --gid 50 \
        --system \
        proxy \
 && useradd \
        --home-dir /var/lib/openvpn \
        --no-create-home \
        --system \
        --shell /bin/false \
        --uid 50 \
        --gid 50 \
        proxy

FROM library/debian:stable-slim AS build

ENV LANG=C.UTF-8

RUN export DEBIAN_FRONTEND=noninteractive \
 && apt-get update \
 && apt-get install -y \
        apt-utils

RUN export DEBIAN_FRONTEND=noninteractive \
 && apt-get install -y \
        wget \
        gnupg

RUN mkdir -p /build/image
WORKDIR /build

#RUN test "$(uname -m)" = "armv7l" \
# && wget https://github.com/3proxy/3proxy/releases/download/0.9.5/3proxy-0.9.5.arm.deb \
# || wget https://github.com/3proxy/3proxy/releases/download/0.9.5/3proxy-0.9.5.$(uname -m).deb

RUN wget --no-check-certificate https://github.com/3proxy/3proxy/releases/download/0.9.5/3proxy-0.9.5.$(uname -m | sed "s,armv7l,arm,").deb

RUN for file in *.deb; do dpkg-deb -x ${file} image/; done

WORKDIR /build/image
RUN mkdir -p \
        run/3proxy \
        usr/libexec \
 && mv usr/local/3proxy/libexec/* usr/libexec/ \
 && rm -rf \
        etc/3proxy/* \
        etc/init.d \
        lib/systemd \
        usr/share \
        usr/local \
        var/run \
 && touch etc/3proxy/3proxy.cfg

COPY --from=base /etc/group /etc/gshadow /etc/passwd /etc/shadow etc/
COPY init/ etc/init/

FROM clover/common

WORKDIR /
COPY --from=build /build/image /
