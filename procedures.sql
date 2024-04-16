-- ~~~~~~~ PROCEDURES/TRIGGERS ~~~~~~~~~
use animal_shelter;
Error Code: 1265. Data truncated for column 'appt_type' at row 1

-- validate the user information
delimiter $$
create procedure validate_user (in username_p varchar(64), in password_p varchar(64), in table_p varchar(64))
	begin
		if (table_p != "staff" and table_p != "manager" and table_p != "visitor") then
				signal sqlstate'45000' set message_text="That is not a valid user type";
		end if;
            
		-- staff validation
        if (table_p = "staff") then
			-- check staff input
            
            -- if the username does not exist, error
            if (username_p not in (select username from staff)) then 
				signal sqlstate '45000' set message_text = "That is not a valid staff username";
			end if;
            
            -- if the password is not correct for the given username, error
            if (password_p not in (select password from staff where username = username_p)) then
				signal sqlstate '45000' set message_text = "That is not the correct password for this username";
			end if;
            
            -- otherwise it's a successful login
			select "Successful staff login";
		end if;
        
        -- manager validation
        if (table_p = "manager") then
			-- check manager input
            -- if the username does not exist, error
            if (username_p not in (select username from manager)) then 
				signal sqlstate '45000' set message_text = "That is not a valid manager username";
			end if;
            
            -- if the password is not correct for the given username, error
            if (password_p not in (select password from manager where username = username_p)) then
				signal sqlstate '45000' set message_text = "That is not the correct password for this username";
			end if;
            
            -- otherwise it's a successful login
			select "Successful manager login";
		end if;
        -- visitor validation
        if (table_p = "visitor") then 
			-- check visitor input
            -- if the username does not exist, error
            if (username_p not in (select email from visitor)) then 
				signal sqlstate '45000' set message_text = "That is not a valid visitor username";
			end if;
            
            -- if the password is not correct for the given username, error
            if (password_p not in (select v_password from visitor where email = username_p)) then
				signal sqlstate '45000' set message_text = "That is not the correct password for this username";
			end if;
            -- otherwise it's a successful login
			select "Successful visitor login";
            
		end if;
    end $$
delimiter ;
-- tests
-- call validate_user ("lbluder", "j", "manager"); -- should give error message
call validate_user ("kcardoso", "sc10", "staff");
call validate_user ("jroll@gmail.com", "jellyroll1", "visitor");
-- call validate_user ("lbluder", "hawkeyes", "staff");
-- call validate_user ("cclark", "23", "staff");

-- when an animal gets adopted, set its kennel to null
delimiter $$
create trigger empty_kennel
	before update on animal
		if (new.adoption_status = "adopted") then
			set new.kennel = null;
		end if;
delimiter ;
-- test
UPDATE `animal_shelter`.`animal` SET `adoption_status` = 'adopted' WHERE (`animal_id` = 2);

-- when an application gets updated trigger
-- 'accepted' ==> update animal's status to adopted
delimiter $$
create trigger on_application_update
	before update on application
		update animal set adoption_status = 'adopted' where animal_id = new.animal;
drop on_application_update;
delimiter ;
UPDATE `animal_shelter`.`application` SET `status` = 'accepted' WHERE (`app_id` = '5');


-- When a new application gets added, change the corresponding animal's status to 'pending'
delimiter $$
create trigger on_application_add
	after insert on application
		update animal set adoption_status = 'pending' where animal_id = new.animal;
delimiter ;
-- test
INSERT INTO `animal_shelter`.`application` (`household_members`, 
`current_pets`, `occupation`, `status`, `animal`, `visitor`, `approver`) VALUES ('1', '0', 'singer', 'pending', '6', '7', '5');


-- Return all animals that aren't adopted
delimiter $$
create procedure see_shelter_animals()
	begin 
		select * from animal where adoption_status != 'adopted';
    end $$
delimiter ;
-- test
call see_shelter_animals();

-- Given animal's name, return its adoption status
delimiter $$
create procedure lookup_animal(in name_param varchar(64), in id_param int) 
	begin 
		if (id_param is not null) then
			if (id_param not in (select animal_id from animal)) then
				signal sqlstate '45000' set message_text = "This animal does not exist";
			else
				select * from animal where animal.animal_id = id_param;
			end if;
        else
			if (name_param not in (select name from animal)) then
				signal sqlstate '45000' set message_text = "This animal does not exist";
			end if;
			select * from animal where animal.name = name_param;
        end if;
    end $$
delimiter ;
-- test
call lookup_animal("Paul", null);

