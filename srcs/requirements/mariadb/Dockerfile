# Use Alpine as the base image
FROM alpine:3.18

# Set environment variables for MariaDB setup
ENV MARIADB_ROOT_PASSWORD=root \
    MARIADB_DATABASE=mydatabase \
    MARIADB_USER=myuser \
    MARIADB_PASSWORD=mypassword

# Update and install MariaDB
RUN apk update && apk add --no-cache \
	mariadb \
	mariadb-client

RUN mkdir -p /var/run/mariadb && \
    chown -R mysql:mysql /var/run/mariadb

# Copy configuration file and setup script
COPY conf/mariadb.conf /etc/my.cnf
COPY tools/mariadb.sh /etc/mariadb.sh

# Give execution permissions to the setup script
RUN chmod +x /etc/mariadb.sh
# RUN /etc/mariadb.sh

# Expose MariaDB port
EXPOSE 3306

CMD ["mysqld", "--user=mysql"]
