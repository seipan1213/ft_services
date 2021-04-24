FROM alpine:3.13

RUN apk update
RUN apk --no-cache add \
	telegraf \
	influxdb

RUN mkdir -p /etc/telegraf

COPY ./srcs/setup.sh /
COPY ./srcs/telegraf.conf /etc/telegraf/

RUN chmod 755 /setup.sh
RUN chmod 755 /etc/telegraf/telegraf.conf

EXPOSE	8086

ENTRYPOINT ["/setup.sh"]