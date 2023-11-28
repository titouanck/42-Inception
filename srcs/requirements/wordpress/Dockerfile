FROM alpine:3.18

EXPOSE 9000
RUN apk add php-fpm nano
COPY ./tools/php-fpm.conf /etc/php81/php-fpm.conf
RUN adduser -D --ingroup www-data www-data
RUN mkdir -p /var/run/php

CMD ["sh", "-c", "php-fpm81 -F"]
