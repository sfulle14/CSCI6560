-- Tell the program which database to use to ensure to correct one is being worked on
USE Payroll;

INSERT INTO Employee
(
    EmployeeID
    ,FirstName
    ,LastName
    ,Address
    ,ssn
    ,PhoneNumber
    ,RoleID
    ,ManagerEmpID
)
VALUE
(
    Default
    ,'Donald'
    ,'Duck'
    ,'13 Quack St.'
    ,AES_ENCRYPT('123456789','6560')
    ,6155551234
    ,1
    ,NULL
);
