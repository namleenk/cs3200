#!/usr/bin/env python3
from datetime import datetime
import pymysql
from pymysql import cursors

# connect to database
def connect_to_db():
  db_username = input("Please enter a username:\t")
  db_password = input("Please enter a password:\t")
  try:
      connection = pymysql.connect(host='localhost', user=db_username, password=db_password,
                                    db='animal_shelter', charset='utf8mb4', cursorclass=pymysql.cursors.DictCursor)
      print('Connection successful')
      return connection
  except BaseException:
      print("Connection unsuccessful. Please check your username/password and try again.")
      return

def run():
   connection = connect_to_db()
   if not connection:
      return
   
   cursor = connection.cursor()

   successful_login = False
   while (not successful_login):
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
        handle_staff_actions(connection, cursor)
        
# prints the list of actions a staff can do
def staff_action_options():
  print("As a staff member you can do the following:\n" +
          "1. See all shelter animals (see_shelter_animals)\n" +
          "2. Look up an animal's adoption status (look_up_animal)\n" +
          "3. Look at a visitor's application status (see_app_status)\n" +
          "4. Look at shelter statistics (see_stats)\n" +
          "5. Add a new animal to the shelter (add_new_animal)\n" +
          "6. Make a new appointment for an animal (make_appt)\n" +
          "\nSimply type the shorthand in parathesis of the action you want to do "+
          "and you will get further instructions")

# delegate staff actions
def handle_staff_actions(connection, cursor):
   # show the staff the option of actions
   staff_action_options()
   valid_staff_action = False
  
   # make sure the user entered a valid action option
   while (not valid_staff_action):
    # take the input
    staff_action = input("Action:\t")
    #if see shelter animal --> call procedure see_shelter_animals(), no input needed
    if (staff_action == "see_shelter_animals"):
      valid_staff_action = True
      see_shelter_animals(cursor)

    # if look up animal --> prompt for animal name or animal id, call lookup_animal with either input
      # if user does not know, SQL gets null value for that attribute
    elif (staff_action == "look_up_animal"):
      valid_staff_action = True
      look_up_animal(cursor)
    # if see app status --> prompt for their email, call lookup_app_status with email or give error that no app exists
    elif (staff_action == "see_app_status"):
      valid_staff_action = True
      see_app_status(cursor)
    # if see_stats --> call capacity_stats, no input needed
    elif (staff_action == "see_stats"):
      valid_staff_action = True
      see_stats(cursor)
    # if add_new_animal --> prompt for animal's name, dob, sex, neutered, intake date, kennel, species, breed
      # call new_animal with given input or give error that animal already exists
    elif (staff_action == "add_new_animal"):
      valid_staff_action = True
      add_new_animal(connection, cursor)
    # if make_appt --> prompt for appt type, notes, appt date, vet, animal
      # if vaccine --> prompt for vaccine name, vaccine version, and vaccine serial number
      # call make_appt
    elif (staff_action == "make_appt"):
      valid_staff_action = True
      make_appt(connection, cursor)
    else:
      print("That is not a valid action for a staff member")

# handle see_shelter_animal action
def see_shelter_animals(cursor):
  cursor.callproc("see_shelter_animals")
  all_shelter_animals = cursor.fetchall()
  for row in all_shelter_animals:
    print(row)

# handle look_up_animal action
def look_up_animal(cursor):
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

# handle see_app_status action
def see_app_status(cursor):
  print("Please enter the visitor's email address")
  visitor_email = input("Visitor's email:\t")
  try:
      cursor.callproc("lookup_app_status", (visitor_email,))
      print(cursor.fetchall())
  except pymysql.Error as e:
      code, msg = e.args
      print(msg)
      
# handle see_stats action
def see_stats(cursor):
  cursor.callproc("capacity_stats")
  all_shelter_animals = cursor.fetchall()
  for row in all_shelter_animals:
      print(row)

# handle add_new_animal action
def add_new_animal(connection, cursor):
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

# handle make_appt action
def make_appt(connection, cursor):
  print("Which type of appointment would you like to create (check up or vaccination)?")
  valid_appt_type = False
  while (not valid_appt_type):
      appt_type = input("check up or vaccination:\t")
      if (appt_type == "check up"):
          valid_appt_type = True
          # prompt for check up inputs
          print("Please enter the appointment notes, date, vet, and animal")
          appt_notes = input("Notes:\t")
          
          # handle appt date formatting
          appt_date_format = False
          while (not appt_date_format):
              appt_date = input("Appointment date (YYYY-MM-DD):\t")
              try:
                  datetime.strptime (appt_date, "%Y-%m-%d").date()
                  appt_date = datetime.strptime (appt_date, "%Y-%m-%d").date()
                  appt_date_format = True
              except ValueError:
                  print("Please make sure date is entered in the format YYYY-MM-DD")
          appt_vet = input("Vet ID:\t")
          appt_animal = input("Animal ID:\t")

          try:
              cursor.callproc("make_appt", ("check up", appt_notes, appt_date, appt_vet, appt_animal, None, None, None))
              connection.commit()
              print("Appointment created!")
          except pymysql.Error as e:
              code, msg = e.args
              print(msg)
      elif (appt_type == "vaccination"):
          valid_appt_type = True
          #prompt for vaccination inputs
          print("Please enter the appointment notes, date, vet, animal, vaccine name, vaccine version, and vaccine serial number")
          appt_notes = input("Notes:\t")
          
          # handle appt date formatting
          appt_date_format = False
          while (not appt_date_format):
              appt_date = input("Appointment date (YYYY-MM-DD):\t")
              try:
                  datetime.strptime (appt_date, "%Y-%m-%d").date()
                  appt_date = datetime.strptime (appt_date, "%Y-%m-%d").date()
                  appt_date_format = True
              except ValueError:
                  print("Please make sure date is entered in the format YYYY-MM-DD")

          appt_vet = input("Vet ID:\t")
          appt_animal = input("Animal ID:\t")
          appt_vaccine_name = input("Vaccine name:\t")
          appt_vaccine_version = input("Vaccine version:\t")
          appt_vaccine_serial_no = input("Vaccine serial number:\t")

          try:
              cursor.callproc("make_appt", ("vaccination", appt_notes, appt_date, appt_vet, appt_animal, appt_vaccine_name, appt_vaccine_version, appt_vaccine_serial_no))
              connection.commit()
              print("Appointment created!")
          except pymysql.Error as e:
              code, msg = e.args
              print(msg)
      else:
          print("Appointments can only be check up or vaccination")



if __name__ == '__main__':
    run()
