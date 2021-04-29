FROM alpine:3.13

RUN apk update
RUN apk --no-cache add \
	openssl \
	telegraf \
	grafana

RUN mkdir -p /etc/telegraf

WORKDIR /usr/share/grafana/

RUN	openssl genrsa 2048 > ./server.key \
	&& openssl req -new -key ./server.key > ./server.csr \
	-subj '/C=JP/ST=Tokyo/L=Tokyo/O=42Tokyo/OU=42Tokyo/CN=example.com'\
	&& openssl x509 -days 3650 -req -signkey ./server.key < ./server.csr > ./server.crt

WORKDIR /

COPY ./srcs/setup.sh /
COPY ./srcs/telegraf.conf /etc/telegraf/
COPY ./srcs/defaults.ini /usr/share/grafana/conv/
COPY ./srcs/datasources/datasources.yaml /usr/share/grafana/conf/provisioning/datasources/
COPY ./srcs/dashboards/* /usr/share/grafana/conf/provisioning/dashboards/

RUN chmod 755 /setup.sh
RUN chmod 755 /etc/telegraf/telegraf.conf
RUN chmod 755 /usr/share/grafana/conv/defaults.ini
RUN chmod 755 /usr/share/grafana/conf/provisioning/datasources/datasources.yaml
RUN chmod 755 /usr/share/grafana/conf/provisioning/dashboards/*

EXPOSE	3000

ENTRYPOINT ["/setup.sh"]
