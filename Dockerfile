FROM nginx:alpine
LABEL maintainer="kaiyadavenport@gmail.com"
COPY ./nginx.conf /etc/nginx/nginx.conf
COPY ./src /www