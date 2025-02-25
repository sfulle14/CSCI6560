
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
WHERE 1=1;


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
WHERE 1=1
and s.EndDate IS NULL;


-- Create a view that will display the salary of all employees
CREATE OR REPLACE VIEW vw_salary_hr AS
SELECT
    e.FirstName
    ,e.LastName
    ,s.*
FROM Salary s
INNER JOIN Employee e on e.employeeID = s.employeeID
WHERE 1=1;