# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: dfurneau <dfurneau@student.42abudhabi.ae>  +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/09/30 19:49:39 by dfurneau          #+#    #+#              #
#    Updated: 2022/12/22 15:50:52 by dfurneau         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

NAME = Inception
TARGETS = clean-container clean-volume clean-image
MALL = fclean build up
HOME = /home/${USER}

all: ${MALL}

bonus-up:
	docker compose -f ./srcs/docker-compose.yml -f ./srcs/docker-compose-bonus.yml up -d

bonus-down:
	docker compose -f ./srcs/docker-compose.yml -f ./srcs/docker-compose-bonus.yml down

bonus-build:
	mkdir -p ${HOME}/data/code_data && mkdir -p ${HOME}/data/redis_data && \
	mkdir -p ${HOME}/data/www_data && mkdir -p ${HOME}/data/db_data
	docker compose -f ./srcs/docker-compose.yml -f ./srcs/docker-compose-bonus.yml build

debug:
	docker compose -f ./srcs/docker-compose.yml -f ./srcs/docker compose-bonus.yml up || true

build:
	mkdir -p ${HOME}/data/www_data && mkdir -p ${HOME}/data/db_data
	docker compose -f ./srcs/docker-compose.yml build

up:
	docker compose -f ./srcs/docker-compose.yml up -d

down:
	docker compose -f ./srcs/docker-compose.yml down

host:
	@ echo "127.0.0.1 dfurneau.42.fr" >> /etc/hosts

clean-image:
	@ ./srcs/requirements/tools/irmp.sh || true

clean-dangling:
	@ ./srcs/requirements/tools/irm.sh || true

clean-container:
	@ ./srcs/requirements/tools/crm.sh || true

clean-volume:
	@ ./srcs/requirements/tools/vrm.sh || true
	@ rm -rf ${HOME}/data

fclean: $(TARGETS)

.PHONY: fclean clean-logs clean-volume clean-container clean-dangling clean-image host down up build debug bonus-up bonus-down bonus-build all
