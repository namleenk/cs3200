create database if not exists animal_shelter;

use animal_shelter;

-- address strong entity
create table address (
	street_num int,
    street_name varchar(64),
    city varchar(32),
    state char(2),
    zipcode char(5),
    primary key (street_num, street_name, city, state, zipcode)
);

-- visitor strong entity
create table visitor (
	visitor_id int auto_increment primary key,
    name varchar(64),
    date_of_birth date,
    -- email is an AK
    email varchar(64) unique,
    -- visitor lives at address
    street_num int not null,
    street_name varchar(64) not null,
    city varchar(32) not null,
    state char(2) not null,
    zipcode char(5) not null,
    foreign key (street_num, street_name, city, state, zipcode) references address(street_num, street_name, city, state, zipcode)
		on update cascade on delete restrict
);

-- species strong entity
create table species (
	species_id int auto_increment primary key,
    scientific_name varchar(128),
    breed varchar(64)
);

-- kennel strong entity
create table kennel (
	kid int auto_increment primary key,
    width int,
    depth int,
    height int
);

-- animal strong entity
create table animal (
	animal_id int auto_increment primary key,
    name varchar(64),
    date_of_birth date,
    sex enum('F', 'M'),
    neutered bool,
    -- EDIT THESE OPTIONS
    adoption_status enum('shelter', 'pending', 'adopted'),
    intake_date date,
    -- animal is in a kennel: 1-1 relationship
    -- we moved kennel to its own table to make it third normal form
	kennel int unique,
    foreign key (kennel) references kennel(kid) on update cascade on delete restrict,
    -- animal is one of a species
    species int not null,
    foreign key (species) references species(species_id) on update cascade on delete restrict

);

-- manager strong entity
create table manager (
	manager_id int auto_increment primary key,
    m_name varchar(64),
    hours_per_week int,
    salary int,
    -- username is an AK
    username varchar(64) unique,
    password varchar(64)
);

-- staff strong entity
create table staff (
	staff_id int auto_increment primary key,
    name varchar(64),
    hours_per_week int,
    full_time bool,
    salary int,
    -- username is an AK
    username varchar(64) unique,
    password varchar(64),
    -- manager manages staff
    manager int not null,
    foreign key (manager) references manager(manager_id) on update cascade on delete cascade
);

-- vet subclass for staff
create table vet (
	vet_id int auto_increment primary key,
    accepting_new bool,
    foreign key (vet_id) references staff(staff_id) on update cascade on delete restrict
);

-- approver subclass for staff
create table approver (
	approver_id int auto_increment primary key,
    foreign key (approver_id) references staff(staff_id) on update cascade on delete restrict
);

-- urgent care strong entity
create table urgent_care (
	uc_id int auto_increment primary key,
    reason varchar(256),
    visit_date date,
    diagnosis varchar(128),
    prognosis varchar(128)
);

-- appointment strong entity
create table appointment (
	aid int auto_increment primary key,
    notes varchar(256),
    app_date date,
    -- vet conducts appointment
    vet int,
    foreign key (vet) references vet(vet_id) on update cascade on delete cascade,
     -- animal has appointment
    animal int,
    foreign key (animal) references animal(animal_id) on update cascade on delete cascade
);

-- appiontment subclass {mandatory, or}
-- vaccination
create table vaccination (
	aid int auto_increment primary key,
    vaccination_given varchar(64),
    reason varchar(128),
    -- FK to superclass
    foreign key (aid) references appointment(aid) on update restrict on delete restrict
);
-- checkup
create table checkup (
	aid int auto_increment primary key,
    -- FK to superclass
    foreign key (aid) references appointment(aid) on update restrict on delete restrict
);

-- application weak entity
create table application (
	app_id int auto_increment primary key,
    applicant_name varchar(64),
    date_of_birth date,
    household_members int,
    current_pets int,
    occupation varchar(64),
    status enum('denied', 'accepted', 'pending'),
    -- visitor submits application
    visitor int,
    foreign key (visitor) references visitor(visitor_id) on update cascade on delete restrict,
    -- approver approves application
    approver int not null,
    foreign key (approver) references approver(approver_id) on update cascade on delete restrict
);

