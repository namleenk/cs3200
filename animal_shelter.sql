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
	vid int auto_increment primary key,
    name varchar(64),
    -- email is an AK
    email varchar(64) unique
);

-- application weak entity
create table application (
	app_id int auto_increment primary key,
    date_of_birth date,
    household_members int,
    current_pets int,
    occupation varchar(64),
    status enum('denied', 'accepted', 'in progress')
);

-- species strong entity
create table species (
	species_id int primary key,
    scientific_name varchar(128),
    common_name varchar(64),
    breed varchar(64)
);

-- kennel strong entity
create table kennel (
	kid int auto_increment primary key,
    -- composite attributes for size
    length int,
    width int,
    depth int
);

-- animal strong entity
create table animal (
	animal_id int auto_increment primary key,
    name varchar(64),
    date_of_birth date,
    sex enum('female', 'male'),
    neutered bool,
    -- EDIT THESE OPTIONS
    adoption_status enum('in shelter', 'in progress', 'adopted'),
    intake_date date
);