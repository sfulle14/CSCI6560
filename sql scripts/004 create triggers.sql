
-- Create triggers for additional security and auditing
DELIMITER //

-- Trigger to log salary changes
-- This will log who is changing the salary of an employee in the auditlog table
CREATE TRIGGER tr_salary_audit
AFTER UPDATE ON Salary
FOR EACH ROW
BEGIN
    INSERT INTO AuditLog (
        EmployeeID,
        ActionType,
        TableAffected,
        RecordID,
        OldValue,
        NewValue
    )
    VALUES (
        NEW.CreatedBy,
        'UPDATE',
        'Salary',
        NEW.SalaryID,
        JSON_OBJECT('salary', OLD.Salary),
        JSON_OBJECT('salary', NEW.Salary)
    );
END //

-- Trigger to prevent direct SSN updates
-- Secures the SSN's to prevent them from being changed
CREATE TRIGGER tr_prevent_ssn_update
BEFORE UPDATE ON Employee
FOR EACH ROW
BEGIN
    IF NEW.ssn != OLD.ssn THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'SSN can only be updated through approved procedures';
    END IF;
END //

DELIMITER ;

DELIMITER //
-- Triggers for hashing
CREATE TRIGGER insertPasswordHash
BEFORE INSERT ON EmpLogin
FOR EACH ROW 
BEGIN
    SET NEW.PasswordHash = SHA2(NEW.PasswordHash, 256);
END //

DELIMITER ;

DELIMITER //
-- Create a trigger that will add user database restrictions 
CREATE TRIGGER addUserRestrictions
AFTER INSERT ON EmpLogin
FOR EACH ROW
BEGIN 
    IF employee.RoleID = 1 THEN
        DECLARE @username varchar(50)
        SET @username = CAST((select top(1) username from Payroll.EmpLogin order by CreatedAt desc) AS varchar)
        CREATE USER IF NOT EXISTS @username@'localhost'
        GRANT Payroll.* to @username@localhost WITH GRANT OPTION;
    
    IF employee.RoleID = 2 THEN
        DECLARE @username varchar(50)
        SET @username = CAST((select top(1) username from Payroll.EmpLogin order by CreatedAt desc) AS varchar)
        CREATE USER IF NOT EXISTS @username@'localhost'
        GRANT Payroll. to @username@localhost WITH GRANT OPTION;
    
    IF employee.RoleID = 3 THEN
        DECLARE @username varchar(50)
        SET @username = CAST((select top(1) username from Payroll.EmpLogin order by CreatedAt desc) AS varchar)
        CREATE USER IF NOT EXISTS @username@'localhost'

    IF employee.RoleID = 4 THEN
        DECLARE @username varchar(50)
        SET @username = CAST((select top(1) username from Payroll.EmpLogin order by CreatedAt desc) AS varchar)
        CREATE USER IF NOT EXISTS @username@'localhost'


    END IF



DELIMITER ;