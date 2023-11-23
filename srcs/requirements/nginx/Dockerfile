FROM alpine:3.18
RUN apk add nginx
COPY ./conf /etc/nginx/nginx.conf
CMD ["nginx", "-g", "daemon off;"]

