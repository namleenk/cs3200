-- ~~~~~~~ PROCEDURES/TRIGGERS ~~~~~~~~~
use animal_shelter;

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


-- When a new application gets added, change that animal's status to 'pending'
-- NOT WORKING FOR SOME REASON 	
delimiter $$
create trigger on_application_add
	after insert on application
    update animal set adoption_status = 'pending' where animal_id = new.animal;
delimiter ;
drop trigger on_application_add;
INSERT INTO `animal_shelter`.`application` (`applicant_name`, `date_of_birth`, `household_members`, 
`current_pets`, `occupation`, `status`, `animal`, `visitor`, `approver`) VALUES ('Dave Matthews', 
'1959-08-02', '1', '0', 'singer', 'pending', '6', '7', '5');

-- Return all animals that aren't adopted
delimiter $$
create procedure see_shelter_animals()
	begin 
		select * from animal where adoption_status != 'adopted';
    end $$
delimiter ;

call see_shelter_animals();

-- Given animal's name, return its adoption status
delimiter $$
create procedure lookup_animal(in name_param varchar(64), in id_param int) 
	begin 
		if (id_param is not null) then
			select * from animal where animal.animal_id = id_param;
        else 
			select * from animal where animal.name = name_param;
        end if;
    end $$
delimiter ;

-- drop procedure lookup_animal;
call lookup_animal("Paul", null);

-- Get the status of all applications
delimiter $$
create procedure check_all_app_status()
	begin 
		select * from application;
    end $$
delimiter ;

call check_all_app_status();

-- Get the status of a certain application, specified by email
delimiter $$
create procedure lookup_app_status(in email_param varchar(64))
	begin
		select status, email_param as email from application 
        join visitor on visitor = visitor_id
		where email_param = visitor.email;
    end $$
delimiter ;
-- drop procedure lookup_app_status;
call lookup_app_status("jroll@gmail.com");


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
-- drop function capacity_stats;
call capacity_stats();


-- Retrieve all animals who have no application submitted for them
-- delimiter $$
-- create procedure animals_with_no_app()
-- 	begin 
-- 		-- get everything from animal that isn't in is_for
--         select * from animal 
--         left join is_for on animal = animal_id
--         where animal_id not in (select animal from is_for);
--     end $$
-- delimiter ;
-- -- drop procedure animals_with_no_app;
-- call animals_with_no_app();

-- Given a name, dob, and address, add a new visitor and address
delimiter $$
create procedure new_visitor(in name_p varchar(64), in date_p date, in email_p varchar(64), 
	in street_num_p int, in street_name_p varchar(64), in city_p varchar(32), in state_p char(2), in zip_p char(5))
	begin 
		-- first add to address table (if doens't already exist)
        if ((street_num_p, street_name_p, city_p, state_p, zip_p) not in (select * from address)) then
			insert into address values (street_num_p, street_name_p, city_p, state_p, zip_p);
		end if;
        -- then add to visitor table (if email doesn't already exist)
        if ((email_p) not in (select email from visitor)) then
			insert into visitor (name, date_of_birth, email, street_num, street_name, city, state, zipcode) values (name_p, date_p, email_p, street_num_p, street_name_p, city_p, state_p, zip_p);
		else 
			signal sqlstate '45000' set message_text = "This email is already in our database";
		end if;
    end $$
delimiter ;
-- drop procedure new_visitor;
call new_visitor("Beyonce", '1981-09-04', "bknowles@beyonce.com", "32", "Gainsborough Street", "Boston", "MA", 02115);


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
-- drop procedure new_animal;
call new_animal("Spice", '1999-01-05', "F", 1, '2024-04-12', 13, "Canis lupus", "Husky");


-- Deletes a staff member (if they get fired or leave), given either the staff's id and/or the staff's username
delimiter $$
create procedure remove_staff (in staff_id_p int, in username_p varchar(64))
	begin
		-- if the staff does not exist, we cannot delete it
        if ((staff_id_p not in (select staff_id from staff)) or (username_p not in (select username from staff)))
			then signal sqlstate '45000' set message_text = "This staff does not exist so it cannot be deleted";
		end if;
        -- if the staff is a vet, we cannot delete it
        if (staff_id_p in (select vet_id from vet)) then
			signal sqlstate '45000' set message_text = "Vets cannot be deleted";
		end if;
        -- if the staff is a approver of an application, we cannot delete it
        if (staff_id_p in (select approver from application)) then
			signal sqlstate '45000' set message_text = "Application approvers cannot be deleted";
        end if;
        -- delete the staff from the table
        delete from staff where staff_id = staff_id_p or username = username_p;
    end $$
delimiter ;
-- drop procedure remove_staff;
-- test
call remove_staff(1, null);
call remove_staff(5, null); -- should give approver error message
