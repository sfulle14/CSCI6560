<?php
session_start();
require_once "connect.php";

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $username = mysqli_real_escape_string($conn, $_POST['username']);
    $password = mysqli_real_escape_string($conn, $_POST['password']);
    
    // Calculate the composite hash
    $compositeHash = hash('sha256', $username . $password);
    
    // Prepare a select statement
    $sql = "SELECT loginID, EmployeeID FROM EmpLogin WHERE username = ? AND password = ? AND CompositeHash = ?";
    
    if ($stmt = mysqli_prepare($conn, $sql)) {
        // Bind variables to the prepared statement as parameters
        mysqli_stmt_bind_param($stmt, "sss", $username, $password, $compositeHash);
        
        // Attempt to execute the prepared statement
        if (mysqli_stmt_execute($stmt)) {
            // Store result
            mysqli_stmt_store_result($stmt);
            
            // Check if username exists
            if (mysqli_stmt_num_rows($stmt) == 1) {
                mysqli_stmt_bind_result($stmt, $loginID, $employeeID);
                if (mysqli_stmt_fetch($stmt)) {
                    // Password is correct, start a new session
                    session_start();
                    
                    // Store data in session variables
                    $_SESSION["loggedin"] = true;
                    $_SESSION["loginID"] = $loginID;
                    $_SESSION["employeeID"] = $employeeID;
                    $_SESSION["username"] = $username;
                    
                    // Redirect to welcome page
                    header("location: dashboard.php");
                }
            } else {
                // Display an error message if username doesn't exist
                $login_err = "Invalid username or password.";
                header("location: ../index.php?error=" . urlencode($login_err));
            }
        } else {
            $login_err = "Oops! Something went wrong. Please try again later.";
            header("location: ../index.php?error=" . urlencode($login_err));
        }

        // Close statement
        mysqli_stmt_close($stmt);
    }
    
    // Close connection
    mysqli_close($conn);
}
?> 