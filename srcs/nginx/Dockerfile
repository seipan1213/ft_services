FROM alpine:3.13

RUN mkdir -p /run/nginx

RUN apk update \
    && apk --no-cache add \
            nginx \
            openrc \
            openssl 
            #openssh

RUN sed -i'.bak' 's/^#rc_sys=""/rc_sys="lxc"/' /etc/rc.conf \
    && sed -i 's/^#rc_provide="!net"/rc_provide="loopback net"/' /etc/rc.conf \
    && sed -i'.bak' '/getty/d' /etc/inittab \
    && sed -i'.bak' 's/mount -t tmpfs/# mount -t tmpfs/' /lib/rc/sh/init.sh \
    && sed -i'.bak' 's/hostname $opts/# hostname $opts/' /etc/init.d/hostname \
    && sed -i'.bak' 's/cgroup_add_service$/# cgroup_add_service/' /lib/rc/sh/openrc-run.sh \
    && mkdir /run/openrc \
    && touch /run/openrc/softlevel \
    && sed -i'.bak' 's/return 404;/root html;\n\t\tindex index.html;/' /etc/nginx/conf.d/default.conf

RUN	cd /etc/ssl \
	&& openssl genrsa 2048 > server.key \
	&& openssl req -new -key server.key > server.csr \
	-subj '/C=JP/ST=Tokyo/L=Tokyo/O=42Tokyo/OU=42Tokyo/CN=example.com'\
	&& openssl x509 -days 3650 -req -signkey server.key < server.csr > server.crt

COPY srcs/index.html var/lib/nginx/html/
COPY srcs/nginx.conf etc/nginx/
COPY srcs/setup.sh /

RUN chmod 755 /setup.sh
RUN chmod 755 var/lib/nginx/html/index.html

ENTRYPOINT ["/setup.sh"]
