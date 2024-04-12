INSERT INTO `animal_shelter`.`address` (`street_num`, `street_name`, `city`, `state`, `zipcode`) VALUES ('6900', 'Darcy Lane', 'Raleigh', 'NC', '27606');
INSERT INTO `animal_shelter`.`address` (`street_num`, `street_name`, `city`, `state`, `zipcode`) VALUES ('39', 'Chanticleer Street', 'Larkspur', 'CA', '94939');
INSERT INTO `animal_shelter`.`address` (`street_num`, `street_name`, `city`, `state`, `zipcode`) VALUES ('10', 'Chandler Street', 'Boston', 'MA', '02116');
INSERT INTO `animal_shelter`.`address` (`street_num`, `street_name`, `city`, `state`, `zipcode`) VALUES ('360', 'Huntington Ave', 'Boston', 'MA', '02115');
INSERT INTO `animal_shelter`.`address` (`street_num`, `street_name`, `city`, `state`, `zipcode`) VALUES ('7700', 'Centre Avenue', 'Pittsburgh', 'PA', '15232');
INSERT INTO `animal_shelter`.`address` (`street_num`, `street_name`, `city`, `state`, `zipcode`) VALUES ('400', 'North Dithridge Street', 'Pittsburgh', 'PA', '15213');
INSERT INTO `animal_shelter`.`address` (`street_num`, `street_name`, `city`, `state`, `zipcode`) VALUES ('230', 'Commonwealth Avenue', 'Boston', 'MA', '02115');
INSERT INTO `animal_shelter`.`address` (`street_num`, `street_name`, `city`, `state`, `zipcode`) VALUES ('89', 'Symphony Road', 'Boston', 'MA', '02115');
INSERT INTO `animal_shelter`.`address` (`street_num`, `street_name`, `city`, `state`, `zipcode`) VALUES ('720', 'Darcy Lane', 'Raleigh', 'NC', '27606');


INSERT INTO `animal_shelter`.`species` (`scientific_name`, `breed`) VALUES ('Felis catus', 'Domestic shorthair');
INSERT INTO `animal_shelter`.`species` (`scientific_name`, `breed`) VALUES ('Felis catus', 'Persian');
INSERT INTO `animal_shelter`.`species` (`scientific_name`, `breed`) VALUES ('Canis lupis', 'Husky');
INSERT INTO `animal_shelter`.`species` (`scientific_name`, `breed`) VALUES ('Canis lupis', 'German Shepard');
INSERT INTO `animal_shelter`.`species` (`scientific_name`, `breed`) VALUES ('Canis lupis', 'Labradoodle');
INSERT INTO `animal_shelter`.`species` (`scientific_name`, `breed`) VALUES ('Wormus gigantus', 'Giant Sandworm');
INSERT INTO `animal_shelter`.`species` (`scientific_name`, `breed`) VALUES ('Cavia porcellus', 'Guinea Pig');
INSERT INTO `animal_shelter`.`species` (`scientific_name`, `breed`) VALUES ('Oryctolagus cuniculus', 'Rabbit');


INSERT INTO `animal_shelter`.`kennel` (`width`, `depth`, `height`) VALUES ('128', '128', '128');
INSERT INTO `animal_shelter`.`kennel` (`width`, `depth`, `height`) VALUES ('128', '128', '64');
INSERT INTO `animal_shelter`.`kennel` (`width`, `depth`, `height`) VALUES ('128', '128', '64');
INSERT INTO `animal_shelter`.`kennel` (`width`, `depth`, `height`) VALUES ('128', '128', '128');
INSERT INTO `animal_shelter`.`kennel` (`width`, `depth`, `height`) VALUES ('128', '128', '128');
INSERT INTO `animal_shelter`.`kennel` (`width`, `depth`, `height`) VALUES ('64', '64', '64');
INSERT INTO `animal_shelter`.`kennel` (`width`, `depth`, `height`) VALUES ('256', '128', '64');
INSERT INTO `animal_shelter`.`kennel` (`width`, `depth`, `height`) VALUES ('128', '128', '256');
INSERT INTO `animal_shelter`.`kennel` (`width`, `depth`, `height`) VALUES ('128', '128', '128');
INSERT INTO `animal_shelter`.`kennel` (`width`, `depth`, `height`) VALUES ('64', '64', '128');
INSERT INTO `animal_shelter`.`kennel` (`width`, `depth`, `height`) VALUES ('256', '256', '26');
INSERT INTO `animal_shelter`.`kennel` (`width`, `depth`, `height`) VALUES ('64', '128', '128');
INSERT INTO `animal_shelter`.`kennel` (`width`, `depth`, `height`) VALUES ('64', '64', '128');
INSERT INTO `animal_shelter`.`kennel` (`width`, `depth`, `height`) VALUES ('256', '256', '26');
INSERT INTO `animal_shelter`.`kennel` (`width`, `depth`, `height`) VALUES ('64', '128', '128');



