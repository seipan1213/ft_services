FROM alpine:3.13

RUN apk update
RUN apk --no-cache add \
	telegraf \
	influxdb

RUN mkdir -p /etc/telegraf

COPY srcs/setup.sh /
COPY srcs/telegraf.conf /etc/telegraf/
COPY srcs/livenessprobe.sh /

RUN chmod 755 /setup.sh
RUN chmod 755 /etc/telegraf/telegraf.conf
RUN chmod 755 /livenessprobe.sh

EXPOSE	8086

ENTRYPOINT ["/setup.sh"]