docker volume rm db_data www_data redis_data code_data > /dev/null 2>&1
rm -rf ${PWD}/data/code_data/* \
&& rm -rf ${PWD}/data/db_data/* \
&& rm -rf ${PWD}/data/redis_data/* \
&& rm -rf ${PWD}/data/www_data/* \
