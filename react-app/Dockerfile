FROM nginx:1.17-alpine as webproxy
COPY config/nginx.conf /etc/nginx/nginx.conf

FROM webproxy
COPY ./build/ /var/www

EXPOSE 3000
