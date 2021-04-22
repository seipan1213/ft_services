#!bin/sh

/etc/init.d/mariadb setup
rc-status
rc-service mariadb start
mysql -e "CREATE DATABASE wpdb;"
mysql -e "CREATE USER 'root'@'%' identified by 'toor';"
mysql -e "GRANT ALL PRIVILEGES ON wpdb.* TO 'root'@'%';"
mysql -e "FLUSH PRIVILEGES;"
sleep infinity
