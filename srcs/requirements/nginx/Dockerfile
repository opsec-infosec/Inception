FROM debian:buster

ARG DOMAIN_NAME

USER root

ENV APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE=DontWarn
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update --no-install-recommends -y
RUN apt-get install --no-install-recommends -y \
	dialog \
	nginx \
	openssl \
	&& apt-get clean autoclean \
    && apt-get autoremove --yes \
    && rm -rf /var/lib/{apt,dpkg,cache,log}

RUN mkdir -p /etc/nginx/certificates && openssl req \
							-new \
							-newkey rsa:4096 \
							-x509 -sha256 \
							-days 365 \
							-subj "/CN=${DOMAIN_NAME}/C=AE/L=Abu Dhabi" \
							-nodes \
							-out /etc/nginx/certificates/nginx-certificate.crt \
							-keyout /etc/nginx/certificates/nginx.key

COPY ./conf/init.sh /root/init.sh
COPY ./conf/nginx.conf /root/nginx.conf
COPY ./conf/codeserver.conf /root/codeserver.conf
RUN chmod a+x /root/init.sh

ENV DEBIAN_FRONTEND=dialog

LABEL maintainer="Dale Furneaux <dfurneaux@student.42abudhabi.ae>" \
      version="1.0.0" \
	  desc="NGINX Web Server"
