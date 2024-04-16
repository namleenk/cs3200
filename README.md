# README
The backend of our application consists of three SQL files, `animal_shelter.sql`, `insert_data.sql`, and `procedures.sql`. To initialize the database, run `animal_shelter.sql` to create the tables, then `insert_data.sql` to insert the records, and then `procedures.sql` to create the necessary triggers and procedures.

The folder `database-front-end` contains all the necessary code for the front-end application. You can run `frontend.py` entirely on the command 
line. It should first prompt you for a username and password, this should be 'root' for the username and your password for MySQL server. After that, you are connected to the MySQL database and can run the application as intended. 

There are four different views for our database: new visitor, returning visitor, staff, and manager. The only operation new visitors can do is enter in personal information in order to create an account. For the three other views, after selecting a certain one, the application will print a list of actions you can do.
