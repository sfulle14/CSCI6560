<!DOCTYPE html>
<html lang="en">
    
<head>
    <!-- https://www.w3schools.com/php -->
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Payroll Management System</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="./static/style.css">
</head>

<body>
    <div class="container">
        <h1 class="text-center">Payroll Management System</h1> <!-- Title line -->
        <div class="row">
            <div class="col text-center">Login</div> 
        </div>

        <hr>
        
        <div class="row">
            <form action="insert_staff.php" method="POST">
                <label for="UserName">UserName:</label>
                <input type="text" id="UserName" name="UserName"><br><br>

                <label for="Password">Password:</label>
                <input type="text" id="Password" name="Password"><br><br>
            </form>
        </div>

    </div>
</body>
</html>
