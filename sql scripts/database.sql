-- Create a database to use if one does not already exist
CREATE DATABASE IF NOT EXISTS Payroll;

-- Tell the program which database to use to ensure to correct one is being worked on
USE Payroll;

-- Create the table if it does not alread exist
-- roles will be used to determine access
CREATE TABLE IF NOT EXISTS Role (
	RoleID int PRIMARY KEY AUTO_INCREMENT,
    RoleName varchar(50) NOT NULL
);

-- Create the table if it does not alread exist
-- list of employees that are in the company
CREATE TABLE IF NOT EXISTS Employee (
	EmployeeID int PRIMARY KEY AUTO_INCREMENT,
    FirstName varchar(50) not null,
    LastName varchar(50) not null,
    Address varchar(255),
    ssn varbinary(200),
    PhoneNumber char(10),
    RoleID int not null,
    ManagerEmpID int 	-- used to track who an employees manager is
);

-- login table will have to hash passwords on insert
-- will create a composit hash of password and username for extra login verification
CREATE TABLE IF NOT EXISTS EmpLogin (
	loginID int PRIMARY KEY AUTO_INCREMENT,
    EmployeeID int not null,
    username varchar(20) not null UNIQUE,
    password varchar(32)
);

-- Create the table if it does not alread exist
-- previous payments view will be restricted by employeeID
CREATE TABLE IF NOT EXISTS PaymentHistory (
	PaymentHistoryID int PRIMARY KEY AUTO_INCREMENT,
    EmployeeID int not null,
    Date datetime not null
);

-- Create the table if it does not alread exist
-- will be a list of employees and their salaries
CREATE TABLE IF NOT EXISTS Salary (
	SalaryID int PRIMARY KEY AUTO_INCREMENT,
    EmployeeId int not null,
    Salary int not null 
);



-- Add the Foreign key contraints to each of the foreign key references
ALTER TABLE Employee ADD CONSTRAINT FOREIGN KEY (RoleID)  REFERENCES Role(RoleID);
ALTER TABLE PaymentHistory ADD CONSTRAINT FOREIGN KEY (EmployeeID)  REFERENCES Employee(EmployeeID);
ALTER TABLE Salary ADD CONSTRAINT FOREIGN KEY (EmployeeID)  REFERENCES Employee(EmployeeID);
ALTER TABLE EmpLogin ADD CONSTRAINT FOREIGN KEY (EmployeeID)  REFERENCES Employee(EmployeeID);
ALTER TABLE Employee ADD CONSTRAINT FOREIGN KEY (ManagerEmpID)  REFERENCES Employee(EmployeeID);

-- Add a column that will be the hash of 2 existing columns
ALTER TABLE EmpLogin ADD COLUMN CompositeHash varchar(256) GENERATED ALWAYS AS (SHA2(CONCAT(username, password), 256));

