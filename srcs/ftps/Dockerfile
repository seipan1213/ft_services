FROM alpine:3.13

RUN apk update
RUN apk --no-cache add \
	vsftpd \
	lftp \
	openrc \
	openssl \
	telegraf

RUN mkdir -p /run/nginx
RUN mkdir -p /etc/telegraf
RUN echo "root:toor" | chpasswd

RUN sed -i'.bak' 's/^#rc_sys=""/rc_sys="lxc"/' /etc/rc.conf \
    && sed -i 's/^#rc_provide="!net"/rc_provide="loopback net"/' /etc/rc.conf \
    && sed -i'.bak' '/getty/d' /etc/inittab \
    && sed -i'.bak' 's/mount -t tmpfs/# mount -t tmpfs/' /lib/rc/sh/init.sh \
    && sed -i'.bak' 's/hostname $opts/# hostname $opts/' /etc/init.d/hostname \
    && sed -i'.bak' 's/cgroup_add_service$/# cgroup_add_service/' /lib/rc/sh/openrc-run.sh \
    && mkdir /run/openrc \
    && touch /run/openrc/softlevel

WORKDIR /etc/vsftpd/

RUN	openssl genrsa 2048 > ./server.key \
	&& openssl req -new -key ./server.key > ./server.csr \
	-subj '/C=JP/ST=Tokyo/L=Tokyo/O=42Tokyo/OU=42Tokyo/CN=example.com'\
	&& openssl x509 -days 3650 -req -signkey ./server.key < ./server.csr > ./server.crt

WORKDIR /

COPY srcs/setup.sh /
COPY srcs/telegraf.conf /etc/telegraf/
COPY srcs/vsftpd.conf /etc/vsftpd/
COPY srcs/livenessprobe.sh /

RUN chmod 755 /etc/telegraf/telegraf.conf
RUN chmod 755 /setup.sh
RUN chmod 755 /etc/vsftpd/vsftpd.conf
RUN chmod 755 /livenessprobe.sh

ENTRYPOINT ["/setup.sh"]

EXPOSE 21 60020 60021
