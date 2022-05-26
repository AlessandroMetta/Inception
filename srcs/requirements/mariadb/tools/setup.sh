#!/bin/sh

if [ ! -f "/var/lib/mysql/ib_buffer_pool" ];
then
	/etc/init.d/mariadb setup
	rc-service mariadb start
	
	# Create new database if dos not exit
	echo "DROP DATABASE test;" | mysql -u root
	echo "CREATE DATABASE IF NOT EXISTS wordpress;" | mysql -u root

	# Create new user and Make The user GRANT ALL PRIVILEGES on Wordpress database
	echo "CREATE USER '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_USER_PASS}';" | mysql -u root
	echo "GRANT ALL PRIVILEGES ON wordpress.* TO '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_USER_PASS}';" | mysql -u root
	echo "FLUSH PRIVILEGES;" | mysql -u ${MYSQL_ROOT_USER}
	
	# Change Password For root user
    mysql -u root -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASS}';"
fi

# Comment skip-networking
sed -i 's/skip-networking/# skip-networking/g' /etc/my.cnf.d/mariadb-server.cnf
sed -i 's/#bind-address=0.0.0.0/bind-address=0.0.0.0/g' /etc/my.cnf.d/mariadb-server.cnf

rc-service mariadb restart
rc-service mariadb stop

# Running This Command "/usr/bin/mariadbd" to stay running in the foreground
/usr/bin/mariadbd --basedir=/usr --datadir=/var/lib/mysql --plugin-dir=/usr/lib/mariadb/plugin --user=mysql --pid-file=/run/mysqld/mariadb.pid
