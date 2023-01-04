FROM debian:buster

USER root

ARG WP_ADMIN_NAME
ARG WP_ADMIN_PW

ENV APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE=DontWarn
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update --no-install-recommends -y
RUN apt-get install --no-install-recommends -y \
	vsftpd \
	openssl \
	dialog \
	&& apt-get clean autoclean \
    && apt-get autoremove --yes \
    && rm -rf /var/lib/{apt,dpkg,cache,log}

COPY ./conf/vsftpd.conf /etc/vsftpd.conf
COPY ./conf/userlist.vsftpd /etc/userlist.vsftpd

RUN adduser --system --no-create-home --group --disabled-login ftpsecure \
	&& mkdir -p /var/run/vsftpd/empty \
	&& mkdir -p /var/log/vsftpd

RUN adduser --home /var/ftpd ${WP_ADMIN_NAME} \
	&& usermod --password $(openssl passwd -1 ${WP_ADMIN_PW}) ${WP_ADMIN_NAME} \
	&& usermod -aG www-data ${WP_ADMIN_NAME}

ENV DEBIAN_FRONTEND=dialog

ENTRYPOINT [ "vsftpd" ]

LABEL maintainer="Dale Furneaux <dfurneaux@student.42abudhabi.ae>" \
      version="1.0.0" \
	  desc="FTP Server"