-- vaccine strong entity
create table vaccine (
	vac_id int auto_increment primary key,
    name varchar(64),
    version varchar(64)
);

-- animal goes to urgent care (*..*)
create table animal_urgent_care (
	animal int,
    uc_id int,
    primary key(animal, uc_id),
    foreign key (animal) references animal(animal_id) on update cascade on delete cascade,
    foreign key (uc_id) references urgent_care(uc_id) on update cascade on delete cascade
);

-- appointment involves vaccine
create table appoint_vaccine (
	appointment int,
    vaccine int,
    primary key(appointment, vaccine),
    foreign key (appointment) references appointment(aid) on update cascade on delete cascade,
    foreign key (vaccine) references vaccine(vac_id) on update cascade on delete cascade
);

-- staff vaccinates animal
create table vaccinates (
	animal int,
    staff int,
    primary key(animal, staff),
    foreign key (animal) references animal(animal_id) on update cascade on delete cascade,
    foreign key (staff) references staff(staff_id) on update cascade on delete cascade
);

-- application is for an animal
create table is_for (
	animal int,
    application int,
    primary key(animal, application),
    foreign key (animal) references animal(animal_id) on update cascade on delete restrict,
    foreign key (application) references application(app_id) on update cascade on delete cascade
);

-- Functionality


-- when an animal gets adopted, set its kennel to null
-- THIS ALSO DOESNT WORK
delimiter $$
create trigger empty_kennel
	before update on animal for each row
    begin 
		if (new.adoption_status = "adopted") then
			set new.kennel = null;
        end if;
    end $$
delimiter ;

UPDATE `animal_shelter`.`animal` SET `adoption_status` = 'adopted' WHERE (`animal_id` = 2);

-- when an application gets updated (status set to 'accepted') 
delimiter $$
create trigger set_animal_to_adopted
	before update on application for each row
    begin 
		declare animal
        set animal_to_update = (select * from animal where animal_id = 
			(select animal from 
			(select * from is_for where application = new.app_id)));
        if (new.status = 'accepted') then
			set animal_to_update.adoption_status = 'adopted';
        end if;
    end $$

delimiter ;
	

-- Return all animals that aren't adopted
delimiter $$
create procedure see_shelter_animals()
	begin 
		select * from animal where adoption_status != 'adopted';
    end $$
delimiter ;

call see_shelter_animals();
Error Code: 1054. Unknown column 'animal_id' in 'field list'

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

drop procedure lookup_animal;
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
drop procedure lookup_app_status;
call lookup_app_status("jroll@gmail.com");


-- Retrieve number of animals in shelter and capacity percentage
delimiter $$
create function capacity_stats()
	returns varchar(128) deterministic 
    contains sql
	
	begin 
		declare animal_count int;
        declare total_capacity int;
        declare capacity_percent float;
        declare animals_in_shelter int;
        
        select count(*) from animal into animal_count; -- number of animals
        select count(*) from kennel into total_capacity; -- number of kennels
        (select count(*) from animal where kennel is not null) into animals_in_shelter;
        -- number of in-shelter animals divided by total capacity
        select animals_in_shelter / total_capacity * 100 into capacity_percent;
        return concat("In-shelter animals: ", animals_in_shelter, ", total capacity: ", total_capacity, ", percent filled: ", capacity_percent);
    end $$
delimiter ;
drop function capacity_stats;
select capacity_stats();

-- Retrieve all animals who have no application submitted for them
delimiter $$
create procedure animals_with_no_app()
	begin 
		-- get everything from animal that isn't in is_for
        select * from animal 
        join is_for on animal = animal_id
        where animal_id not in (select animal from is_for);
    end $$
delimiter ;

-- THIS DOES NOT WORK!!
select * from is_for;

call animals_with_no_app();