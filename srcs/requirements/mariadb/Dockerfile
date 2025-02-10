FROM alpine:3.18

RUN apk update && apk add --no-cache \
    mariadb \
    mariadb-client

# Create necessary directories
RUN mkdir -p /run/mysqld && \
    chown -R mysql:mysql /run/mysqld

# Copy configuration and initialization files
COPY conf/my.cnf /etc/my.cnf.d/mariadb-server.cnf
COPY tools/db_setup.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/db_setup.sh

EXPOSE 3306

ENTRYPOINT ["/usr/local/bin/db_setup.sh"]
CMD ["mysqld", "--user=mysql"]
