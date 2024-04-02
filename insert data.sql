INSERT INTO `animal_shelter`.`address` (`street_num`, `street_name`, `city`, `state`, `zipcode`) VALUES ('6900', 'Darcy Lane', 'Raleigh', 'NC', '27606');
INSERT INTO `animal_shelter`.`address` (`street_num`, `street_name`, `city`, `state`, `zipcode`) VALUES ('39', 'Chanticleer Street', 'Larkspur', 'CA', '94939');
INSERT INTO `animal_shelter`.`address` (`street_num`, `street_name`, `city`, `state`, `zipcode`) VALUES ('10', 'Chandler Street', 'Boston', 'MA', '02116');


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


-- 3	Sandy	2016-05-09	M	1	adopted	2024-01-01		2
-- 4	Ringo	2020-03-14	F	0	pending	2021-12-19	3	4
