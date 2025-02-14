FROM alpine:3.18

RUN apk update && apk add --no-cache \
	php82 \
	fcgi \
	php82-cgi \
	tar \
	wget \
	# coreutils \
    mysql-client

RUN mkdir -p /usr/share/webapps/
RUN cd /usr/share/webapps/
RUN wget https://wordpress.org/latest.tar.gz
RUN tar -xzvf latest.tar.gz
RUN	rm latest.tar.gz

# Copier un fichier www.conf personnalisé
COPY conf/www.conf /etc/php82/php-fpm.d/www.conf

COPY wordpress.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/wordpress.sh
RUN /usr/local/bin/wordpress.sh

# WORKDIR /var/www/html

EXPOSE 9000

CMD ["/usr/sbin/php-fpm82", "-F"]

#pb de PID 1 il est beaucoup trop long a cut
