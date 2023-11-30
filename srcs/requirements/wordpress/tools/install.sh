if [ ! -f /var/www/html/index.php ]; then
    cd /var/www/html
    wget https://fr.wordpress.org/latest-fr_FR.tar.gz
    tar -xvf latest-fr_FR.tar.gz
    rm latest-fr_FR.tar.gz
    mv wordpress/* .
    rm -rf wordpress
	mv /wp-config.php /var/www/html/wp-config.php
fi