INSERT INTO `animal_shelter`.`animal` (`name`, `date_of_birth`, `sex`, `neutered`, `adoption_status`, `intake_date`, `kennel`, `species`) VALUES ('Oats', '2022-04-21', 'M', '1', 'adopted', '2022-06-30', null, '1');
INSERT INTO `animal_shelter`.`animal` (`name`, `date_of_birth`, `sex`, `neutered`, `adoption_status`, `intake_date`, `kennel`, `species`) VALUES ('George', '2019-03-17', 'F', '0', 'shelter', '2024-01-13', '6', '1');
INSERT INTO `animal_shelter`.`animal` (`name`, `date_of_birth`, `sex`, `neutered`, `adoption_status`, `intake_date`, `kennel`, `species`) VALUES ('Sandy', '2016-05-09', 'M', '1', 'adopted', '2024-01-01', null, '2');
INSERT INTO `animal_shelter`.`animal` (`name`, `date_of_birth`, `sex`, `neutered`, `adoption_status`, `intake_date`, `kennel`, `species`) VALUES ('Ringo', '2020-03-14', 'F', '0', 'pending', '2021-12-19', '3', '4');
INSERT INTO `animal_shelter`.`animal` (`name`, `date_of_birth`, `sex`, `neutered`, `adoption_status`, `intake_date`, `kennel`, `species`) VALUES ('Paul', '2004-02-19', 'M', '1', 'shelter', '2023-07-07', '4', '6');
INSERT INTO `animal_shelter`.`animal` (`name`, `date_of_birth`, `sex`, `neutered`, `adoption_status`, `intake_date`, `kennel`, `species`) VALUES ('Fargo', '2003-06-21', 'F', '1', 'shelter', '2022-08-09', '12', '3');
INSERT INTO `animal_shelter`.`animal` (`name`, `date_of_birth`, `sex`, `neutered`, `adoption_status`, `intake_date`, `kennel`, `species`) VALUES ('Jessica', '2024-01-01', 'M', '1', 'shelter', '2024-01-01', '15', '5');
INSERT INTO `animal_shelter`.`animal` (`name`, `date_of_birth`, `sex`, `neutered`, `adoption_status`, `intake_date`, `kennel`, `species`) VALUES ('Twister', '2015-09-15', 'M', '1', 'shelter', '2024-03-09', '14', '5');
INSERT INTO `animal_shelter`.`animal` (`name`, `date_of_birth`, `sex`, `neutered`, `adoption_status`, `intake_date`, `kennel`, `species`) VALUES ('Fern', '2020-02-04', 'F', '0', 'shelter', '2022-04-09', '8', '4');
INSERT INTO `animal_shelter`.`animal` (`name`, `date_of_birth`, `sex`, `neutered`, `adoption_status`, `intake_date`, `kennel`, `species`) VALUES ('Viola', '2016-08-03', 'F', '1', 'shelter', '2024-05-06', '9', '2');
INSERT INTO `animal_shelter`.`animal` (`name`, `date_of_birth`, `sex`, `neutered`, `adoption_status`, `intake_date`, `kennel`, `species`) VALUES ('Mustache', '2003-05-09', 'M', '1', 'shelter', '2020-09-09', '5', '1');
INSERT INTO `animal_shelter`.`animal` (`name`, `date_of_birth`, `sex`, `neutered`, `adoption_status`, `intake_date`, `kennel`, `species`) VALUES ('John', '2016-03-10', 'M', '1', 'shelter', '2023-04-20', '10', '3');
INSERT INTO `animal_shelter`.`animal` (`name`, `date_of_birth`, `sex`, `neutered`, `adoption_status`, `intake_date`, `kennel`, `species`) VALUES ('Lyra', '2021-07-15', 'F', '0', 'shelter', '2022-07-20', '7', '2');

