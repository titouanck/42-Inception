CREATE DATABASE IF NOT EXISTS ticodb;
CREATE USER 'tico45'@'%' IDENTIFIED BY 'tico45';
GRANT ALL PRIVILEGES ON ticodb.* TO 'tico45'@'%';
