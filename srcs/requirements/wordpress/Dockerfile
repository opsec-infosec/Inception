FROM debian:buster

ARG WP_ADMIN_NAME
ARG WP_ADMIN_PW

USER root

ENV APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE=DontWarn
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update --no-install-recommends -y
RUN apt-get install --no-install-recommends -y \
	dialog \
	wget \
	ca-certificates \
	php7.3-fpm \
	curl \
	php-mysqli \
	mariadb-client \
	&& apt-get clean autoclean \
    && apt-get autoremove --yes \
    && rm -rf /var/lib/{apt,dpkg,cache,log}

RUN mkdir -p /var/run/php && mkdir -p /var/www/html
RUN wget https://wordpress.org/latest.tar.gz
RUN tar -xvzf latest.tar.gz \
	&& mv ./wordpress/* /var/www/html \
	&& rm latest.tar.gz && rm -rf ./wordpress

RUN curl -o /usr/local/bin/wp https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
	&& chmod a+x /usr/local/bin/wp

COPY ./conf/php-fpm-wp-pool.conf /etc/php/7.3/fpm/pool.d/wp-pool.conf
COPY ./conf/wp-config.php.conf /root/wp-config.php.conf
COPY ./conf/wp-config-redis.php.conf /root/wp-config-redis.php.conf
COPY ./conf/static.html /root/static.html
COPY ./conf/init.sh /root/init.sh

RUN mkdir -p /var/www/html/adminer/ && wget https://www.adminer.org/latest.php -O /root/index.php
RUN mkdir -p /var/www/html/showcase/

RUN chmod u+x /root/init.sh

ENV DEBIAN_FRONTEND=dialog

LABEL maintainer="Dale Furneaux <dfurneaux@student.42abudhabi.ae>" \
      version="1.0.0" \
	  desc="Wordpress, php-fpm"
