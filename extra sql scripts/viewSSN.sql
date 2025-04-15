use payroll;
SET @SecretKey = '6560';

SELECT 
    EmployeeID,
    FirstName,
    LastName,
    ssn as Encrypted_SSN,
    caesar_decrypt(CAST(AES_DECRYPT(ssn, @SecretKey) AS CHAR(9)), 3) as DecryptedSSN
FROM Employee;
