#!bin/sh
echo set ftp:ssl-force on >> /etc/lftp.conf
echo set ftp:use-feat off >> /etc/lftp.conf
echo set ftp:ssl-protect-data on >> /etc/lftp.conf
echo set ssl:verify-certificate no >> /etc/lftp.conf

rc-status
rc-service vsftpd start
telegraf --config /etc/telegraf/telegraf.conf&
sleep infinity