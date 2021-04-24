#!bin/sh
 
rc-status
telegraf --config /etc/telegraf/telegraf.conf&
rc-service php-fpm7 start
nginx -g 'daemon off;'
sleep infinity