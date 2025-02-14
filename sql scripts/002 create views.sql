
-- Create views for role-based access control
-- this is a view of the employee's information
CREATE OR REPLACE VIEW vw_employee_basic AS
SELECT 
    e.EmployeeID,
    e.FirstName,
    e.LastName,
    e.PhoneNumber,
    e.RoleID,
    r.RoleName
FROM Employee e
JOIN Role r ON e.RoleID = r.RoleID;


-- Create view for HR personnel (includes sensitive data)
-- this is a view of the employee's info and salary for HR
CREATE OR REPLACE VIEW vw_employee_hr AS
SELECT 
    e.*,
    r.RoleName,
    s.Salary
FROM Employee e
JOIN Role r ON e.RoleID = r.RoleID
LEFT JOIN Salary s ON e.EmployeeID = s.EmployeeID
WHERE s.EndDate IS NULL;
