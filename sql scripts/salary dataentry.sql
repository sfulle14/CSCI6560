-- Tell the program which database to use to ensure to correct one is being worked on
USE Payroll;

INSERT INTO Salary
(
    SalaryID
    ,EmployeeID
    ,Salary
)
VALUE
(
    Default
    ,1
    ,1
);