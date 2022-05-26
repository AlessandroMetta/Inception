#!/bin/sh

# wordpress installation
wp core download --allow-root

# wordpress config creation for wordpress database connection
wp config create --dbname=wordpress --dbuser=$MYSQL_USER --dbpass=$MYSQL_USER_PASS --dbhost=mariadb --dbcharset="utf8" --dbcollate="utf8_general_ci" --allow-root

# wordpress creation of the admin of the site
wp core install --url=ametta.42.fr --title="Inception" --admin_user=$DATABASE_ADMIN --admin_password=$DATABASE_ADMIN_PWD --admin_email="ametta@42.fr" --skip-email --allow-root

# wordpress creation of the user
wp user create $DATABASE_USER "user@42.fr" --role=author --user_pass=$DATABASE_USER_PWD --allow-root

# wordpress installation of the site theme
wp theme install twentytwentytwo --activate --allow-root

# wordpress plugin update
wp plugin update --all --allow-root

# start the php-fpm process
php-fpm7 -FR