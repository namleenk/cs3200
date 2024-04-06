INSERT INTO `animal_shelter`.`address` (`street_num`, `street_name`, `city`, `state`, `zipcode`) VALUES ('6900', 'Darcy Lane', 'Raleigh', 'NC', '27606');
INSERT INTO `animal_shelter`.`address` (`street_num`, `street_name`, `city`, `state`, `zipcode`) VALUES ('39', 'Chanticleer Street', 'Larkspur', 'CA', '94939');
INSERT INTO `animal_shelter`.`address` (`street_num`, `street_name`, `city`, `state`, `zipcode`) VALUES ('10', 'Chandler Street', 'Boston', 'MA', '02116');
INSERT INTO `animal_shelter`.`address` (`street_num`, `street_name`, `city`, `state`, `zipcode`) VALUES ('360', 'Huntington Ave', 'Boston', 'MA', '02115');


INSERT INTO `animal_shelter`.`species` (`scientific_name`, `breed`) VALUES ('Felis Catus', 'Domestic shorthair');
INSERT INTO `animal_shelter`.`species` (`scientific_name`, `breed`) VALUES ('Felis Catus', 'Persian');
INSERT INTO `animal_shelter`.`species` (`scientific_name`, `breed`) VALUES ('Canis Lupis', 'Husky');
INSERT INTO `animal_shelter`.`species` (`scientific_name`, `breed`) VALUES ('Canis Lupis', 'German Shepard');
INSERT INTO `animal_shelter`.`species` (`scientific_name`, `breed`) VALUES ('Canis Lupis', 'Labradoodle');


INSERT INTO `animal_shelter`.`kennel` (`width`, `depth`, `height`) VALUES ('128', '128', '128');
INSERT INTO `animal_shelter`.`kennel` (`width`, `depth`, `height`) VALUES ('128', '128', '64');
INSERT INTO `animal_shelter`.`kennel` (`width`, `depth`, `height`) VALUES ('128', '128', '64');


INSERT INTO `animal_shelter`.`animal` (`name`, `date_of_birth`, `sex`, `neutered`, `adoption_status`, `intake_date`, `kennel`, `species`) VALUES ('Oats', '2022-04-21', 'M', '1', 'adopted', '2022-06-30', '1', '1');
INSERT INTO `animal_shelter`.`animal` (`name`, `date_of_birth`, `sex`, `neutered`, `adoption_status`, `intake_date`, `kennel`, `species`) VALUES ('George', '2019-03-17', 'F', '0', 'shelter', '2024-01-13', '2', '1');
INSERT INTO `animal_shelter`.`animal` (`name`, `date_of_birth`, `sex`, `neutered`, `adoption_status`, `intake_date`, `kennel`, `species`) VALUES ('Sandy', '2016-05-09', 'M', '1', 'adopted', '2024-01-01', null, '2');
INSERT INTO `animal_shelter`.`animal` (`name`, `date_of_birth`, `sex`, `neutered`, `adoption_status`, `intake_date`, `kennel`, `species`) VALUES ('Ringo', '2020-03-14', 'F', '0', 'pending', '2021-12-19', '3', '4');

INSERT INTO `animal_shelter`.`manager` (`m_name`, `hours_per_week`, `salary`, `username`, `password`) VALUES ('Lisa Bluder', '40', '50', 'lbluder', 'hawkeyes');
INSERT INTO `animal_shelter`.`manager` (`m_name`, `hours_per_week`, `salary`, `username`, `password`) VALUES ('Geno Auriemma', '10', '12.5', 'gauriemma', 'uconn!');
INSERT INTO `animal_shelter`.`manager` (`m_name`, `hours_per_week`, `salary`, `username`, `password`) VALUES ('Dawn Staley', '15', '15', 'dstaley', 'scarolina');

INSERT INTO `animal_shelter`.`urgent_care` (`reason`, `visit_date`, `diagnosis`, `prognosis`) VALUES ('Itching behind ear', '2024-04-04', 'Fleas', 'Bathe with special shampoo for 2 weeks');
INSERT INTO `animal_shelter`.`urgent_care` (`reason`, `visit_date`, `diagnosis`, `prognosis`) VALUES ('Limping when walking', '2024-03-27', 'Broken leg', 'Cast, rest leg for 2 months');

INSERT INTO `animal_shelter`.`visitor` (`name`, `email`, `street_num`, `street_name`, `city`, `state`, `zipcode`) VALUES ('Kathleen Durant', 'k.durant@northesatern.edu', '360', 'Huntington Ave', 'Boston', 'MA', '02115');
INSERT INTO `animal_shelter`.`visitor` (`name`, `email`, `street_num`, `street_name`, `city`, `state`, `zipcode`) VALUES ('Jelly Roll', 'jroll@gmail.com', '10', 'Chandler Street', 'Boston', 'MA', '02116');
INSERT INTO `animal_shelter`.`visitor` (`name`, `email`, `street_num`, `street_name`, `city`, `state`, `zipcode`) VALUES ('Billie Eilish', 'beilish@yahoo.com', '6900', 'Darcy Lane', 'Raleigh', 'NC', '27606');

INSERT INTO `animal_shelter`.`staff` (`name`, `hours_per_week`, `full_time`, `salary`, `username`, `password`, `manager`) VALUES ('Caitlin Clark', '20', '0', '10', 'cclark', 'iowa22', '1');
INSERT INTO `animal_shelter`.`staff` (`name`, `hours_per_week`, `full_time`, `salary`, `username`, `password`, `manager`) VALUES ('Paige Bueckers', '15', '0', '10', 'pbueckers', 'uconn5', '2');
INSERT INTO `animal_shelter`.`staff` (`name`, `hours_per_week`, `full_time`, `salary`, `username`, `password`, `manager`) VALUES ('Karmilla Cardoso', '30', '0', '15', 'kcardoso', 'sc10', '3');
INSERT INTO `animal_shelter`.`staff` (`name`, `hours_per_week`, `full_time`, `salary`, `username`, `password`, `manager`) VALUES ('Kate Martin', '40', '1', '20', 'kmartin', 'iowa20', '1');
INSERT INTO `animal_shelter`.`staff` (`name`, `hours_per_week`, `full_time`, `salary`, `username`, `password`, `manager`) VALUES ('Nika Muhl', '35', '1', '15', 'nmuhl', 'uconn10', '2');
INSERT INTO `animal_shelter`.`staff` (`name`, `hours_per_week`, `full_time`, `salary`, `username`, `password`, `manager`) VALUES ('Raven Johnson', '40', '1', '20', 'rjohnson', 'sc25', '3');

INSERT INTO `animal_shelter`.`vet` (`vet_id`, `accepting_new`) VALUES ('4', '1');
INSERT INTO `animal_shelter`.`vet` (`vet_id`, `accepting_new`) VALUES ('6', '0');

INSERT INTO `animal_shelter`.`approver` (`approver_id`) VALUES ('3');
INSERT INTO `animal_shelter`.`approver` (`approver_id`) VALUES ('5');
