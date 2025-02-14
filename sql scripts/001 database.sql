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
    PasswordHash varchar(64) not null,  -- For SHA-256 hashed passwords these would need to be inserted hashed
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


