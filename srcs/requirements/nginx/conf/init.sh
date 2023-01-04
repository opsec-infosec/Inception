#!/bin/bash

echo $1

## nginx conf for bonus
if [ $1 == "bonus" ]; then
	cp /root/codeserver.conf /etc/nginx/sites-available/default
else
	cp /root/nginx.conf /etc/nginx/sites-available/default
fi

/usr/sbin/nginx -g 'daemon off;'
