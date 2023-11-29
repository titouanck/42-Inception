FROM alpine:3.18

RUN apk update && \
    apk add --no-cache mysql mysql-client

RUN mkdir -p /var/lib/mysql

COPY my.cnf /etc/mysql/my.cnf

EXPOSE 3306

# Démarrez le service MySQL lorsque le conteneur démarre
CMD ["mysqld", "--user=mysql", "--console"]
