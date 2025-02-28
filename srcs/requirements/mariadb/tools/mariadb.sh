#!/bin/sh

echo "Setting up MariaDB..."

touch /etc/mariadb-init.sql
echo "CREATE DATABASE IF NOT EXISTS $DB_NAME;" >> /etc/mariadb-init.sql
echo "CREATE USER IF NOT EXISTS $DB_USER@'localhost' IDENTIFIED BY '$DB_PASSWORD';" >> /etc/mariadb-init.sql
echo "GRANT ALL PRIVILEGES ON $DB_NAME.* TO $DB_USER@'%' IDENTIFIED BY '$DB_PASSWORD';" >> /etc/mariadb-init.sql
echo "SET PASSWORD FOR 'root'@'localhost' = PASSWORD('$DB_ROOT_PASSWORD');" >> /etc/mariadb-init.sql
echo "FLUSH PRIVILEGES;" >> /etc/mariadb-init.sql

echo "MariaDB setup complete."

exec mariadbd --user=mysql --init-file=/etc/mariadb-init.sql
#Attention les passwords doivent etre "$($PASSWORD)" pour les paths secrets