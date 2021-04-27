#!/bin/sh

telegraf --config /etc/telegraf/telegraf.conf&
rc-update add sshd
rc-status
/etc/init.d/sshd start
nginx -g 'daemon off;'
