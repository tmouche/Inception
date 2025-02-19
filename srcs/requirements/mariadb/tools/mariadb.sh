#!/bin/sh

echo "Setting up MariaDB..."

# Start MariaDB in the background
mariadbd --user=mysql --datadir=/var/lib/mariadb --skip-networking &
sleep 5  # Wait for MariaDB to start

# Run SQL commands using the MariaDB client
mariadb -u root <<EOF
ALTER USER 'root'@'localhost' IDENTIFIED BY '${MARIADB_ROOT_PASSWORD}';
CREATE DATABASE IF NOT EXISTS ${MARIADB_DATABASE};
CREATE USER IF NOT EXISTS '${MARIADB_USER}'@'localhost' IDENTIFIED BY '${MARIADB_PASSWORD}';
GRANT ALL PRIVILEGES ON ${MARIADB_DATABASE}.* TO '${MARIADB_USER}'@'%';
FLUSH PRIVILEGES;
SHUTDOWN;
EOF

echo "MariaDB setup complete."
