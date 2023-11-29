FROM alpine:3.18

# Installer MariaDB
RUN apk update
RUN apk add mariadb mariadb-client openrc
RUN openrc
RUN touch /run/openrc/softlevel
# RUN mysql_install_db

# Copier le script d'initialisation dans le conteneur
# COPY init.sql /docker-entrypoint-initdb.d/

# Exposer le port MySQL
EXPOSE 3306

# Commande par défaut pour lancer MariaDB
# CMD ["mysqld", "--user=mysql", "--console"]
CMD ["sh", "-c", "tail -f"]
