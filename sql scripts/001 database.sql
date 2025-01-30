-- Create a database to use if one does not already exist
CREATE DATABASE IF NOT EXISTS Payroll;

-- Tell the program which database to use to ensure to correct one is being worked on
USE Payroll;

-- Create the table if it does not already exist
-- roles will be used to determine access
CREATE TABLE IF NOT EXISTS Role (
	RoleID int PRIMARY KEY AUTO_INCREMENT,
    RoleName varchar(50) NOT NULL,
    Description varchar(255),
    CreatedAt datetime DEFAULT CURRENT_TIMESTAMP,
    UpdatedAt datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Create the table if it does not already exist
-- list of employees that are in the company
CREATE TABLE IF NOT EXISTS Employee (
	EmployeeID int PRIMARY KEY AUTO_INCREMENT,
    FirstName varchar(50) not null,
    LastName varchar(50) not null,
    Address varchar(255),
    ssn varbinary(256) not null,
    PhoneNumber char(10),
    RoleID int not null,
    ManagerEmpID int,    -- used to track who an employees manager i
    CreatedAt datetime DEFAULT CURRENT_TIMESTAMP,
    UpdatedAt datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    INDEX idx_employee_role (RoleID),
    INDEX idx_employee_manager (ManagerEmpID)
);

-- login table will have to hash passwords on insert
-- will create a composit hash of password and username for extra login verification
CREATE TABLE IF NOT EXISTS EmpLogin (
	LoginID int PRIMARY KEY AUTO_INCREMENT,
    EmployeeID int not null,
    Username varchar(50) not null UNIQUE,
    PasswordHash varchar(64) not null,  -- For SHA-256 hashed passwords
    Salt varchar(32) not null,  -- used to salt the password for each user
    FailedLoginAttempts int DEFAULT 0,
    LastFailedLogin datetime,
    CreatedAt datetime DEFAULT CURRENT_TIMESTAMP,
    UpdatedAt datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CompositeHash varchar(256) GENERATED ALWAYS AS (SHA2(CONCAT(Username, PasswordHash, Salt), 256)) STORED,

    INDEX idx_login_employee (EmployeeID),
    INDEX idx_login_username (Username)
);

-- Create the table if it does not already exist
-- previous payments view will be restricted by employeeID
CREATE TABLE IF NOT EXISTS PaymentHistory (
	PaymentHistoryID int PRIMARY KEY AUTO_INCREMENT,
    EmployeeID int not null,
    PaymentDate datetime not null,
    Amount DECIMAL(10,2) not null,
    CreatedAt datetime DEFAULT CURRENT_TIMESTAMP,

    INDEX idx_payment_employee (EmployeeID),
    INDEX idx_payment_date (PaymentDate)
);

-- Create the table if it does not already exist
-- will be a list of employees and their salaries
CREATE TABLE IF NOT EXISTS Salary (
	SalaryID int PRIMARY KEY AUTO_INCREMENT,
    EmployeeID int not null,
    Salary DECIMAL(10,2) not null,
    EffectiveDate datetime not null,
    EndDate datetime,
    CreatedAt datetime DEFAULT CURRENT_TIMESTAMP,
    CreatedBy int not null,  -- EmployeeID who created this record
    UpdatedAt datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    INDEX idx_salary_employee (EmployeeID),
    INDEX idx_salary_dates (EffectiveDate, EndDate)
);

-- Audit table to track changes in the database
-- We will not have data entry scripts here 
-- this is a table to track changes made by users
CREATE TABLE IF NOT EXISTS AuditLog (
    AuditID int PRIMARY KEY AUTO_INCREMENT,
    EmployeeID int not null,  -- Who performed the action
    ActionType ENUM('INSERT', 'UPDATE', 'DELETE', 'VIEW', 'LOGIN', 'FAILED_LOGIN') not null,
    TableAffected varchar(50) not null,
    SourceTableID int not null,
    OldValue JSON,  -- Store old values in JSON format
    NewValue JSON,  -- Store new values in JSON format
    Timestamp datetime DEFAULT CURRENT_TIMESTAMP,

    INDEX idx_audit_employee (EmployeeID),
    INDEX idx_audit_action (ActionType),
    INDEX idx_audit_timestamp (Timestamp)
);

-- Session tracking table for additional security
-- We will not have data entry scripts here 
-- this is a table to track logins
CREATE TABLE IF NOT EXISTS UserSessions (
    SessionID varchar(64) PRIMARY KEY,
    EmployeeID int not null,
    LoginTime datetime DEFAULT CURRENT_TIMESTAMP,
    LastActivityTime datetime DEFAULT CURRENT_TIMESTAMP,
    ExpiryTime datetime not null,
    IPAddress varchar(45),
    UserAgent varchar(255),
    IsActive BOOLEAN DEFAULT true,

    INDEX idx_session_employee (EmployeeID),
    INDEX idx_session_activity (LastActivityTime)
);

-- Add the Foreign key constraints
ALTER TABLE Employee 
    ADD CONSTRAINT fk_employee_role FOREIGN KEY (RoleID) REFERENCES Role(RoleID),
    ADD CONSTRAINT fk_employee_manager FOREIGN KEY (ManagerEmpID) REFERENCES Employee(EmployeeID);

ALTER TABLE EmpLogin 
    ADD CONSTRAINT fk_login_employee FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID);

