# MySQL connection details
$MYSQL_USER = "root"
$MYSQL_PASSWORD = "password"
$MYSQL_HOST = "localhost"

# Directory containing SQL scripts
$SQL_SCRIPTS_DIR = "sql scripts"

# Check if the directory exists
if (!(Test-Path -Path $SQL_SCRIPTS_DIR)) {
    Write-Host "Error: Directory '$SQL_SCRIPTS_DIR' not found!"
    exit 1
}

# Get all .sql files and sort them
$scripts = Get-ChildItem -Path $SQL_SCRIPTS_DIR -Filter "*.sql" | Sort-Object Name

# Loop through the sorted scripts
foreach ($script in $scripts) {
    $scriptPath = $script.FullName
    Write-Host "Executing $scriptPath..."
    
    try {
        mysql -h $MYSQL_HOST -u $MYSQL_USER --password=$MYSQL_PASSWORD < $scriptPath
        if ($LASTEXITCODE -eq 0) {
            Write-Host "Successfully executed $scriptPath"
        } else {
            Write-Host "Error executing $scriptPath"
        }
    } catch {
        Write-Host "Error executing $scriptPath: $_"
    }
    Write-Host ("-" * 40)
}

Write-Host "All SQL scripts have been processed." 