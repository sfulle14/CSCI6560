-- Tell the program which database to use to ensure to correct one is being worked on
USE Payroll;

INSERT INTO Salary
(
    SalaryID
    ,EmployeeID
    ,Salary
    ,EffectiveDate
    ,EndDate
    ,CreatedAt
    ,CreatedBy
    ,UpdatedAt
)
VALUE
(
    Default
    ,1
    ,100.00
    ,CURRENT_TIMESTAMP
    ,NULL
    ,CURRENT_TIMESTAMP
    ,1
    ,CURRENT_TIMESTAMP
);