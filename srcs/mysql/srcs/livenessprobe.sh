#!/bin/sh

pgrep mariadbd > /dev/null
mariadbd=$?
pgrep telegraf > /dev/null
telegraf=$?

if [ ${mariadbd} != 0 -o ${telegraf} != 0 ]; then
	exit 1
else
	exit 0
fi