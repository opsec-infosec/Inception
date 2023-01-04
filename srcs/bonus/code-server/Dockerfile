FROM debian:buster

USER root

ARG WP_ADMIN_NAME
ARG WP_ADMIN_PW

ENV APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE=DontWarn
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update --no-install-recommends -y
RUN apt-get install --no-install-recommends -y \
	dialog \
	openssl \
	ca-certificates \
	wget \
	curl \
	man-db \
    build-essential \
    libtool-bin \
    valgrind \
    gdb \
    automake \
    make \
    g++ \
    libtool \
    manpages-dev \
    python3 \
    python3-pip \
    git \
    llvm \
    clang \
    #Fonts Install
    fonts-firacode \
	&& apt-get clean autoclean \
    && apt-get autoremove --yes \
    && rm -rf /var/lib/{apt,dpkg,cache,log}

RUN wget https://github.com/coder/code-server/releases/download/v4.7.1/code-server-4.7.1-linux-amd64.tar.gz -O /root/code-server.tar.gz

RUN cd /root \
	&& tar -xvzf /root/code-server.tar.gz \
	&& mkdir -p /usr/local/bin/code \
 	&& cp -R /root/code-server-*/* /usr/local/bin/code/ \
	&& rm -rf /root/code-server* \
	&& python3 -m pip install --upgrade pip setuptools

COPY ./conf/config.yaml /usr/local/bin/config.yaml
COPY ./conf/init.sh /usr/local/bin/code/init.sh

RUN adduser --home /home/${WP_ADMIN_NAME} ${WP_ADMIN_NAME} \
 	&& usermod --password $(openssl passwd -1 ${WP_ADMIN_PW}) ${WP_ADMIN_NAME} \
	&& chown -R ${WP_ADMIN_NAME}:${WP_ADMIN_NAME} /usr/local/bin/code \
	&& chmod a+x /usr/local/bin/code/init.sh

USER ${WP_ADMIN_NAME}
WORKDIR /home/${WP_ADMIN_NAME}

RUN	mkdir -p /home/${WP_ADMIN_NAME}/data \
	&& mkdir -p /home/${WP_ADMIN_NAME}/.local/share/code-server/extensions \
	&& mkdir -p /home/${WP_ADMIN_NAME}/ext


RUN cd /home/${WP_ADMIN_NAME}/ext && wget https://github.com/microsoft/vscode-cpptools/releases/download/v1.12.4/cpptools-linux.vsix
RUN cd /home/${WP_ADMIN_NAME}/ext && wget https://github.com/microsoft/vscode-makefile-tools/releases/download/v0.6.0/makefile-tools.vsix

COPY ./conf/*.vsix /home/${WP_ADMIN_NAME}/ext/

ENV DEBIAN_FRONTEND=dialog
ENV CODE_SERVER_CONFIG=/usr/local/bin/config.yaml

ENTRYPOINT [ "/usr/local/bin/code/init.sh" ]

LABEL maintainer="Dale Furneaux <dfurneaux@student.42abudhabi.ae>" \
      version="1.0.0" \
	  desc="Code Server"
