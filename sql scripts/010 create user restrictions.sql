
-- Admin user has total access
CREATE USER IF NOT EXISTS 'dduck'@'localhost'
IDENTIFIED BY 'password123';
GRANT ALL ON Payroll.* TO 'dduck'@'localhost' WITH GRANT OPTION;

-- SHOW GRANTS FOR 'B_Fuller'@'localhost';

-- HR user
CREATE USER IF NOT EXISTS  'mmouse'@'localhost'
IDENTIFIED BY 'password123';
GRANT SELECT, INSERT, UPDATE, DELETE ON Payroll.Role TO 'mmouse'@'localhost' WITH GRANT OPTION;
GRANT SELECT, INSERT, UPDATE, DELETE ON Payroll.Employee TO 'mmouse'@'localhost' WITH GRANT OPTION;
GRANT SELECT, INSERT, UPDATE, DELETE ON Payroll.EmpLogin TO 'mmouse'@'localhost' WITH GRANT OPTION;
GRANT SELECT ON Payroll.PaymentHistory TO 'mmouse'@'localhost' WITH GRANT OPTION;
GRANT SELECT, INSERT, UPDATE, DELETE ON Payroll.Salary TO 'mmouse'@'localhost' WITH GRANT OPTION;


-- Manager user
CREATE USER IF NOT EXISTS  'minnie'@'localhost'
IDENTIFIED BY 'password123';
GRANT SELECT ON Payroll.Employee TO 'minnie'@'localhost' WITH GRANT OPTION;
GRANT SELECT ON Payroll.PaymentHistory TO 'minnie'@'localhost' WITH GRANT OPTION;
GRANT SELECT ON Payroll.Salary TO 'minnie'@'localhost' WITH GRANT OPTION;


-- Employee user
CREATE USER IF NOT EXISTS  'pluto'@'localhost'
IDENTIFIED BY 'password123';
GRANT SELECT, UPDATE ON Payroll.Employee TO 'pluto'@'localhost' WITH GRANT OPTION;
GRANT SELECT ON Payroll.PaymentHistory TO 'pluto'@'localhost' WITH GRANT OPTION;
GRANT SELECT ON Payroll.Salary TO 'pluto'@'localhost' WITH GRANT OPTION;
