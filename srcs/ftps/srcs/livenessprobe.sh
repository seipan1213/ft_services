#!/bin/sh

pgrep vsftpd > /dev/null
vsftpd=$?
pgrep telegraf > /dev/null
telegraf=$?

if [ ${vsftpd} != 0 -o ${telegraf} != 0 ]; then
	exit 1
else
	exit 0
fi