#!/bin/sh

cd /usr/share/webapps

if [ ! -f "wp-config.php" ]; then
	wp core download --allow-root

    wp config create --allow-root \
        --dbname=$DB_NAME \
        --dbuser=$DB_USER \
        --dbpass=$DB_PASSWORD \
        --dbhost=mariadb \
		--path=/usr/share/webapps/

    wp core install --allow-root \
        --url="https://$DOMAIN_NAME" \
        --title="$WP_TITLE" \
        --admin_user="$WP_ADMIN_USER" \
        --admin_password="$WP_ADMIN_PASSWORD" \
        --admin_email="$WP_ADMIN_EMAIL"

    wp user create --allow-root \
        "$WP_USER" "$WP_USER_EMAIL" \
        --user_pass="$WP_USER_PASSWORD" \
        --role=author

    chown -R web-data:web-data /usr/share/webapps/wp-content/
fi

exec /usr/sbin/php-fpm82 -F
