# mariadb container
FROM alpine:PENULTIMATE_STABLE

RUN apk update
RUN apk --no-cache add mariadb mariadb-client openrc

COPY ./conf/my.cnf /etc
COPY ./conf/init.sql /etc
RUN openrc && touch /run/openrc/softlevel
RUN mkdir -p /run/mysqld

COPY ./tools/init.sh /

CMD ["sh", "-c", "/init.sh && rc-service mariadb setup && mysqld --user=root --console"]
