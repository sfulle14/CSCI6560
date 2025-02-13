-- Tell the program which database to use to ensure to correct one is being worked on
USE Payroll;

SET @SecurityKey = '6560';

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
    ,CreatedAt
    ,UpdatedAt
)
VALUES
(
    Default
    ,'Donald'
    ,'Duck'
    ,'13 Quack St.'
    ,AES_ENCRYPT('123456789',@SecurityKey)
    ,'6155551234'
    ,1
    ,NULL
    ,CURRENT_TIMESTAMP
    ,CURRENT_TIMESTAMP
);

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
    ,CreatedAt
    ,UpdatedAt
)
VALUES
(
    Default
    ,'Mickey'
    ,'Mouse'
    ,'42 Disney Lane'
    ,AES_ENCRYPT('987654321',@SecurityKey)
    ,'6155552345'
    ,2
    ,1
    ,CURRENT_TIMESTAMP
    ,CURRENT_TIMESTAMP
);

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
    ,CreatedAt
    ,UpdatedAt
)
VALUES
(
    Default
    ,'Minnie'
    ,'Mouse'
    ,'42 Disney Lane'
    ,AES_ENCRYPT('456789123',@SecurityKey)
    ,'6155553456'
    ,3
    ,1
    ,CURRENT_TIMESTAMP
    ,CURRENT_TIMESTAMP
);

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
    ,CreatedAt
    ,UpdatedAt
)
VALUES
(
    Default
    ,'Goofy'
    ,'Goof'
    ,'123 Goof Troop Ave'
    ,AES_ENCRYPT('789123456',@SecurityKey)
    ,'6155554567'
    ,2
    ,1
    ,CURRENT_TIMESTAMP
    ,CURRENT_TIMESTAMP
);

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
    ,CreatedAt
    ,UpdatedAt
)
VALUES
(
    Default
    ,'Daisy'
    ,'Duck'
    ,'14 Quack St.'
    ,AES_ENCRYPT('321654987',@SecurityKey)
    ,'6155555678'
    ,3
    ,1
    ,CURRENT_TIMESTAMP
    ,CURRENT_TIMESTAMP
);

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
    ,CreatedAt
    ,UpdatedAt
)
VALUES
(
    Default
    ,'Pete'
    ,'Cat'
    ,'666 Trouble Way'
    ,AES_ENCRYPT('147258369',@SecurityKey)
    ,'6155556789'
    ,2
    ,2
    ,CURRENT_TIMESTAMP
    ,CURRENT_TIMESTAMP
);

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
    ,CreatedAt
    ,UpdatedAt
)
VALUES
(
    Default
    ,'Pluto'
    ,'Dog'
    ,'42 Disney Lane'
    ,AES_ENCRYPT('963852741',@SecurityKey)
    ,'6155557890'
    ,4
    ,2
    ,CURRENT_TIMESTAMP
    ,CURRENT_TIMESTAMP
);

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
    ,CreatedAt
    ,UpdatedAt
)
VALUES
(
    Default
    ,'Clarabelle'
    ,'Cow'
    ,'789 Farmyard Road'
    ,AES_ENCRYPT('852963741',@SecurityKey)
    ,'6155558901'
    ,3
    ,2
    ,CURRENT_TIMESTAMP
    ,CURRENT_TIMESTAMP
);

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
    ,CreatedAt
    ,UpdatedAt
)
VALUES
(
    Default
    ,'Horace'
    ,'Horsecollar'
    ,'456 Stable Street'
    ,AES_ENCRYPT('741852963',@SecurityKey)
    ,'6155559012'
    ,2
    ,3
    ,CURRENT_TIMESTAMP
    ,CURRENT_TIMESTAMP
);

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
    ,CreatedAt
    ,UpdatedAt
)
VALUES
(
    Default
    ,'Max'
    ,'Goof'
    ,'123 Goof Troop Ave'
    ,AES_ENCRYPT('369147258',@SecurityKey)
    ,'6155550123'
    ,1
    ,3
    ,CURRENT_TIMESTAMP
    ,CURRENT_TIMESTAMP
);
