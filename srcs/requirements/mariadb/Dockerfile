FROM alpine:3.18

# Set environment variables for MariaDB setup
ENV MARIADB_ROOT_PASSWORD=root \
    MARIADB_DATABASE=mydatabase \
    MARIADB_USER=mysql \
    MARIADB_PASSWORD=mypassword

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

RUN chmod +x /mariadb.sh
RUN /mariadb.sh

EXPOSE 3306

CMD ["mariadbd"]
