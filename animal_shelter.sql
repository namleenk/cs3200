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
    name varchar(64) not null,
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
    name varchar(64) not null,
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
    approver_status bool, -- can this staff approve adoption applications?
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
    -- application is for an animal
    animal int,
    foreign key (animal) references animal(animal_id) on update cascade on delete cascade,
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

-- appointment involves vaccine (*..*)
create table appoint_vaccine (
	appointment int,
    vaccine int,
    primary key(appointment, vaccine),
    foreign key (appointment) references appointment(aid) on update cascade on delete cascade,
    foreign key (vaccine) references vaccine(vac_id) on update cascade on delete cascade
);

-- staff vaccinates animal (*..*)
create table vaccinates (
	animal int,
    staff int,
    primary key(animal, staff),
    foreign key (animal) references animal(animal_id) on update cascade on delete cascade,
    foreign key (staff) references staff(staff_id) on update cascade on delete cascade
);



