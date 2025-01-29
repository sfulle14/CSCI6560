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
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UpdatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
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
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UpdatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

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
    Salt varchar(32) not null,
    FailedLoginAttempts int DEFAULT 0,
    LastFailedLogin TIMESTAMP,
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UpdatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CompositeHash varchar(256) GENERATED ALWAYS AS (SHA2(CONCAT(Username, PasswordHash, Salt), 256)) STORED,

    INDEX idx_login_employee (EmployeeID),
    INDEX idx_login_username (Username)
);

-- Create the table if it does not already exist
-- previous payments view will be restricted by employeeID
CREATE TABLE IF NOT EXISTS PaymentHistory (
	PaymentHistoryID int PRIMARY KEY AUTO_INCREMENT,
    EmployeeID int not null,
    PaymentDate TIMESTAMP not null,
    Amount DECIMAL(10,2) not null,
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    INDEX idx_payment_employee (EmployeeID),
    INDEX idx_payment_date (PaymentDate)
);

-- Create the table if it does not already exist
-- will be a list of employees and their salaries
CREATE TABLE IF NOT EXISTS Salary (
	SalaryID int PRIMARY KEY AUTO_INCREMENT,
    EmployeeID int not null,
    Salary DECIMAL(10,2) not null,
    EffectiveDate TIMESTAMP not null,
    EndDate TIMESTAMP,
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UpdatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CreatedBy int not null,  -- EmployeeID who created this record

    INDEX idx_salary_employee (EmployeeID),
    INDEX idx_salary_dates (EffectiveDate, EndDate)
);

-- Audit table to track changes in the database
CREATE TABLE IF NOT EXISTS AuditLog (
    AuditID int PRIMARY KEY AUTO_INCREMENT,
    EmployeeID int not null,  -- Who performed the action
    ActionType ENUM('INSERT', 'UPDATE', 'DELETE', 'VIEW', 'LOGIN', 'FAILED_LOGIN') not null,
    TableAffected varchar(50) not null,
    SourceTableID int not null,
    OldValue JSON,  -- Store old values in JSON format
    NewValue JSON,  -- Store new values in JSON format
    Timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    INDEX idx_audit_employee (EmployeeID),
    INDEX idx_audit_action (ActionType),
    INDEX idx_audit_timestamp (Timestamp)
);

-- Session tracking table for additional security
-- view login and logout times
CREATE TABLE IF NOT EXISTS UserSessions (
    SessionID varchar(64) PRIMARY KEY,
    EmployeeID int not null,
    LoginTime TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    LastActivityTime TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    ExpiryTime TIMESTAMP not null,
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
