#!/bin/bash

echo $1

## Copy wp-config files
if [ $1 == "bonus" ]; then
	cp /root/wp-config-redis.php.conf /var/www/html/wp-config.php
else
	cp /root/wp-config.php.conf /var/www/html/wp-config.php
fi

## Install wp core and themes if not already installed
if ! wp core is-installed --allow-root --path=/var/www/html; then
	wp core install --allow-root --path=/var/www/html \
		--url=https://dfurneau.42.fr \
		--title=${DOMAIN_NAME} \
		--admin_user=${WP_ADMIN_NAME} \
		--admin_password=${WP_ADMIN_PW} \
		--admin_email=${WP_ADMIN_NAME}@example.com \
		--skip-email >> /var/log/wpcli.log \
	&& wp user create --allow-root --path=/var/www/html \
		${WP_USER_NAME} ${WP_USER_NAME}@example.com \
		--display_name=${WP_USER_NAME} \
		--user_pass=${WP_USER_PW} \
		--role=author >> /var/log/wpcli.log
fi

## Install redis cache plugin
if ! wp plugin is-installed redis-cache --allow-root --path=/var/www/html; then
	wp plugin install --allow-root --path=/var/www/html redis-cache
fi

## enable or disable redis cache plugin
if [ $1 == "bonus" ]; then
	wp plugin activate --quiet --allow-root --path=/var/www/html redis-cache
	wp redis enable --quiet --allow-root --path=/var/www/html
	if [ ! -f /var/www/html/adminer/index.php ]; then
		cp /root/index.php /var/www/html/adminer/index.php
		cp /root/static.html /var/www/html/showcase/index.html
	fi
else
	wp redis disable --quiet --allow-root --path=/var/www/html
	wp plugin deactivate --quiet --allow-root --path=/var/www/html redis-cache
	if [ -f /var/www/html/adminer/index.php ]; then
		rm /var/www/html/adminer/index.php
		rm /root/static.html /var/www/html/showcase/index.html
	fi
fi

## Make sure owner www-data for ftpd RW access
chown -R www-data:www-data /var/www \
&& chmod -R 775 $(find /var/www/html -type d) \
&& chmod -R 664 $(find /var/www/html -type f)

## Run php-fpm in non daemon mode
/usr/sbin/php-fpm7.3 -F -R
