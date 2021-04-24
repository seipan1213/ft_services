#!bin/sh

telegraf --config /etc/telegraf/telegraf.conf&
grafana-server --homepath usr/share/grafana&

sleep infinity