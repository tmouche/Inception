FROM alpine:3.18

RUN apk update && apk add --no-cache \
	wget \
	fcgi \
	tar \
	php82 \
	php82-cgi \
	php82-fpm \
	php82-phar \
	php82-curl \
	php82-iconv \
	php82-mysqli \
	php82-openssl \
    mariadb-client

RUN ln -s /usr/bin/php82 /usr/bin/php
RUN echo "memory_limit = 256M" > /etc/php82/conf.d/memory_limit.ini

RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar -O /usr/local/bin/wp && \
    chmod +x /usr/local/bin/wp

RUN mkdir -p /usr/share/webapps

RUN addgroup -S web-data && adduser -S web-data -G web-data
COPY conf/www.conf /etc/php82/php-fpm.d/www.conf

RUN chown -R web-data:web-data /usr/share/webapps
RUN chmod -R 755 /usr/share/webapps

COPY wordpress.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/wordpress.sh

RUN /usr/local/bin/wordpress.sh

CMD ["/usr/sbin/php-fpm82", "-F"]