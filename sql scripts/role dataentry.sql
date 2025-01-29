-- Tell the program which database to use to ensure to correct one is being worked on
USE Payroll;

-- inserts a new role but will ignore if it already exsits 
INSERT IGNORE INTO Role
(
    RoleID
    ,RoleName
    ,Description
    ,CreatedAt
    ,UpdatedAt
)
VALUE
(
    1
    ,'Employee'
    ,''
    ,CURRENT_TIMESTAMP
    ,CURRENT_TIMESTAMP
);

INSERT IGNORE INTO Role
(
    RoleID
    ,RoleName
    ,Description
    ,CreatedAt
    ,UpdatedAtRoleID
    ,RoleName
)
VALUE
(
    2
    ,'Manager'
    ,''
    ,CURRENT_TIMESTAMP
    ,CURRENT_TIMESTAMP
);

INSERT IGNORE INTO Role
(
    RoleID
    ,RoleName
    ,Description
    ,CreatedAt
    ,UpdatedAt
)
VALUE
(
    3
    ,'HR'
    ,''
    ,CURRENT_TIMESTAMP
    ,CURRENT_TIMESTAMP
);

INSERT IGNORE INTO Role
(
    RoleID
    ,RoleName
    ,Description
    ,CreatedAt
    ,UpdatedAt
)
VALUE
(
    4
    ,'Admin'
    ,''
    ,CURRENT_TIMESTAMP
    ,CURRENT_TIMESTAMP
);