FROM debian:buster

ARG MARIA_ROOT_PASSWORD
ARG MARIA_USER
ARG MARIA_USER_PASSWORD
ARG MARIA_DB

USER root

ENV APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE=DontWarn
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update --no-install-recommends -y
RUN apt-get install --no-install-recommends -y \
	dialog \
	mariadb-server \
	mariadb-client \
	&& apt-get clean autoclean \
    && apt-get autoremove --yes \
    && rm -rf /var/lib/{apt,dpkg,cache,log}

COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d

RUN chown -R root:root /var/lib/mysql

RUN service mysql start && mysql -e "CREATE DATABASE IF NOT EXISTS \`${MARIA_DB}\`; \
	CREATE USER IF NOT EXISTS \`${MARIA_USER}\`@'%' IDENTIFIED BY '${MARIA_USER_PASSWORD}'; \
	GRANT ALL PRIVILEGES ON \`${MARIA_DB}\`.* TO \`${MARIA_USER}\`@'%'; \
	ALTER USER 'root'@'localhost' IDENTIFIED BY '${MARIA_ROOT_PASSWORD}'; \
	CREATE USER IF NOT EXISTS 'root'@'%' IDENTIFIED BY '${MARIA_ROOT_PASSWORD}'; \
	GRANT ALL PRIVILEGES on *.* TO 'root'@'%' WITH GRANT OPTION; \
	FLUSH PRIVILEGES;"

ENV DEBIAN_FRONTEND=dialog

ENTRYPOINT [ "mysqld_safe" , "--defaults-extra-file=/etc/mysql/mariadb.conf.d/50-server.cnf" ]

LABEL maintainer="Dale Furneaux <dfurneaux@student.42abudhabi.ae>" \
      version="1.0.0" \
	  desc="Maria Database"
