#!/bin/sh

pgrep influxd > /dev/null
influxd=$?
pgrep telegraf > /dev/null
telegraf=$?

if [ ${influxd} != 0 -o ${telegraf} != 0 ]; then
	exit 1
else
	exit 0
fi