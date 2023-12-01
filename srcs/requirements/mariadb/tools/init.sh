sed -i "s/{{DB_NAME}}/$DB_NAME/" /etc/init.sql
sed -i "s/{{DB_USER}}/$DB_USER/" /etc/init.sql
sed -i "s/{{DB_PASSWORD}}/$DB_PASSWORD/" /etc/init.sql