-- Get the status of a certain application, specified by email
delimiter $$
create procedure lookup_app_status(in email_param varchar(64))
	begin
    declare app_status enum ('shelter', 'pending', 'adopted');
    
    -- if the email does not exist, inform the user
    if (email_param not in (select email from visitor)) then
		signal sqlstate '45000' set message_text = "This visitor does not exist";
	end if;
    
	select status into app_status from application join visitor on visitor = visitor_id
		where email_param = visitor.email;
        
	-- if there is no application for that visitor, inform the user
    if (app_status is null) then
		signal sqlstate '45000' set message_text = "There is no application for this visitor";
	else
		select app_status;
	end if;
    end $$
delimiter ;
-- test
call lookup_app_status("jroll@gmail.com");
-- call lookup_app_status("nk@gmail.com"); -- error testing


-- Returns: number of animals (both in-shelter and adopted), number of kennels, 
-- 	number of in-shelter animals, and percentage of kennels filled 
delimiter $$
create procedure capacity_stats()
	begin 
		declare animal_count int;
        declare total_capacity int;
        declare capacity_percent float;
        declare animals_in_shelter int;
        
        select count(*) from animal into animal_count; -- number of animals
        select count(*) from kennel into total_capacity; -- number of kennels
        if (total_capacity = 0) then
			select animal_count, total_capacity, animals_in_shelter, 0;
		else
			(select count(*) from animal where kennel is not null) into animals_in_shelter;
			-- number of in-shelter animals divided by total capacity
			select animals_in_shelter / total_capacity * 100 into capacity_percent;
			select animal_count, total_capacity, animals_in_shelter, capacity_percent;
		end if;
    end $$
delimiter ;
-- test
call capacity_stats();

-- Add a new animal to the database
delimiter $$
create procedure new_animal(in name_p varchar(64), in dob_p date, in sex_p enum("F", "M"), 
	in neutered_p tinyint(1), in intake_date_p date, in kennel_p int, in species_scientific_p varchar(128), 
    in species_breed_p varchar(64))
	begin
		-- have to repeat code b/c MySQL won't let us select columns from a procedure call (select * from (call capacity_stats()))
		declare animals_in_shelter int;
        declare total_capacity int;
		select count(*) from kennel into total_capacity; -- number of kennels
        (select count(*) from animal where kennel is not null) into animals_in_shelter;
        -- check if there is space available: if at capacity, give error and don't proceed
        if (total_capacity = animals_in_shelter) then
			signal sqlstate '45000' set message_text = "Kennels are at capacity";
		else
			-- check if species exists: if it is new, add it to table, add animal either way
            if species_breed_p not in (select breed from species) then
				insert into species (scientific_name, breed) values (species_scientific_p, species_breed_p);
			end if;
            -- if animal already exists: give error, else, insert
            if (name_p, dob_p) in (select name, date_of_birth from animal) then
				signal sqlstate '45000' set message_text = "Animal with same name and birthday already exists";
			else 
				insert into animal (name, date_of_birth, sex, neutered, adoption_status, intake_date, kennel, species)
                values (name_p, dob_p, sex_p, neutered_p, 'shelter', intake_date_p, kennel_p, 
					(select species_id from species where breed = species_breed_p));
			end if;
        end if;
        end $$
delimiter ;
-- test
call new_animal("Spice", '1999-01-05', "F", 1, '2024-04-12', 13, "Canis lupus", "Husky");


