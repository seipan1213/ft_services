#!bin/sh
 
rc-status
rc-service php-fpm7 start
telegraf --config /etc/telegraf/telegraf.conf&
nginx -g 'daemon off;'
sleep infinity