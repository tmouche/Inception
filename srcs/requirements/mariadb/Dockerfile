FROM alpine:3.18

RUN apk update && apk add --no-cache \
	mariadb \
	mariadb-client

RUN mkdir -p /var/lib/mariadb \
			 /var/log/mariadb \
			 /var/run/mariadb

RUN chown -R mysql:mysql /var/lib/mariadb \
						 /var/log/mariadb \
						 /var/run/mariadb

RUN mariadb-install-db --user=mysql --datadir=/var/lib/mariadb

COPY conf/mariadb.conf /etc/my.cnf
COPY tools/mariadb.sh mariadb.sh

EXPOSE 3306

RUN chmod +x /mariadb.sh

CMD ["/mariadb.sh"]
