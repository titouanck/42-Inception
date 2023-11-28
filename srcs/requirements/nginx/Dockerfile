FROM alpine:3.18

RUN apk add nginx openssl
COPY ./tools/ /etc/nginx/tls
RUN chown -R nginx:nginx /etc/nginx/tls /etc/nginx/tls/domain_dev.key /etc/nginx/tls/domain_dev.crt
COPY ./conf /etc/nginx/nginx.conf


CMD ["nginx", "-g", "daemon off;"]

