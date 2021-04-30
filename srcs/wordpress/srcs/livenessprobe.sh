#!/bin/sh

pgrep php-fpm > /dev/null
php=$?
pgrep telegraf > /dev/null
telegraf=$?
pgrep nginx > /dev/null
nginx=$?

if [ ${php} != 0 -o ${telegraf} != 0 -o ${nginx} != 0 ]; then
	exit 1
else
	exit 0
fi