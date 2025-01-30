-- Tell the program which database to use to ensure to correct one is being worked on
USE Payroll;

INSERT INTO EmpLogin
(
    LoginID
    ,EmployeeID
    ,username
    ,PasswordHash
    ,Salt
    ,FailedLoginAttempts
    ,LastFailedLogin
    ,CreatedAt
    ,UpdatedAt
)
VALUE
(
    Default
    ,1
    ,'admin'
    ,'password'
    ,''
    ,0
    ,NULL
    ,CURRENT_TIMESTAMP
    ,CURRENT_TIMESTAMP
);
