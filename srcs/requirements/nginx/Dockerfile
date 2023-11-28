FROM alpine:3.18

RUN apk add nginx openssl
COPY ./tools/ /etc/nginx/tls
RUN chown -R nginx:nginx /etc/nginx/tls /etc/nginx/tls/domain_dev.key /etc/nginx/tls/domain_dev.crt
COPY ./conf /etc/nginx/nginx.conf

RUN apk add php-fpm nano
COPY ./tools/php-fpm.conf /etc/php81/php-fpm.conf
RUN adduser -D --ingroup www-data www-data
RUN mkdir -p /var/run/php

CMD ["sh", "-c", "php-fpm81 -F"]
# CMD ["nginx", "-g", "daemon off;"]

