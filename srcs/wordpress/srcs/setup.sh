#!bin/sh
#sed -i -e 's/user = nobody/user = nginx/g' etc/php7/php-fpm.d/www.conf
#sed -i -e 's/group = nobody/group = nginx/g' etc/php7/php-fpm.d/www.conf
 
rc-status
rc-service php-fpm7 start
nginx -g 'daemon off;'
sleep infinity