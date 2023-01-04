FROM debian:buster

USER root

ENV APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE=DontWarn
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update --no-install-recommends -y
RUN apt-get install --no-install-recommends -y \
	redis \
    dialog \
	&& apt-get clean autoclean \
    && apt-get autoremove --yes \
    && rm -rf /var/lib/{apt,dpkg,cache,log}

RUN mkdir -p /var/run/redis/redis-server.pid

COPY ./conf/redis.conf /etc/redis/redis.conf

ENV DEBIAN_FRONTEND=dialog

ENTRYPOINT [ "redis-server" , "/etc/redis/redis.conf"]

LABEL maintainer="Dale Furneaux <dfurneaux@student.42abudhabi.ae>" \
      version="1.0.0" \
	  desc="FTP Server"
