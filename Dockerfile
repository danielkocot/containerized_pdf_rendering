FROM ubuntu:latest

ENV DEBIAN_FRONTEND=noninteractive
RUN apt update && apt install -y gnupg openjdk-13-jre-headless inkscape

COPY files/speedata.list /etc/apt/sources.list.d
COPY files/gpgkey-speedata.txt /tmp/gpgkey-speedata.txt
RUN  APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE=1 apt-key add /tmp/gpgkey-speedata.txt

RUN apt update
RUN apt install -y speedata-publisher

WORKDIR /server
ADD files/publisher.cfg /server

ENTRYPOINT [ "sp", "server" ]