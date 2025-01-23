-- Tell the program which database to use to ensure to correct one is being worked on
USE Payroll;

INSERT INTO EmpLogin
(
    LoginID
    ,EmployeeID
    ,username
    ,password
    ,CompositeHash
)
VALUE
(
    Default
    ,4
    ,'admin'
    ,'password'
    ,SHA2(CONCAT(username, password), 256)
);

