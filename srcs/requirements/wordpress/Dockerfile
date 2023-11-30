FROM alpine:3.18

RUN apk add php-fpm php-mysqli
COPY ./tools/php-fpm.conf /etc/php81/php-fpm.conf
RUN adduser -D --ingroup www-data www-data
RUN mkdir -p /var/run/php
COPY ./tools/install.sh /
COPY ./tools/wp-config.php /

CMD ["sh", "-c", "/install.sh && php-fpm81 -F"]
