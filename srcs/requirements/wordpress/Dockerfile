FROM alpine:3.18

EXPOSE 9000
COPY ./tools/php-fpm.conf /etc/php81/php-fpm.conf
WORKDIR /etc/php81
RUN apk add php-fpm nano
RUN adduser -D --ingroup www-data www-data
RUN mkdir -p /var/run/php
# RUN adduser www-data
# RUN mkdir -p /var/run/php
# RUN chmod 755 /var/run/php
