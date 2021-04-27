FROM alpine:3.13

RUN apk update
RUN apk --no-cache add \
	nginx \
	openrc \
	openssl \
	curl \
	telegraf \
	php php7-fpm php7-phar php-mbstring php-intl php7-openssl php7-json php7-mysqli php7-curl \
	mysql mysql-client

RUN mkdir -p /run/nginx
RUN mkdir -p /etc/telegraf

RUN sed -i'.bak' 's/^#rc_sys=""/rc_sys="lxc"/' /etc/rc.conf \
    && sed -i 's/^#rc_provide="!net"/rc_provide="loopback net"/' /etc/rc.conf \
    && sed -i'.bak' '/getty/d' /etc/inittab \
    && sed -i'.bak' 's/mount -t tmpfs/# mount -t tmpfs/' /lib/rc/sh/init.sh \
    && sed -i'.bak' 's/hostname $opts/# hostname $opts/' /etc/init.d/hostname \
    && sed -i'.bak' 's/cgroup_add_service$/# cgroup_add_service/' /lib/rc/sh/openrc-run.sh \
    && mkdir /run/openrc \
    && touch /run/openrc/softlevel \
    && sed -i'.bak' 's/return 404;/root html;\n\t\tindex index.html;/' /etc/nginx/conf.d/default.conf

WORKDIR /etc/ssl
RUN	openssl genrsa 2048 > ./private/server.key \
	&& openssl req -new -key ./private/server.key > ./certs/server.csr \
	-subj '/C=JP/ST=Tokyo/L=Tokyo/O=42Tokyo/OU=42Tokyo/CN=example.com'\
	&& openssl x509 -days 3650 -req -signkey ./private/server.key < ./certs/server.csr > ./certs/server.crt

WORKDIR /
RUN curl https://ja.wordpress.org/wordpress-5.7-ja.tar.gz > /tmp/wordpress-ja.tar.gz\
	&& tar -xzf /tmp/wordpress-ja.tar.gz -C /var/www/ \
	&& rm -f /tmp/wordpress-ja.tar.gz

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
	&& chmod +x wp-cli.phar \
	&& mv wp-cli.phar /usr/local/bin/wp

COPY srcs/nginx.conf etc/nginx/
COPY srcs/wp-config.php var/www/wordpress/
COPY srcs/setup.sh /
COPY srcs/telegraf.conf /etc/telegraf/

RUN chmod 755 /etc/telegraf/telegraf.conf
RUN chmod 755 /setup.sh
RUN chmod 644 /var/www/wordpress/wp-config.php
RUN chmod -R 755 /var/www/wordpress

EXPOSE 5050

ENTRYPOINT ["/setup.sh"]
