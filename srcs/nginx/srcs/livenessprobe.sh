#!/bin/sh

pgrep sshd > /dev/null
sshd=$?
pgrep telegraf > /dev/null
telegraf=$?
pgrep nginx > /dev/null
nginx=$?

if [ ${sshd} != 0 -o ${telegraf} != 0 -o ${nginx} != 0 ]; then
	exit 1
else
	exit 0
fi