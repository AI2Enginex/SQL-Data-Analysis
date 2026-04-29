CREATE USER 'myuser'@'localhost' IDENTIFIED BY 'mypassword';

--- grant ALL PRIVILEGES for the entire database to 'myuser'
GRANT ALL PRIVILEGES ON *.* TO 'myuser'@'localhost';

--- grant ALL PRIVILEGES for database cars to 'myuser' 
GRANT ALL PRIVILEGES ON cars.* TO 'myuser'@'localhost';

--- grant only limited access for the bigmart_sales database to 'myuser'
GRANT SELECT, INSERT ON bigmart_sales.* TO 'myuser'@'localhost';
FLUSH PRIVILEGES;


















