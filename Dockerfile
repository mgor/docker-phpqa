FROM debian:stable

MAINTAINER Mikael Göransson <github@mgor.se>

RUN export DEBIAN_FRONTEND noninteractive; \
    apt-get update; \
    apt-get install -y php-cli \
        php-codesniffer \
        phpmd; \
    rm -rf /var/lib/apt/lists/*
