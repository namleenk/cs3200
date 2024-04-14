#!/usr/bin/env python3
from datetime import datetime
import pymysql
from pymysql import cursors


# prints the list of actions a staff can do
def staff_action_options():
    # show the staff user what they can do
    print("As a staff member you can do the following:\n" +
            "1. See all shelter animals (see_shelter_animals)\n" +
            "2. Look up an animal's adoption status (look_up_animal)\n" +
            "3. Look at a visitor's application status (see_app_status)\n" +
            "4. Look at shelter statistics (see_stats)\n" +
            "5. Add a new animal to the shelter (add_new_animal)\n" +
            "6. Make a new appointment for an animal (make_appt)\n" +
            "\nSimply type the shorthand in parathesis of the action you want to do and you will get further instructions")

    
def run():
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
            
            # present the user with the action options
            staff_action_options()
            staff_action = input("Pick an action to do:\t")
            
            # handle staff action
            
            #if see shelter animal --> call procedure see_shelter_animals(), no input needed
            if (staff_action == "see_shelter_animals"):
                cursor.callproc("see_shelter_animals")
                all_shelter_animals = cursor.fetchall()
                for row in all_shelter_animals:
                    print(row)

            # if look up animal --> prompt for animal name or animal id, call lookup_animal with either input
            elif (staff_action == "look_up_animal"):
                print ("Please enter the animal's name and id. If you don't know one of them, just hit enter")
                animal_name = input("Animal name:\t")
                animal_id = input("Animal id:\t")

                # if user does not know, SQL gets null value for that attribute
                if (animal_name == ""):
                    animal_name = None
                if (animal_id == ""):
                    animal_id = None
                    
                try:
                    cursor.callproc("lookup_animal", (animal_name, animal_id))
                    print(cursor.fetchall())
                except pymysql.Error as e:
                    code, msg = e.args
                    print(msg)

            # if see app status --> prompt for their email, call lookup_app_status with email or give error that no app exists
            elif (staff_action == "see_app_status"):
                print("Please enter the visitor's email address")
                visitor_email = input("Visitor's email:\t")
                try:
                    cursor.callproc("lookup_app_status", (visitor_email,))
                    print(cursor.fetchall())
                except pymysql.Error as e:
                    code, msg = e.args
                    print(msg)

            # if see_stats --> call capacity_stats, no input needed
            elif (staff_action == "see_stats"):
                cursor.callproc("capacity_stats")
                all_shelter_animals = cursor.fetchall()
                for row in all_shelter_animals:
                    print(row)

            # if add_new_animal --> prompt for animal's name, dob, sex, neutered, intake date, kennel, species, breed
                # call new_animal with given input or give error that animal already exists
            elif (staff_action == "add_new_animal"):
                print("Please enter the animal's information - name, date of birth, sex, neutered, intake date, kennel, species, and breed ")
                new_animal_name = input("Animal's name:\t")

                # handle dob formatting
                new_animal_dob_format = False
                while (not new_animal_dob_format):
                    new_animal_dob = input("Date of birth (YYYY-MM-DD):\t")
                    try:
                        datetime.strptime (new_animal_dob, "%Y-%m-%d").date()
                        new_animal_dob = datetime.strptime (new_animal_dob, "%Y-%m-%d").date()
                        new_animal_dob_format = True
                    except ValueError:
                        print("Please make sure date is entered in the format YYYY-MM-DD")

                # handle sex input validation
                new_animal_sex_valid = False
                while (not new_animal_sex_valid):
                    new_animal_sex = input("Sex (M or F):\t")
                    if (new_animal_sex == "M" or new_animal_sex == "F"):
                        new_animal_sex_valid = True
                    else:
                        print("Please enter either M or F for the animal's sex")
                
                # handle if the animal is neutered value
                new_animal_neutered_valid = False
                while (not new_animal_neutered_valid):
                    new_animal_neutered = input("Neutered (T/F):\t")
                    if (new_animal_neutered == "T"):
                        new_animal_neutered_valid = True
                        new_animal_neutered = 1
                    elif (new_animal_neutered == "F"):
                        new_animal_neutered_valid = True
                        new_animal_neutered = 0
                    else:
                        print("Please enter either T or F for if the animal is neutered or not")
                
                # handle intake date formatting
                new_animal_intake_date_format = False
                while (not new_animal_intake_date_format):
                    new_animal_intake_date = input("Intake date (YYYY-MM-DD):\t")
                    try:
                        datetime.strptime (new_animal_intake_date, "%Y-%m-%d").date()
                        new_animal_intake_date = datetime.strptime (new_animal_intake_date, "%Y-%m-%d").date()
                        new_animal_intake_date_format = True
                    except ValueError:
                        print("Please make sure date is entered in the format YYYY-MM-DD")
                
                new_animal_kennel = input("Kennel:\t")
                new_animal_species = input("Species:\t")
                new_animal_breed = input("Breed:\t")
 
                try:
                    cursor.callproc("new_animal", (new_animal_name, new_animal_dob, new_animal_sex, new_animal_neutered, new_animal_intake_date,
                                                   new_animal_kennel, new_animal_species, new_animal_breed))
                    connection.commit()
                    print("Added animal!")
                except pymysql.Error as e:
                    code, msg = e.args
                    print(msg)
                    

            # if make_appt --> prompt for appt type, notes, appt date, vet, animal
                # if vaccine --> prompt for vaccine name, vaccine version, and vaccine serial number
                # call make_appt
                
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
                cursor.callproc("new_visitor", (new_name, new_dob, new_email, new_pswd, int(new_street_num),
                                                new_street_name, new_city, new_state, new_zipcode))
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
