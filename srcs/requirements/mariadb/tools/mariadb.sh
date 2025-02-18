#!/bin/bash

# Start MariaDB service in the background
mariadbd --user=mysql --datadir=/var/lib/mariadb --skip-networking &
sleep 5  # Wait for MariaDB to start

# Initialize MariaDB if it's the first run
if [ ! -d "/var/lib/mariadb/mysql" ]; then
    echo "Initializing MariaDB data directory..."
    mariadb-install-db --user=mysql --datadir=/var/lib/mariadb
fi

# Start MariaDB again to apply user changes
mariadbd-safe --nowatch &
sleep 5

# Secure MariaDB and set up database
echo "Setting up MariaDB..."
mariadb -u root <<EOF
ALTER USER 'root'@'localhost' IDENTIFIED BY '${MARIADB_ROOT_PASSWORD}';
CREATE DATABASE IF NOT EXISTS ${MARIADB_DATABASE};
CREATE USER IF NOT EXISTS '${MARIADB_USER}'@'%' IDENTIFIED BY '${MARIADB_PASSWORD}';
GRANT ALL PRIVILEGES ON ${MARIADB_DATABASE}.* TO '${MARIADB_USER}'@'%';
FLUSH PRIVILEGES;
EOF

echo "MariaDB setup complete. Running normally..."
killall mariadbd-safe  # Stop the temporary service

