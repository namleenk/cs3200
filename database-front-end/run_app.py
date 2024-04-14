#!/usr/bin/env python3
from datetime import datetime
import pymysql

def connect_to_db():
  # creating connection
    db_username = input("Please enter a username:\t")
    db_password = input("Please enter a password:\t")
    try:
        global connection
        connection = pymysql.connect(host='localhost', user=db_username, password=db_password,
                                     db='animal_shelter', charset='utf8mb4', cursorclass=pymysql.cursors.DictCursor)
        global cursor
        cursor = connection.cursor()
        print('Connection successful')
        return connection, cursor
    except BaseException:
        print("Connection unsuccessful. Please check your username/password and try again.")
        return None, None
    
# prompt the user for username and password
conn, cursor = connect_to_db()
if (conn is None or cursor is None):
  print ("The connection failed")
  quit()
else:
    successful_login = False
    while not successful_login:
        print("\nWelcome to Second Chance Animal Shelter. Are you a returning visitor, staff member, or new visitor?")
        view_type = input("Please enter 'staff', 'new', or 'returning':\t")

         # STAFF OR MANAGER VIEW
        if view_type == "staff":
          successful_login = True
          print("Please enter your username and password")
          username = input("Username:\t")
          password = input("Password:\t")
          # check if username is in manager table or not
          cursor.execute("select username from manager")
          all_managers = cursor.fetchall()
          # is this user a manager?
          all_manager_usernames = [list(x.values())[0] for x in all_managers]

          is_manager = username in all_manager_usernames
          # only if the user is manager, they can see all staffs' login information
          if (is_manager):
              print(all_managers, is_manager)
