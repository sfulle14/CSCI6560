#!/bin/bash

# MySQL connection details
MYSQL_USER="root"
MYSQL_PASSWORD="password"
MYSQL_HOST="localhost"

# Directory containing SQL scripts
SQL_SCRIPTS_DIR="sql scripts"

# Check if the directory exists
if [ ! -d "$SQL_SCRIPTS_DIR" ]; then
    echo "Error: Directory '$SQL_SCRIPTS_DIR' not found!"
    exit 1
fi

# Loop through all .sql files in the directory in sorted order
while IFS= read -r script; do
    if [ -f "$script" ]; then
        echo "Executing $script..."
        mysql -h "$MYSQL_HOST" -u "$MYSQL_USER" --password="$MYSQL_PASSWORD" < "$script"
        
        # Check if the script executed successfully
        if [ $? -eq 0 ]; then
            echo "Successfully executed $script"
        else
            echo "Error executing $script"
        fi
        echo "----------------------------------------"
    fi
done < <(find "$SQL_SCRIPTS_DIR" -name "*.sql" | sort)

echo "All SQL scripts have been processed." 