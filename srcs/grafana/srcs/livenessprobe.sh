#!/bin/sh

pgrep grafana > /dev/null
grafana=$?
pgrep telegraf > /dev/null
telegraf=$?

if [ ${grafana} != 0 -o ${telegraf} != 0 ]; then
	exit 1
else
	exit 0
fi