-- Given an appt type, create the corresponding appointment (vaccination or checkup) for an animal
delimiter $$
create procedure make_appt (in appt_type_p enum('checkup', 'vaccination'), in notes_p varchar(256), in app_date_p date, in vet_p int, in animal_p int,
	in vac_name_p varchar(64), in vac_version_p int, in vaccine_serial_no_p int)
	begin
		declare taking_patients tinyint(1);
        declare var_aid int;
        declare var_vac_id int;
        -- if an animal does not exist, cannot create an appointment for them
        if (animal_p not in (select animal_id from animal)) then
			signal sqlstate '45000' set message_text = "This animal does not exist, so we cannot create an appointment for them";
        end if;
        -- if a vet does not exist, cannot create an appointment with them
        if (vet_p not in (select vet_id from vet)) then
			signal sqlstate '45000' set message_text = "This vet does not exist, so we cannot create an appointment for them";
        end if;
        -- if a vet is not accepting anymore patients, cannot create an appointment with them
        -- select accepting_new into taking_patients from vet where vet_p = vet_id;
        if ((select accepting_new from vet where vet_id = vet_p) = 0) then
			signal sqlstate '45000' set message_text = "This vet is not currently taking new patients";
        end if;
        
        -- if check-up then insert into appointment table and null the vaccine id
        if (appt_type_p = 'checkup') then
			-- if no errors, insert into appointment and check up tables
			insert into appointment (notes, app_date, appt_type, vet, animal)
				values (notes_p, app_date_p, appt_type_p, vet_p, animal_p);
		end if;
        
        -- if involves vaccine then insert into appointment, vaccine, and update appoint_vaccine table
        if (appt_type_p = 'vaccination') then
			-- an animal should only have 1 vaccination appointment on 1 day
            select aid into var_aid from appointment where notes = notes_p and app_date = app_date_p and
					appt_type = appt_type_p and vet = vet_p and animal = animal_p;
                    
			insert into appointment (notes, app_date, appt_type, vet, animal)
				values (notes_p, app_date_p, appt_type_p, vet_p, animal_p);
		-- if vaccine doesn't exist yet, add it to the vaccine table
			if (vac_version_p not in (select version from vaccine where name = vac_name_p)) then
				insert into vaccine (name, version) values (vac_name_p, vac_version_p);
			end if;
            
            select vac_id  into var_vac_id from vaccine where name = vac_name_p and version = vac_version_p;
            
            if (select var_aid in (select appointment from appoint_vaccine where vaccine = var_vac_id)) then
				signal sqlstate '45000' set message_text = "This animal already has an appointment for this vaccine on this day";
			end if;
				-- update the appoint_vaccine with the appropriate data
			insert into appoint_vaccine (appointment, vaccine, serial_no) values
				((select aid from appointment where notes = notes_p and app_date = app_date_p and
					appt_type = appt_type_p and vet = vet_p and animal = animal_p),
					(select vac_id from vaccine where name = vac_name_p and version = vac_version_p),
					vaccine_serial_no_p);
		end if;
    end $$
delimiter ;
-- tests
call make_appt ('checkup',"annual check up", '2023-05-09', 7, 6, null, null, null);
call make_appt ('vaccination', "flu shot", '2024-02-12', 7, 9, "Influenza vaccine", 3, 104);
call make_appt ('vaccination', "covid", '2021-01-04', 4, 11, "COVID-19", 1, 35);


