SHOW TRIGGERS from payroll;

SHOW PROCEDURE STATUS where db = 'Payroll';

SELECT TABLE_SCHEMA, TABLE_NAME 
FROM information_schema.tables 
WHERE TABLE_TYPE LIKE 'VIEW'
and Table_Schema = 'Payroll';