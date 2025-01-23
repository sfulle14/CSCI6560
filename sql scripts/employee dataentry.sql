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
    ,1236545660789 -- salt char(3) + 65 + char(3) + 60 + char(3)
    ,6155551234
    ,1
    ,NULL
);
