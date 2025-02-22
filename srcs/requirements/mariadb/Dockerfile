FROM alpine:3.18

RUN apk update && apk add --no-cache \
	mariadb \
	mariadb-client \
	openrc

RUN mkdir -p /var/lib/mariadb \
			 /var/log/mariadb \
			 /var/run/mariadb 
			 
RUN chown -R mysql:mysql /var/lib/mariadb \
						 /var/log/mariadb \
						 /var/run/mariadb

RUN openrc
RUN touch /run/openrc/softlevel
		
RUN mariadb-install-db --datadir=/var/lib/mariadb

COPY conf/mariadb.conf /etc/my.cnf
COPY tools/mariadb.sh mariadb.sh

EXPOSE 3306

RUN chmod +x /mariadb.sh

# ENTRYPOINT ["./mariadb.sh"]
# CMD ["mariadbd"]

#pb de pid
