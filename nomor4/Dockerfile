FROM php:7.1-fpm-alpine

RUN apk update \
    && apk upgrade \
    && apk add --no-cache \
        freetype-dev \
        libpng-dev \
        jpeg-dev \
	libjpeg \
        libjpeg-turbo-dev \
	nginx \
      	supervisor

RUN docker-php-ext-configure gd \
        --with-freetype-dir=/usr/lib/ \
        --with-png-dir=/usr/lib/ \
        --with-jpeg-dir=/usr/lib/ \
        --with-gd

RUN NUMPROC=$(grep -c ^processor /proc/cpuinfo 2>/dev/null || 1) \
    && docker-php-ext-install -j${NUMPROC} gd

# Configure nginx
COPY ./files/nginx/nginx.conf /etc/nginx/nginx.conf
COPY ./files/nginx/default_server.conf /sites/default.conf
COPY ./files/www/* /www/


# Configure supervisord
COPY ./files/supervisor/supervisord.conf /etc/supervisor/conf.d/
COPY ./files/supervisor/init.d/* /autostart/

# Add application
WORKDIR /www

VOLUME /www
ENTRYPOINT ["/bin/sh"]
EXPOSE 80 443 9000
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
