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
        
        <div class="row justify-content-center">
            <div class="col-md-6">
                <form action="front/verify_login.php" method="POST" class="form">
                    <div class="form-group">
                        <label for="username">Username:</label>
                        <input type="text" class="form-control" id="username" name="username" required>
                    </div>

                    <div class="form-group">
                        <label for="password">Password:</label>
                        <input type="password" class="form-control" id="password" name="password" required>
                    </div>

                    <div class="text-center">
                        <button type="submit" class="btn btn-primary">Login</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Scripts used to help with Bootstrap formatting -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
