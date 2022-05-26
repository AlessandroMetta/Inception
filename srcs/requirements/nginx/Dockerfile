FROM alpine:3.15

#  download of the update, nginx(webserver) and openssl(ssl certificate generator)
RUN apk update && \
	apk add nginx openssl

#  creation of the volume mount point
RUN mkdir -p /var/www/html

#  copy of the webserver configuration
COPY ./conf/nginx.conf /etc/nginx/

#  copy of the webserver final setup
COPY tools/setup.sh /
RUN chmod +x /setup.sh

#  setup execution
ENTRYPOINT [ "sh", "/setup.sh" ]
