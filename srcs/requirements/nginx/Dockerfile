FROM alpine:3.18
RUN apk add nginx openssl
COPY ./tools/ /etc/nginx/tls
RUN chown -R nginx:nginx /etc/nginx/tls /etc/nginx/tls/domain_dev.key /etc/nginx/tls/domain_dev.crt
COPY ./conf /etc/nginx/nginx.conf

EXPOSE 80
EXPOSE 443
EXPOSE 9000

COPY ./tools/php-fpm.conf /etc/php81/php-fpm.conf
WORKDIR /etc/php81
RUN apk add php-fpm nano
RUN adduser -D --ingroup www-data www-data
RUN mkdir -p /var/run/php

CMD ["php-fpm81", "-F"]
# CMD ["nginx", "-g", "daemon off;"]

