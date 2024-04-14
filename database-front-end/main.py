#!/usr/bin/env python3
from datetime import datetime
import pymysql
from pymysql import cursors


def run():
    # creating connection
    db_username = input("Please enter a username:\t")
    db_password = input("Please enter a password:\t")
    try:
        connection = pymysql.connect(host='localhost', user=db_username, password=db_password,
                                     db='animal_shelter', charset='utf8mb4', cursorclass=pymysql.cursors.DictCursor)
        cursor = connection.cursor()
        print('Connection successful')
    except BaseException:
        print("Connection unsuccessful. Please check your username/password and try again.")
        return
    
    # 3 different views: New visitor, staff member, returning visitor
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
        # VISITOR VIEW (RETURNING)
        elif view_type == "returning":
            successful_login = True
            print("Please enter your email and password")
            email = input("Email:\t")
            password = input("Password:\t")

        # NEW VISITOR VIEW
        elif view_type == "new":
            successful_login = True
            print("Please provide your name, date of birth, email, a new password, and address." +
                    "Your address must consist of a street number, street name, city, state abbreviation, and zip code")
            new_name = input("Name:\t")

            # handle incorrect dob format
            dob_format = False
            while (not dob_format):
                new_dob = input("Date of birth (YYYY-MM-DD):\t")
                try:
                    datetime.strptime (new_dob, "%Y-%m-%d").date()
                    new_dob = datetime.strptime (new_dob, "%Y-%m-%d").date()
                    dob_format = True
                except ValueError:
                    print("Please make sure date is entered in the format YYYY-MM-DD")

            new_email = input("Email:\t")
            new_pswd = input("New password: \t")
            new_street_num = input("Street number: \t")
            new_street_name = input("Street name: \t")
            new_city = input("City: \t")

            # handle incorrect state input length
            state_len = False
            while (not state_len):
                new_state = input("State (abbrev to 2 characters): \t")
                if (len(new_state) != 2):
                    print("Please make sure the state is abbreviated to 2 characters")
                else:
                    state_len = True
            
            # handle incorrect zipcode input length
            zipcode_len = False
            while (not zipcode_len):
                new_zipcode = input("Zipcode (must be 5 characters): \t")
                if (len(new_zipcode) != 5):
                    print("Please make sure the zipcode is 5 characters")
                else:
                    zipcode_len = True

            # call the procedure new visitor to create a new visitor with the inputted credentials
            try:
                cursor.callproc("new_visitor", (new_name, new_dob, new_email, new_pswd, int(new_street_num), new_street_name, new_city, new_state, new_zipcode))
                # commit() actually makes the changes to the backend database
                connection.commit()
            except pymysql.Error as e:
                code, msg = e.args
                print("Error calling new_visitor procedure", code, msg)
            # if information is all there
            print("Your account has been successfully created. Please log out and log in as a returning visitor.")

        else:
            print("\nDid not recognize that type of login. Please retry")



if __name__ == '__main__':
    run()
