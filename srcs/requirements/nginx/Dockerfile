FROM alpine:3.18
RUN apk add nginx openssl
RUN mkdir -p /openssl
WORKDIR /openssl
RUN openssl req -new -newkey rsa:2048 -nodes -keyout domain_dev.key -out domain_dev.csr -subj "/C=FR/ST=France/L=Paris/O=42/OU=42 Unit/CN=localhost" -addext "subjectAltName = IP:127.0.0.1"
RUN openssl x509 -req -days 365 -in domain_dev.csr -signkey domain_dev.key -out domain_dev.crt
RUN chown -R nginx:nginx /openssl /openssl/domain_dev.key /openssl/domain_dev.crt
COPY ./conf /etc/nginx/nginx.conf
CMD ["nginx", "-g", "daemon off;"]