ALTER TABLE PaymentHistory 
    ADD CONSTRAINT fk_payment_employee FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID);

ALTER TABLE Salary 
    ADD CONSTRAINT fk_salary_employee FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID),
    ADD CONSTRAINT fk_salary_creator FOREIGN KEY (CreatedBy) REFERENCES Employee(EmployeeID);

ALTER TABLE AuditLog 
    ADD CONSTRAINT fk_audit_employee FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID);

ALTER TABLE UserSessions 
    ADD CONSTRAINT fk_session_employee FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID);


-- Create views for role-based access control
-- this is a view of the employee's information
CREATE OR REPLACE VIEW vw_employee_basic AS
SELECT 
    e.EmployeeID,
    e.FirstName,
    e.LastName,
    e.PhoneNumber,
    e.RoleID,
    r.RoleName
FROM Employee e
JOIN Role r ON e.RoleID = r.RoleID;


-- Create view for HR personnel (includes sensitive data)
-- this is a view of the employee's info and salary for HR
CREATE OR REPLACE VIEW vw_employee_hr AS
SELECT 
    e.*,
    r.RoleName,
    s.Salary
FROM Employee e
JOIN Role r ON e.RoleID = r.RoleID
LEFT JOIN Salary s ON e.EmployeeID = s.EmployeeID
WHERE s.EndDate IS NULL;


-- Create stored procedures for secure data access
DELIMITER //

-- Procedure to safely retrieve SSN (should be called only with appropriate permissions)
-- This is a database way to limit who can have access to the SSNs
CREATE PROCEDURE sp_get_employee_ssn(
    IN p_requester_id INT,      -- ID of employee requesting the SSN
    IN p_target_employee_id INT, -- ID of employee whose SSN is being requested
    OUT p_ssn VARBINARY(256)    -- Variable to store the retrieved SSN
)
BEGIN
    DECLARE v_requester_role INT;
    
    -- Get requester's role to be verified later
    SELECT RoleID INTO v_requester_role 
    FROM Employee 
    WHERE EmployeeID = p_requester_id;
    
    -- Only allow HR role (assuming RoleID 3 is HR) to access SSN
    -- This is how we limit who can access data by role in the DB
    IF v_requester_role = 3 THEN
        SELECT ssn INTO p_ssn
        FROM Employee
        WHERE EmployeeID = p_target_employee_id;
        
        -- Log the access
        INSERT INTO AuditLog (EmployeeID, ActionType, TableAffected, RecordID)
        VALUES (p_requester_id, 'VIEW', 'Employee', p_target_employee_id);
    ELSE
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Access Denied: Insufficient privileges';
    END IF;
END //

-- Procedure to safely retrieve salary (should be called only with appropriate permissions)
-- This is a database way to limit who can have access to the salaries
CREATE PROCEDURE sp_get_employee_salary(
    IN p_requester_id INT,      -- ID of employee requesting the salary
    IN p_target_employee_id INT, -- ID of employee whose salary is being requested
    OUT p_salary int    -- Variable to store the retrieved salary
)
BEGIN
    DECLARE v_requester_role INT;
    
    -- Get requester's role to be verified later
    SELECT RoleID INTO v_requester_role 
    FROM Employee 
    WHERE EmployeeID = p_requester_id;
    
    -- Only allow HR role (assuming RoleID 2 is HR) to access SSN
    -- This is how we limit who can access data by role in the DB
    IF v_requester_role = 2 THEN
        SELECT salary INTO p_salary
        FROM Employee
        WHERE EmployeeID = p_target_employee_id;
        
        -- Log the access
        INSERT INTO AuditLog (EmployeeID, ActionType, TableAffected, RecordID)
        VALUES (p_requester_id, 'VIEW', 'Employee', p_target_employee_id);
    ELSE
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Access Denied: Insufficient privileges';
    END IF;
END //

-- Procedure to update password with security checks
CREATE PROCEDURE sp_update_password(
    IN p_employee_id INT,   -- ID of emp trying to change password
    IN p_new_password VARCHAR(64),  -- the new password to be stored
    IN p_new_salt VARCHAR(32)   -- value to salt password with
)
BEGIN
    DECLARE v_last_change datetime;    -- variable to hold last password change date
    
    -- Get last password change date and store it in v_last_change
    SELECT LastPasswordChange INTO v_last_change
    FROM EmpLogin
    WHERE EmployeeID = p_employee_id;
    
    -- Ensure password hasn't been changed too recently (e.g., last 24 hours)
    IF v_last_change > NOW() - INTERVAL 24 HOUR THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Password was changed too recently';
    ELSE
        UPDATE EmpLogin
        SET PasswordHash = p_new_password,
            Salt = p_new_salt,
            LastPasswordChange = CURRENT_TIMESTAMP,
            FailedLoginAttempts = 0,
            AccountLocked = false
        WHERE EmployeeID = p_employee_id;
    END IF;
END //

DELIMITER ;

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

