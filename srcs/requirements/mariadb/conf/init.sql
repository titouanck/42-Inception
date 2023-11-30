-- init.sql

-- Create the database
CREATE DATABASE IF NOT EXISTS ticodb;

-- Create the user
CREATE USER 'tico45'@'%' IDENTIFIED BY 'tico45';

-- Grant privileges
GRANT ALL PRIVILEGES ON ticodb.* TO 'tico45'@'%';
