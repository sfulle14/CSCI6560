# CSCI6560


### Links about SQL Hashing
* https://planetscale.com/blog/generated-hash-columns-in-mysql


### Links about SQL Encryption
* https://dev.mysql.com/doc/refman/8.4/en/encryption-functions.html
* https://www.geeksforgeeks.org/mysql-aes_encrypt-function/

### Links about Views
* https://www.w3schools.com/mysql/mysql_view.asp
* https://dev.mysql.com/doc/refman/8.4/en/views.html

### Links about Stored procedures
* https://www.w3schools.com/mysql/mysql_view.asp
* https://dev.mysql.com/doc/refman/8.4/en/views.html


### How to execute the shell script to run all SQL files in "sql scripts" folder
* make sure mysql is installed
* to install: 
    * For linux
        * sudo apt-get update
        * sudo apt-get install mysql-client
    * For Mac
        * brew install mysql
* Ensure file has execute ability
    * for mac,
        * chmod +x run_sql_scripts.sh
    * for windows,
        * chmod +x run_sql_scripts.ps1
* Navegate to folder the shell script is in
* Run,
    * for mac and linux,
        * ./run_sql_scripts.sh
    * For window,
        * ./run_sql_scripts.ps1