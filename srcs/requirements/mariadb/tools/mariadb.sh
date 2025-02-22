#!/bin/sh

echo "Setting up MariaDB..."

# Start MariaDB in the background
rc-service mariadb start
# sleep 5  # Wait for MariaDB to start
#  --datadir=/var/lib/mariadb --user=mysql -
# Run SQL commands using the MariaDB client -u root
mariadb << EOF
CREATE DATABASE IF NOT EXISTS $DB_NAME;
CREATE USER IF NOT EXISTS $DB_USER@'localhost' IDENTIFIED BY "$DB_PASSWORD";
GRANT ALL PRIVILEGES ON $DB_NAME.* TO $DB_USER@'%' IDENTIFIED BY "$DB_PASSWORD";
SET PASSWORD FOR 'root'@'localhost' = PASSWORD("$DB_ROOT_PASSWORD");
FLUSH PRIVILEGES;
EOF

rc-service mariadb stop
echo "MariaDB setup complete."

exec "$@"
#Attention les passwords doivent etre "$($PASSWORD)" pour les paths secrets