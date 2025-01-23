-- Tell the program which database to use to ensure to correct one is being worked on
USE Payroll;

-- inserts a new role but will ignore if it already exsits 
INSERT IGNORE INTO Role
(
    RoleID
    ,RoleName
)
VALUE
(
    1,
    'Employee'
);

INSERT IGNORE INTO Role
(
    RoleID
    ,RoleName
)
VALUE
(
    2,
    'Manager'
);

INSERT IGNORE INTO Role
(
    RoleID
    ,RoleName
)
VALUE
(
    3,
    'HR'
);

INSERT IGNORE INTO Role
(
    RoleID
    ,RoleName
)
VALUE
(
    4
    ,'Admin'
);