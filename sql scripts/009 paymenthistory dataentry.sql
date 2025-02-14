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
    ,"1900-01-01 09:00:00"
    ,100.00
    ,CURRENT_TIMESTAMP
);

