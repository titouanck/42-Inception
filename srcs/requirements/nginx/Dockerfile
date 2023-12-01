# nginx container
FROM alpine:3.18

RUN apk update
RUN apk --no-cache add nginx openssl

COPY ./conf/nginx.conf /etc/nginx/nginx.conf

RUN mkdir -p /etc/nginx/tls
WORKDIR /etc/nginx/tls
RUN openssl req -x509 -nodes -newkey rsa:2048 -keyout private.key -out certificate.crt -days 365 -subj "/CN=tchevrie.fr" -addext "subjectAltName=DNS:tchevrie.42.fr"
RUN chown -R nginx:nginx /etc/nginx/tls

CMD ["nginx", "-g", "daemon off;"]

