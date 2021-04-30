FROM alpine:3.13

RUN apk update
RUN apk --no-cache add \
	openrc \
	mysql \
	mysql-client \
	telegraf

RUN mkdir -p /etc/telegraf

RUN sed -i'.bak' 's/^#rc_sys=""/rc_sys="lxc"/' /etc/rc.conf \
    && sed -i 's/^#rc_provide="!net"/rc_provide="loopback net"/' /etc/rc.conf \
    && sed -i'.bak' '/getty/d' /etc/inittab \
    && sed -i'.bak' 's/mount -t tmpfs/# mount -t tmpfs/' /lib/rc/sh/init.sh \
    && sed -i'.bak' 's/hostname $opts/# hostname $opts/' /etc/init.d/hostname \
    && sed -i'.bak' 's/cgroup_add_service$/# cgroup_add_service/' /lib/rc/sh/openrc-run.sh \
    && mkdir /run/openrc \
    && touch /run/openrc/softlevel

RUN touch /var/log/mysqld.log

COPY srcs/setup.sh /
COPY srcs/my.cnf /etc/mysql/
COPY srcs/telegraf.conf /etc/telegraf/
COPY srcs/livenessprobe.sh /

RUN chmod 755 /etc/telegraf/telegraf.conf
RUN chmod 755 /setup.sh
RUN chmod 666 /var/log/mysqld.log
RUN chmod 755 /livenessprobe.sh

ENTRYPOINT ["/setup.sh"]