INSERT INTO `animal_shelter`.`manager` (`m_name`, `hours_per_week`, `salary`, `username`, `password`) VALUES ('Lisa Bluder', '40', '50', 'lbluder', 'hawkeyes');
INSERT INTO `animal_shelter`.`manager` (`m_name`, `hours_per_week`, `salary`, `username`, `password`) VALUES ('Geno Auriemma', '10', '12.5', 'gauriemma', 'uconn!');
INSERT INTO `animal_shelter`.`manager` (`m_name`, `hours_per_week`, `salary`, `username`, `password`) VALUES ('Dawn Staley', '15', '15', 'dstaley', 'scarolina');
INSERT INTO `animal_shelter`.`manager` (`m_name`, `hours_per_week`, `salary`, `username`, `password`) VALUES ('Lindsay Gottlieb', '20', '15', 'lgottlieb', 'travelers');

INSERT INTO `animal_shelter`.`urgent_care` (`reason`, `visit_date`, `diagnosis`, `prognosis`) VALUES ('Itching behind ear', '2024-04-04', 'Fleas', 'Bathe with special shampoo for 2 weeks');
INSERT INTO `animal_shelter`.`urgent_care` (`reason`, `visit_date`, `diagnosis`, `prognosis`) VALUES ('Limping when walking', '2024-03-27', 'Broken leg', 'Cast, rest leg for 2 months');

INSERT INTO `animal_shelter`.`visitor` (`name`, `email`, `street_num`, `street_name`, `city`, `state`, `zipcode`) VALUES ('Kathleen Durant', 'k.durant@northesatern.edu', '360', 'Huntington Ave', 'Boston', 'MA', '02115');
INSERT INTO `animal_shelter`.`visitor` (`name`, `email`, `street_num`, `street_name`, `city`, `state`, `zipcode`) VALUES ('Jelly Roll', 'jroll@gmail.com', '10', 'Chandler Street', 'Boston', 'MA', '02116');
INSERT INTO `animal_shelter`.`visitor` (`name`, `email`, `street_num`, `street_name`, `city`, `state`, `zipcode`) VALUES ('Billie Eilish', 'beilish@yahoo.com', '6900', 'Darcy Lane', 'Raleigh', 'NC', '27606');
INSERT INTO `animal_shelter`.`visitor` (`name`, `date_of_birth`, `email`, `street_num`, `street_name`, `city`, `state`, `zipcode`) VALUES ('Elizabeth Dickey', '1970-07-04', 'bethd04@gmail.com', '7700', 'Centre Avenue', 'Pittsburgh', 'PA', '15232');
INSERT INTO `animal_shelter`.`visitor` (`name`, `date_of_birth`, `email`, `street_num`, `street_name`, `city`, `state`, `zipcode`) VALUES ('Keltin Grimes', '2001-02-06', 'keltin.grimes@gmail.com', '400', 'North Dithridge Street', 'Pittsburgh', 'PA', '15213');
INSERT INTO `animal_shelter`.`visitor` (`name`, `date_of_birth`, `email`, `street_num`, `street_name`, `city`, `state`, `zipcode`) VALUES ('Craig Grimes', '1956-09-06', 'craig.grimes40@gmail.com', '720', 'Darcy Lane', 'Raleigh', 'NC', '27606');
INSERT INTO `animal_shelter`.`visitor` (`name`, `date_of_birth`, `email`, `street_num`, `street_name`, `city`, `state`, `zipcode`) VALUES ('Dave Matthews', '1959-08-02', 'davematthewssucks@gmail.com', '89', 'Symphony Road', 'Boston', 'MA', '02115');

