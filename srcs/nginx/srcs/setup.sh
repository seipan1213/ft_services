#!/bin/sh

telegraf --config /etc/telegraf/telegraf.conf&
nginx -g 'daemon off;'
