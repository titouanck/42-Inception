USER="user"
PASSWORD="password"
DB="database"
SQL_COMMANDS="CREATE USER '$USER'@'localhost' IDENTIFIED BY '$PASSWORD';
CREATE DATABASE $DB;
GRANT ALL PRIVILEGES ON $DB.* TO '$USER'@'localhost';
FLUSH PRIVILEGES;"

# Exécution des commandes SQL
mysql -u root -p -e "$SQL_COMMANDS"
