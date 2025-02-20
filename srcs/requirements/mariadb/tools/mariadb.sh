#!/bin/sh

echo "Setting up MariaDB..."

# Start MariaDB in the background
mariadbd --user=mysql --datadir=/var/lib/mariadb --skip-networking &
sleep 5  # Wait for MariaDB to start

# Run SQL commands using the MariaDB client
mariadb -u root <<EOF
CREATE DATABASE IF NOT EXISTS $DB_NAME;
CREATE USER IF NOT EXISTS $DB_USER@'localhost' IDENTIFIED BY "$($DB_PASSWORD)";
GRANT ALL PRIVILEGES ON $DB_NAME.* TO $DB_USER@'%' IDENTIFIED BY "$($DB_PASSWORD)";
SET PASSWORD FOR 'root'@'localhost' = PASSWORD("$($DB_ROOT_PASSWORD)");
FLUSH PRIVILEGES;
EOF

echo "MariaDB setup complete."
