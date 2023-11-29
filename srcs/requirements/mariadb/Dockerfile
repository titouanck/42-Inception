FROM alpine:3.18

RUN apk update
RUN apk --no-cache add mariadb mariadb-client openrc
RUN openrc
RUN touch /run/openrc/softlevel
RUN mkdir -p /run/mysqld

CMD ["sh", "-c", "rc-service mariadb setup && mysqld --user=root --console"]
