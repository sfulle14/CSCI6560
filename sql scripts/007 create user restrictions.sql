CREATE USER 'dduck'@'localhost'
IDENTIFIED BY 'password123';
GRANT ALL ON Payroll.* TO 'dduck'@'localhost' WITH GRANT OPTION;

SHOW GRANTS FOR 'B_Fuller'@'localhost';
