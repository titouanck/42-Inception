# nginx container
FROM alpine:PENULTIMATE_STABLE

RUN apk update
RUN apk --no-cache add nginx openssl

ARG CONTAINER_USER

COPY ./conf/nginx.conf /etc/nginx/nginx.conf

RUN mkdir -p /etc/nginx/tls
WORKDIR /etc/nginx/tls
RUN openssl req -x509 -nodes -newkey rsa:2048 -keyout private.key -out certificate.crt -days 365 -subj "/CN=${CONTAINER_USER}.42.fr" -addext "subjectAltName=DNS:${CONTAINER_USER}.42.fr"
RUN chown -R nginx:nginx /etc/nginx/tls

COPY ./tools/init.sh /
RUN /init.sh

CMD ["nginx", "-g", "daemon off;"]
