FROM alpine:3.18

# Installer MariaDB
RUN apk update
RUN apk --no-cache add mariadb mariadb-client openrc
RUN openrc
RUN touch /run/openrc/softlevel

CMD ["sh", "-c", "mysqld -u root"]
# CMD ["sh", "-c", "tail -f"]