INSERT INTO `animal_shelter`.`staff` (`name`, `hours_per_week`, `full_time`, `salary`, `username`, `password`, `manager`) VALUES ('Caitlin Clark', '20', '0', '10', 'cclark', 'iowa22', '1');
INSERT INTO `animal_shelter`.`staff` (`name`, `hours_per_week`, `full_time`, `salary`, `username`, `password`, `manager`) VALUES ('Paige Bueckers', '15', '0', '10', 'pbueckers', 'uconn5', '2');
INSERT INTO `animal_shelter`.`staff` (`name`, `hours_per_week`, `full_time`, `salary`, `username`, `password`, `manager`) VALUES ('Karmilla Cardoso', '30', '0', '15', 'kcardoso', 'sc10', '3');
INSERT INTO `animal_shelter`.`staff` (`name`, `hours_per_week`, `full_time`, `salary`, `username`, `password`, `manager`) VALUES ('Kate Martin', '40', '1', '20', 'kmartin', 'iowa20', '1');
INSERT INTO `animal_shelter`.`staff` (`name`, `hours_per_week`, `full_time`, `salary`, `username`, `password`, `manager`) VALUES ('Nika Muhl', '35', '1', '15', 'nmuhl', 'uconn10', '2');
INSERT INTO `animal_shelter`.`staff` (`name`, `hours_per_week`, `full_time`, `salary`, `username`, `password`, `manager`) VALUES ('Raven Johnson', '40', '1', '20', 'rjohnson', 'sc25', '3');
INSERT INTO `animal_shelter`.`staff` (`name`, `hours_per_week`, `full_time`, `salary`, `username`, `password`, `manager`) VALUES ('Juju Watkins', '15', '0', '10', 'jwatkins', 'usc12', '4');

INSERT INTO `animal_shelter`.`vet` (`vet_id`, `accepting_new`) VALUES ('4', '1');
INSERT INTO `animal_shelter`.`vet` (`vet_id`, `accepting_new`) VALUES ('6', '0');
INSERT INTO `animal_shelter`.`vet` (`vet_id`, `accepting_new`) VALUES ('7', '1');

INSERT INTO `animal_shelter`.`approver` (`approver_id`) VALUES ('3');
INSERT INTO `animal_shelter`.`approver` (`approver_id`) VALUES ('5');

INSERT INTO `animal_shelter`.`vaccine` (`name`, `version`) VALUES ('Rabies vaccine', '1');
INSERT INTO `animal_shelter`.`vaccine` (`name`, `version`) VALUES ('Lyme disease vaccine', '1');
INSERT INTO `animal_shelter`.`vaccine` (`name`, `version`) VALUES ('Influenca vaccine', '2.5');

INSERT INTO `animal_shelter`.`animal_urgent_care` (`animal`, `uc_id`) VALUES ('4', '1');
INSERT INTO `animal_shelter`.`animal_urgent_care` (`animal`, `uc_id`) VALUES ('2', '2');

INSERT INTO `animal_shelter`.`appointment` (`notes`, `app_date`, `vet`, `animal`) VALUES ('Annual health check-up', '2022-07-09', '4', '4');
INSERT INTO `animal_shelter`.`appointment` (`notes`, `app_date`, `vet`, `animal`) VALUES ('Annual flu vaccination', '2024-02-15', '7', '2');

INSERT INTO `animal_shelter`.`vaccination` (`aid`, `vaccination_given`, `reason`) VALUES ('2', 'Influenza', 'Annual flu shot');

INSERT INTO `animal_shelter`.`checkup` (`aid`) VALUES ('1');

INSERT INTO `animal_shelter`.`vaccinates` (`animal`, `staff`) VALUES ('4', '4');

INSERT INTO `animal_shelter`.`appoint_vaccine` (`appointment`, `vaccine`) VALUES ('2', '3');

INSERT INTO `animal_shelter`.`application` (`applicant_name`, `date_of_birth`, `household_members`, `current_pets`, `occupation`, `status`, `visitor`, `approver`) VALUES ('Jelly Roll', '1984-12-04', '4', '2', 'singer', 'pending', '2', '3');
INSERT INTO `animal_shelter`.`application` (`applicant_name`, `date_of_birth`, `household_members`, `current_pets`, `occupation`, `status`, `visitor`, `approver`) VALUES ('Billie Eilish', '2001-12-18', '1', '0', 'singer', 'accepted', '3', '5');

INSERT INTO `animal_shelter`.`is_for` (`animal`, `application`) VALUES ('1', '1');
INSERT INTO `animal_shelter`.`is_for` (`animal`, `application`) VALUES ('4', '2');




