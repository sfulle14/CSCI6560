-- Tell the program which database to use to ensure to correct one is being worked on
USE Payroll;

INSERT INTO PaymentHistory
(
    PaymentHistoryID
    ,EmployeeID
    ,PaymentDate
    ,Amount
    ,CreatedAt
)
VALUE
(
    Default
    ,1
    ,01/01/1900
    ,100.00
    ,CURRENT_TIMESTAMP
);

