#!/bin/sh

# Initialize MySQL data directory
if [ ! -d "/var/lib/mysql/mysql" ]; then
    mysql_install_db --user=mysql --datadir=/var/lib/mysql

    # Start MariaDB server
    mysqld --user=mysql &
    
    # Wait for MariaDB to start
    while ! mysqladmin ping -h "localhost" --silent; do
        sleep 1
    done

    # Create database and user
    mysql -u root << EOF
    CREATE DATABASE IF NOT EXISTS ${DB_NAME};
    CREATE USER IF NOT EXISTS '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASSWORD}';
    GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'%';
    ALTER USER 'root'@'localhost' IDENTIFIED BY '${DB_ROOT_PASSWORD}';
    FLUSH PRIVILEGES;
EOF

    # Stop MariaDB
    mysqladmin -u root -p${DB_ROOT_PASSWORD} shutdown
fi

# Execute CMD
exec "$@"