-- to be used for the NEW VISITOR VIEW
-- Given a name, dob, and address, add a new visitor and address
delimiter $$
create procedure new_visitor (in name_p varchar(64), in date_p date, in email_p varchar(64), in v_password_p varchar(64),
	in street_num_p int, in street_name_p varchar(64), in city_p varchar(32), in state_p char(2), in zip_p char(5))
	begin 
		-- first add to address table (if doens't already exist)
        if ((street_num_p, street_name_p, city_p, state_p, zip_p) not in (select * from address)) then
			insert into address values (street_num_p, street_name_p, city_p, state_p, zip_p);
		end if;
        -- then add to visitor table (if email doesn't already exist)
        if ((email_p) not in (select email from visitor)) then
			insert into visitor (name, date_of_birth, email, v_password, street_num, street_name, city, state, zipcode)
				values (name_p, date_p, email_p, v_password_p, street_num_p, street_name_p, city_p, state_p, zip_p);
		else 
			signal sqlstate '45000' set message_text = "This email is already in our database";
		end if;
    end $$
delimiter ;
-- test
call new_visitor("Beyonce", '1981-09-04', "bknowles@beyonce.com", "bhive", "32", "Gainsborough Street", "Boston", "MA", 02115);

-- to be used for the RETURNING VISITOR VIEW

-- Given the visitor's email, return the status of their application(s)
delimiter $$
create procedure check_app_status (in email_p varchar(64))
	begin
		declare vid int;
        
		-- check if the visitor exists
		if (email_p not in (select email from visitor)) then
			signal sqlstate '45000' set message_text = "This visitor does not exist";
		end if;
        -- check if an application exists for the given visitor
		select visitor_id into vid from (select visitor_id from visitor where email = email_p) as v;
        if (vid not in (select visitor from application)) then
			signal sqlstate '45000' set message_text = "This visitor has not submitted an application to adopt an animal";
		end if;
        -- return the application status
        select status from application where visitor = vid;
    end $$
delimiter ;
-- test
call check_app_status("jroll@gmail.com");
-- call check_app_status("k.durant@northesatern.edu"); -- should give error b/c visitor does not have an app

-- Retrieve all animals who have no application submitted for them
delimiter $$
create procedure animals_with_no_app()
	begin 
		select * from animal where animal_id not in (select animal from application);
	end $$
delimiter ;
-- drop procedure animals_with_no_app;
call animals_with_no_app();

-- View animals who have been in shelter longest by species
delimiter $$
create procedure longest_shelter_length(in species_p varchar(64))
	begin
    -- check if species does not exist
    if (species_p not in (select scientific_name from species)) then
		signal sqlstate '45000' set message_text = "There currently are no animals of this species";
	end if;
	select * from animal
		left outer join species on animal.species = species.species_id
        where species_p = species.scientific_name and animal.adoption_status != "adopted" order by intake_date asc;
end $$
delimiter ;
-- test
call longest_shelter_length("Felis catus")

-- create: submit an application
delimiter $$
create procedure submit_app (in email_p varchar(64), in household_members_p int, in current_pets_p int,
	in occupation_p varchar(64), in animal_p int)
	begin
		declare vid int;
		-- check that the visitor exists
		if (email_p not in (select email from visitor)) then
			signal sqlstate '45000' set message_text = "This visitor does not exist yet. PLease register with a staff member";
		end if;
		select visitor_id into vid from visitor where email = email_p;
		insert into application (household_members, current_pets, occupation, status, animal, visitor, approver) values
			(household_members_p, current_pets_p, occupation_p, 'pending', animal_p, vid, null);
    end $$
delimiter ;
-- test
call submit_app ("davematthewssucks@gmail.com", 1, 0, "singer", 8);
-- call submit_app ("prezaoun@northeastern.edu", 2, 3, "university president", 9); -- should give an error

delimiter $$
create procedure update_address(in email_p varchar(64), in street_num_p int, in street_name_p varchar(64), 
	in city_p varchar(32), in state_p char(2), in zip_p char(5))
	begin 
    -- first add to address table (if doens't already exist)
	if ((street_num_p, street_name_p, city_p, state_p, zip_p) not in (select * from address)) then
		insert into address values (street_num_p, street_name_p, city_p, state_p, zip_p);
	end if;
	update visitor set street_num = street_num_p, street_name = street_name_p, city = city_p, state = state_p, zipcode = zip_p
		where email_p = visitor.email;
	end $$
delimiter ; 
-- test
call update_address("k.durant@northesatern.edu", 420, "America Lane", "Houston", "TX", "77001");

-- to be used for MANAGER VIEW
delimiter $$
create procedure add_staff(in name_p varchar(64), in hours_per_week_p int, in full_time_p bool, in salary_p int, 
in approver_status_p bool, in username_p varchar(64), in password_p varchar(64), in manager_p int)
	begin
		-- check if the given manager exists
		if (manager_p not in (select manager_id from manager)) then
			signal sqlstate '45000' set message_text = "A manager with the given ID does not exist";
		end if;
		insert into staff (name, hours_per_week, full_time, salary, approver_status, username, password, manager)
			values (name_p, hours_per_week_p, full_time_p, salary_p, approver_status_p, username_p, password_p, manager_p);
	end $$
delimiter ;
-- test
call add_staff("Sue Bird", 35, True, 20, True, "suebird3", "MeganRapinoe3", 3);

-- Deletes a staff member (if they get fired or leave), given the staff's id
delimiter $$
create procedure remove_staff (in staff_id_p int)
	begin
		-- if the staff does not exist, we cannot remove them
        if (staff_id_p not in (select staff_id from staff)) then
			signal sqlstate '45000' set message_text = "This staff does not exist";
		end if;
        -- if the staff is a vet, we cannot remove them
        if (staff_id_p in (select vet_id from vet)) then
			signal sqlstate '45000' set message_text = "This staff is a vet and cannot be removed";
		end if;
        -- if the staff is an approver, we cannot remove them
		if (staff_id_p in (select approver from application)) then
			signal sqlstate '45000' set message_text = "This staff is an approver and cannot be removed";
		end if;
        
        delete from staff where staff_id = staff_id_p;
        
    end $$
delimiter ;
-- call remove_staff(3);
-- call remove_staff(4);

-- Given an animal's id, remove it (in case it passes away)
delimiter $$
create procedure remove_animal (in animal_id_p int)
	begin
		declare appt_id int;
		-- if animal has an appointment, remove that appt first
        if (animal_id_p in (select animal from appointment)) then
            delete from appointment where aid = appt_id;
		end if;
		-- check if animal exists
        if (animal_id_p not in (select animal_id from animal)) then
			signal sqlstate '45000' set message_text = "This animal does not exist";
		end if;
        delete from animal where animal_id = animal_id_p;
    end $$
delimiter ;
-- drop procedure remove_animal;
call remove_animal(2);