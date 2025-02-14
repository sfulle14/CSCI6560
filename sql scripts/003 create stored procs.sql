
-- Create stored procedures for secure data access
DELIMITER //

-- Procedure to safely retrieve SSN (should be called only with appropriate permissions)
-- This is a database way to limit who can have access to the SSNs
CREATE PROCEDURE sp_get_employee_ssn(
    IN p_requester_id INT,      -- ID of employee requesting the SSN
    IN p_target_employee_id INT, -- ID of employee whose SSN is being requested
    OUT p_ssn VARBINARY(256)    -- Variable to store the retrieved SSN
)
BEGIN
    DECLARE v_requester_role INT;
    
    -- Get requester's role to be verified later
    SELECT RoleID INTO v_requester_role 
    FROM Employee 
    WHERE EmployeeID = p_requester_id;
    
    -- Only allow HR role (assuming RoleID 3 is HR) to access SSN
    -- This is how we limit who can access data by role in the DB
    IF v_requester_role = 3 THEN
        SELECT ssn INTO p_ssn
        FROM Employee
        WHERE EmployeeID = p_target_employee_id;
        
        -- Log the access
        INSERT INTO AuditLog (EmployeeID, ActionType, TableAffected, RecordID)
        VALUES (p_requester_id, 'VIEW', 'Employee', p_target_employee_id);
    ELSE
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Access Denied: Insufficient privileges';
    END IF;
END //

-- Procedure to safely retrieve salary (should be called only with appropriate permissions)
-- This is a database way to limit who can have access to the salaries
CREATE PROCEDURE sp_get_employee_salary(
    IN p_requester_id INT,      -- ID of employee requesting the salary
    IN p_target_employee_id INT, -- ID of employee whose salary is being requested
    OUT p_salary int    -- Variable to store the retrieved salary
)
BEGIN
    DECLARE v_requester_role INT;
    
    -- Get requester's role to be verified later
    SELECT RoleID INTO v_requester_role 
    FROM Employee 
    WHERE EmployeeID = p_requester_id;
    
    -- Only allow HR role (assuming RoleID 2 is HR) to access SSN
    -- This is how we limit who can access data by role in the DB
    IF v_requester_role = 3 THEN
        SELECT salary INTO p_salary
        FROM Employee
        WHERE EmployeeID = p_target_employee_id;
        
        -- Log the access
        INSERT INTO AuditLog (EmployeeID, ActionType, TableAffected, RecordID)
        VALUES (p_requester_id, 'VIEW', 'Employee', p_target_employee_id);
    ELSE
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Access Denied: Insufficient privileges';
    END IF;
END //

-- Procedure to update password with security checks
CREATE PROCEDURE sp_update_password(
    IN p_employee_id INT,   -- ID of emp trying to change password
    IN p_new_password VARCHAR(64),  -- the new password to be stored
    IN p_new_salt VARCHAR(32)   -- value to salt password with
)
BEGIN
    DECLARE v_last_change datetime;    -- variable to hold last password change date
    
    -- Get last password change date and store it in v_last_change
    SELECT LastPasswordChange INTO v_last_change
    FROM EmpLogin
    WHERE EmployeeID = p_employee_id;
    
    -- Ensure password hasn't been changed too recently (e.g., last 24 hours)
    IF v_last_change > NOW() - INTERVAL 24 HOUR THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Password was changed too recently';
    ELSE
        UPDATE EmpLogin
        SET PasswordHash = p_new_password,
            Salt = p_new_salt,
            LastPasswordChange = CURRENT_TIMESTAMP,
            FailedLoginAttempts = 0,
            AccountLocked = false
        WHERE EmployeeID = p_employee_id;
    END IF;
END //

DELIMITER ;
