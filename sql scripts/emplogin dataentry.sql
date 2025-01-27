-- Tell the program which database to use to ensure to correct one is being worked on
USE Payroll;

INSERT INTO EmpLogin
(
    LoginID
    ,EmployeeID
    ,username
    ,password
)
VALUE
(
    Default
    ,1
    ,'admin'
    ,'password'
);
