use payroll;
SET @SecretKey = '6560';

SELECT 
    EmployeeID,
    FirstName,
    LastName,
    CAST(AES_DECRYPT(ssn, @SecretKey) AS CHAR(9)) as DecryptedSSN
FROM Employee;
