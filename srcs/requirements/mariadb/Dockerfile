FROM alpine:3.18

# Installer MariaDB
RUN apk update
RUN apk --no-cache add mariadb mariadb-client openrc
RUN openrc
RUN touch /run/openrc/softlevel
RUN mkdir -p /run/mysqld

# CMD ["sh", "-c", "mysql -u root"]
CMD ["sh", "-c", "mysqld --user=root --console"]
