#!bin/sh

telegraf --config /etc/telegraf/telegraf.conf&
influxd -config /etc/influxdb.conf&

sleep infinity