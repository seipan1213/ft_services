FROM alpine:3.13

RUN apk update \
    && apk --no-cache add \
            nginx \
            openssl \
            openssh

RUN mkdir -p /run/nginx

RUN	cd /etc/ssl \
	&& openssl genrsa 2048 > ./private/server.key \
	&& openssl req -new -key ./private/server.key > ./certs/server.csr \
	-subj '/C=JP/ST=Tokyo/L=Tokyo/O=42Tokyo/OU=42Tokyo/CN=example.com'\
	&& openssl x509 -days 3650 -req -signkey ./private/server.key < ./certs/server.csr > ./certs/server.crt

COPY srcs/index.html var/lib/nginx/html/
COPY srcs/nginx.conf etc/nginx/
COPY srcs/setup.sh /

RUN chmod 755 /setup.sh
RUN chmod 755 var/lib/nginx/html/index.html

ENTRYPOINT ["/setup.sh"]

EXPOSE 80
EXPOSE 443
#EXPOSE 22
