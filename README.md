# README
The backend of our application consists of three sql files, animal_shelter.sql, insert_data.sql, and procedures.sql. To initialize the database, run animal_shelter.sql to create the tables, then insert_data.sql to insert the records, then procedures.sql to create the neccessary triggers and procedures.

The folder database-front-end contains all necessary code for the front-end application. You can run frontend.py entirely on the command 
line. It should first prompt you for a username and password, this should be 'root' for the username and your password for MySQL server. After that, you are connected to MySQL and can run the application as intended. 

There are four different views for our database: new visitor, returning visitor, staff, and manager. The only operation new visitors can do is enter in personal information in order to create an account. For the three other views, after selecting a certain one, the application
will print a list of actions you can do.
