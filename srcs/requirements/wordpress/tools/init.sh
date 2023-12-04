if [ ! -f /var/www/html/index.php ]; then
    cd /var/www/html
    wget https://fr.wordpress.org/latest-fr_FR.tar.gz
    tar -xvf latest-fr_FR.tar.gz
    rm latest-fr_FR.tar.gz
    mv wordpress/* .
    rm -rf wordpress

	cp  /var/www/html/wp-config-sample.php /var/www/html/wp-config.php
    sed -i "s/define('DB_NAME', '.*');/define('DB_NAME', '$DB_NAME');/" /var/www/html/wp-config.php
    sed -i "s/define('DB_USER', '.*');/define('DB_USER', '$DB_USER');/" /var/www/html/wp-config.php
    sed -i "s/define('DB_PASSWORD', '.*');/define('DB_PASSWORD', '$DB_PASSWORD');/" /var/www/html/wp-config.php
    sed -i "s/define('DB_HOST', '.*');/define('DB_HOST', 'mariadb:3306');/" /var/www/html/wp-config.php
    sed -i "s/define('DB_CHARSET', '.*');/define('DB_CHARSET', 'utf8mb4');/" /var/www/html/wp-config.php
fi
