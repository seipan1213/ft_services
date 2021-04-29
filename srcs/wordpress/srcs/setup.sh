#!bin/sh
 
rc-status
rc-service php-fpm7 start
telegraf --config /etc/telegraf/telegraf.conf&

wp core install --title=test --admin_user=admin --admin_password=admin \
		--admin_email=admin@example.com --url=https://192.168.49.50:5050 \
		--path=/var/www/wordpress

wp user create rika \
	rika@example.com \
	--role=editor \
	--user_pass=rika

wp user create rena \
	rena@example.com \
	--role=author \
	--user_pass=rena

wp user create keichi \
	keichi@example.com \
	--role=author \
	--user_pass=keichi

nginx -g 'daemon off;'

sleep infinity