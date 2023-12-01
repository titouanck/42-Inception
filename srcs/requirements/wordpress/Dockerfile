# wordpress container
FROM alpine:PENULTIMATE_STABLE

RUN apk update
RUN apk --no-cache add php-fpm php-mysqli

COPY ./conf/php-fpm.conf /etc/php81/php-fpm.conf
RUN adduser -D --ingroup www-data www-data
RUN mkdir -p /var/run/php

COPY ./tools/init.sh /

CMD ["sh", "-c", "/init.sh && php-fpm81 -F"]
