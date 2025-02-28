#!/bin/sh

cd /usr/share/webapps

# Check if WordPress is installed
if [ ! -f "wp-config.php" ]; then
    # Download WordPress
	wp core download --allow-root

    # Create wp-config.php
    wp config create --allow-root \
        --dbname=$DB_NAME \
        --dbuser=$DB_USER \
        --dbpass=$DB_PASSWORD \
        --dbhost=mariadb \
		--path=/usr/share/webapps/

    # Install WordPress
    wp core install --allow-root \
        --url="https://$DOMAIN_NAME" \
        --title="$WP_TITLE" \
        --admin_user="$WP_ADMIN_USER" \
        --admin_password="$WP_ADMIN_PASSWORD" \
        --admin_email="$WP_ADMIN_EMAIL"

    # Create additional user
    wp user create --allow-root \
        "$WP_USER" "$WP_USER_EMAIL" \
        --user_pass="$WP_USER_PASSWORD" \
        --role=author

    # Set correct permissions
    chown -R web-data:web-data /usr/share/webapps/wp-content/
fi

exec /usr/sbin/php-fpm82 -F

#attention les password doivent etre dans secret