-- Tell the program which database to use to ensure to correct one is being worked on
USE Payroll;

INSERT INTO EmpLogin
(
    EmpLoginID
    ,EmployeeID
    ,username
    ,password
)
VALUE
(
    Default
    ,0
    ,''
    ,''
    ,SHA2(CONCAT(username, password), 256)
);
