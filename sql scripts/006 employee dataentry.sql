-- Tell the program which database to use to ensure to correct one is being worked on
USE Payroll;

SET @SecurityKey = '6560';

-- admin
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
    ,AES_ENCRYPT(caesar_encrypt('123456789', 3), @SecurityKey)
    ,'6155551234'
    ,1
    ,NULL
    ,CURRENT_TIMESTAMP
    ,CURRENT_TIMESTAMP
);

-- manager
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
    ,AES_ENCRYPT(caesar_encrypt('987654321',3), @SecurityKey)
    ,'6155552345'
    ,2
    ,NULL
    ,CURRENT_TIMESTAMP
    ,CURRENT_TIMESTAMP
);


-- manager
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
    ,AES_ENCRYPT(caesar_encrypt('741852963',3), @SecurityKey)
    ,'6155559012'
    ,2
    ,NULL
    ,CURRENT_TIMESTAMP
    ,CURRENT_TIMESTAMP
);

-- manager
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
    ,AES_ENCRYPT(caesar_encrypt('789123456',3), @SecurityKey)
    ,'6155554567'
    ,2
    ,NULL
    ,CURRENT_TIMESTAMP
    ,CURRENT_TIMESTAMP
);

-- hr
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
    ,AES_ENCRYPT(caesar_encrypt('147258369',3), @SecurityKey)
    ,'6155556789'
    ,3
    ,2
    ,CURRENT_TIMESTAMP
    ,CURRENT_TIMESTAMP
);

-- hr
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
    ,AES_ENCRYPT(caesar_encrypt('456789123',3), @SecurityKey)
    ,'6155553456'
    ,3
    ,2
    ,CURRENT_TIMESTAMP
    ,CURRENT_TIMESTAMP
);

-- employee
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
    ,AES_ENCRYPT(caesar_encrypt('321654987',3), @SecurityKey)
    ,'6155555678'
    ,4
    ,3
    ,CURRENT_TIMESTAMP
    ,CURRENT_TIMESTAMP
);


-- employee
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
    ,AES_ENCRYPT(caesar_encrypt('963852741',3), @SecurityKey)
    ,'6155557890'
    ,4
    ,2
    ,CURRENT_TIMESTAMP
    ,CURRENT_TIMESTAMP
);

-- employee
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
    ,AES_ENCRYPT(caesar_encrypt('852963741',3), @SecurityKey)
    ,'6155558901'
    ,4
    ,3
    ,CURRENT_TIMESTAMP
    ,CURRENT_TIMESTAMP
);

-- employee
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
    ,AES_ENCRYPT(caesar_encrypt('369147258',3), @SecurityKey)
    ,'6155550123'
    ,4
    ,4
    ,CURRENT_TIMESTAMP
    ,CURRENT_TIMESTAMP
);
