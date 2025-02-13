FROM alpine:3.18

apk add lighttpd php82 fcgi php82-cgi

RUN apk update && apk add --no-cache \
	lighttpd \
	php82 \
	fcgi \
	php82-cgi \
	tar \
	wget \
    curl \
    mysql-client

# Install wp-cli
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp

# Configure php-fpm
RUN mkdir -p /var/run/php && \
    sed -i 's/listen = 127.0.0.1:9000/listen = 9000/g' /etc/php81/php-fpm.d/www.conf

COPY wordpress.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/wordpress.sh

WORKDIR /var/www/html

EXPOSE 9000

ENTRYPOINT ["/usr/local/bin/wordpress.sh"]
CMD ["/usr/sbin/php-fpm81", "-F"]
