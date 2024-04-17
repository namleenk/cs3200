CREATE DATABASE  IF NOT EXISTS `animal_shelter` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `animal_shelter`;
-- MySQL dump 10.13  Distrib 8.0.36, for macos14 (x86_64)
--
-- Host: localhost    Database: animal_shelter
-- ------------------------------------------------------
-- Server version	8.0.36

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `address`
--

DROP TABLE IF EXISTS `address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `address` (
  `street_num` int NOT NULL,
  `street_name` varchar(64) NOT NULL,
  `city` varchar(32) NOT NULL,
  `state` char(2) NOT NULL,
  `zipcode` char(5) NOT NULL,
  PRIMARY KEY (`street_num`,`street_name`,`city`,`state`,`zipcode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `address`
--

LOCK TABLES `address` WRITE;
/*!40000 ALTER TABLE `address` DISABLE KEYS */;
INSERT INTO `address` VALUES (10,'Chandler Street','Boston','MA','02116'),(32,'Gainsborough Street','Boston','MA','2115'),(39,'Chanticleer Street','Larkspur','CA','94939'),(89,'Symphony Road','Boston','MA','02115'),(230,'Commonwealth Avenue','Boston','MA','02115'),(360,'Huntington Ave','Boston','MA','02115'),(400,'North Dithridge Street','Pittsburgh','PA','15213'),(420,'America Lane','Houston','TX','77001'),(720,'Darcy Lane','Raleigh','NC','27606'),(6900,'Darcy Lane','Raleigh','NC','27606'),(7700,'Centre Avenue','Pittsburgh','PA','15232');
/*!40000 ALTER TABLE `address` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `animal`
--

DROP TABLE IF EXISTS `animal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `animal` (
  `animal_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL,
  `date_of_birth` date DEFAULT NULL,
  `sex` enum('F','M') DEFAULT NULL,
  `neutered` tinyint(1) DEFAULT NULL,
  `adoption_status` enum('shelter','pending','adopted') DEFAULT NULL,
  `intake_date` date DEFAULT NULL,
  `kennel` int DEFAULT NULL,
  `species` int NOT NULL,
  PRIMARY KEY (`animal_id`),
  UNIQUE KEY `kennel` (`kennel`),
  KEY `species` (`species`),
  CONSTRAINT `animal_ibfk_1` FOREIGN KEY (`kennel`) REFERENCES `kennel` (`kid`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `animal_ibfk_2` FOREIGN KEY (`species`) REFERENCES `species` (`species_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `animal`
--

LOCK TABLES `animal` WRITE;
/*!40000 ALTER TABLE `animal` DISABLE KEYS */;
INSERT INTO `animal` VALUES (1,'Oats','2022-04-21','M',1,'adopted','2022-06-30',NULL,1),(3,'Sandy','2016-05-09','M',1,'adopted','2024-01-01',NULL,2),(4,'Ringo','2020-03-14','F',0,'shelter','2021-12-19',3,4),(5,'Paul','2004-02-19','M',1,'shelter','2023-07-07',4,6),(6,'Fargo','2003-06-21','F',1,'shelter','2022-08-09',12,3),(7,'Jessica','2024-01-01','M',1,'shelter','2024-01-01',15,5),(8,'Twister','2015-09-15','M',1,'shelter','2024-03-09',14,5),(9,'Fern','2020-02-04','F',0,'shelter','2022-04-09',8,4),(10,'Viola','2016-08-03','F',1,'shelter','2024-05-06',9,2),(11,'Mustache','2003-05-09','M',1,'shelter','2020-09-09',5,1),(12,'John','2016-03-10','M',1,'shelter','2023-04-20',10,3),(13,'Lyra','2021-07-15','F',0,'shelter','2022-07-20',7,2),(14,'Spice','1999-01-05','F',1,'shelter','2024-04-12',13,3);
/*!40000 ALTER TABLE `animal` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `animal_urgent_care`
--

DROP TABLE IF EXISTS `animal_urgent_care`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `animal_urgent_care` (
  `animal` int NOT NULL,
  `uc_id` int NOT NULL,
  PRIMARY KEY (`animal`,`uc_id`),
  KEY `uc_id` (`uc_id`),
  CONSTRAINT `animal_urgent_care_ibfk_1` FOREIGN KEY (`animal`) REFERENCES `animal` (`animal_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `animal_urgent_care_ibfk_2` FOREIGN KEY (`uc_id`) REFERENCES `urgent_care` (`uc_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `animal_urgent_care`
--

LOCK TABLES `animal_urgent_care` WRITE;
/*!40000 ALTER TABLE `animal_urgent_care` DISABLE KEYS */;
INSERT INTO `animal_urgent_care` VALUES (4,1);
/*!40000 ALTER TABLE `animal_urgent_care` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `application`
--

DROP TABLE IF EXISTS `application`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `application` (
  `app_id` int NOT NULL AUTO_INCREMENT,
  `household_members` int DEFAULT NULL,
  `current_pets` int DEFAULT NULL,
  `occupation` varchar(64) DEFAULT NULL,
  `status` enum('denied','accepted','pending') DEFAULT NULL,
  `animal` int DEFAULT NULL,
  `visitor` int DEFAULT NULL,
  `approver` int DEFAULT NULL,
  PRIMARY KEY (`app_id`),
  KEY `animal` (`animal`),
  KEY `visitor` (`visitor`),
  KEY `approver` (`approver`),
  CONSTRAINT `application_ibfk_1` FOREIGN KEY (`animal`) REFERENCES `animal` (`animal_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `application_ibfk_2` FOREIGN KEY (`visitor`) REFERENCES `visitor` (`visitor_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `application_ibfk_3` FOREIGN KEY (`approver`) REFERENCES `staff` (`staff_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `application`
--

LOCK TABLES `application` WRITE;
/*!40000 ALTER TABLE `application` DISABLE KEYS */;
INSERT INTO `application` VALUES (1,4,2,'singer','pending',1,2,3),(2,1,0,'singer','accepted',1,3,5),(3,1,0,'professor','pending',5,1,5),(4,1,0,'singer','pending',6,7,5),(5,1,0,'singer','pending',8,7,NULL);
/*!40000 ALTER TABLE `application` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `appoint_vaccine`
--

DROP TABLE IF EXISTS `appoint_vaccine`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `appoint_vaccine` (
  `appointment` int NOT NULL,
  `vaccine` int NOT NULL,
  `serial_no` int DEFAULT NULL,
  PRIMARY KEY (`appointment`,`vaccine`),
  KEY `vaccine` (`vaccine`),
  CONSTRAINT `appoint_vaccine_ibfk_1` FOREIGN KEY (`appointment`) REFERENCES `appointment` (`aid`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `appoint_vaccine_ibfk_2` FOREIGN KEY (`vaccine`) REFERENCES `vaccine` (`vac_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `appoint_vaccine`
--

LOCK TABLES `appoint_vaccine` WRITE;
/*!40000 ALTER TABLE `appoint_vaccine` DISABLE KEYS */;
INSERT INTO `appoint_vaccine` VALUES (4,3,104),(5,4,35);
/*!40000 ALTER TABLE `appoint_vaccine` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `appointment`
--

DROP TABLE IF EXISTS `appointment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `appointment` (
  `aid` int NOT NULL AUTO_INCREMENT,
  `notes` varchar(256) DEFAULT NULL,
  `appt_date` date DEFAULT NULL,
  `appt_type` enum('checkup','vaccination') DEFAULT NULL,
  `vet` int DEFAULT NULL,
  `animal` int DEFAULT NULL,
  PRIMARY KEY (`aid`),
  KEY `vet` (`vet`),
  KEY `animal` (`animal`),
  CONSTRAINT `appointment_ibfk_1` FOREIGN KEY (`vet`) REFERENCES `vet` (`vet_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `appointment_ibfk_2` FOREIGN KEY (`animal`) REFERENCES `animal` (`animal_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `appointment`
--

LOCK TABLES `appointment` WRITE;
/*!40000 ALTER TABLE `appointment` DISABLE KEYS */;
INSERT INTO `appointment` VALUES (1,'Annual health check-up','2022-07-09','checkup',4,4),(3,'annual check up','2023-05-09','checkup',7,6),(4,'flu shot','2024-02-12','vaccination',7,9),(5,'covid','2021-01-04','vaccination',4,11);
/*!40000 ALTER TABLE `appointment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kennel`
--

DROP TABLE IF EXISTS `kennel`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `kennel` (
  `kid` int NOT NULL AUTO_INCREMENT,
  `width` int DEFAULT NULL,
  `depth` int DEFAULT NULL,
  `height` int DEFAULT NULL,
  PRIMARY KEY (`kid`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kennel`
--

LOCK TABLES `kennel` WRITE;
/*!40000 ALTER TABLE `kennel` DISABLE KEYS */;
INSERT INTO `kennel` VALUES (1,128,128,128),(2,128,128,64),(3,128,128,64),(4,128,128,128),(5,128,128,128),(6,64,64,64),(7,256,128,64),(8,128,128,256),(9,128,128,128),(10,64,64,128),(11,256,256,26),(12,64,128,128),(13,64,64,128),(14,256,256,26),(15,64,128,128);
/*!40000 ALTER TABLE `kennel` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `manager`
--

DROP TABLE IF EXISTS `manager`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `manager` (
  `manager_id` int NOT NULL AUTO_INCREMENT,
  `m_name` varchar(64) DEFAULT NULL,
  `hours_per_week` int DEFAULT NULL,
  `salary` int DEFAULT NULL,
  `username` varchar(64) DEFAULT NULL,
  `password` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`manager_id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `manager`
--

LOCK TABLES `manager` WRITE;
/*!40000 ALTER TABLE `manager` DISABLE KEYS */;
INSERT INTO `manager` VALUES (1,'Lisa Bluder',40,50,'lbluder','hawkeyes'),(2,'Geno Auriemma',10,13,'gauriemma','uconn!'),(3,'Dawn Staley',15,15,'dstaley','scarolina'),(4,'Lindsay Gottlieb',20,15,'lgottlieb','travelers');
/*!40000 ALTER TABLE `manager` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `species`
--

DROP TABLE IF EXISTS `species`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `species` (
  `species_id` int NOT NULL AUTO_INCREMENT,
  `scientific_name` varchar(128) DEFAULT NULL,
  `breed` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`species_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `species`
--

LOCK TABLES `species` WRITE;
/*!40000 ALTER TABLE `species` DISABLE KEYS */;
INSERT INTO `species` VALUES (1,'Felis catus','Domestic shorthair'),(2,'Felis catus','Persian'),(3,'Canis lupis','Husky'),(4,'Canis lupis','German Shepard'),(5,'Canis lupis','Labradoodle'),(6,'Wormus gigantus','Giant Sandworm'),(7,'Cavia porcellus','Guinea Pig'),(8,'Oryctolagus cuniculus','Rabbit');
/*!40000 ALTER TABLE `species` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `staff`
--

DROP TABLE IF EXISTS `staff`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `staff` (
  `staff_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(64) DEFAULT NULL,
  `hours_per_week` int DEFAULT NULL,
  `full_time` tinyint(1) DEFAULT NULL,
  `salary` int DEFAULT NULL,
  `approver_status` tinyint(1) DEFAULT NULL,
  `username` varchar(64) DEFAULT NULL,
  `password` varchar(64) DEFAULT NULL,
  `manager` int NOT NULL,
  PRIMARY KEY (`staff_id`),
  UNIQUE KEY `username` (`username`),
  KEY `manager` (`manager`),
  CONSTRAINT `staff_ibfk_1` FOREIGN KEY (`manager`) REFERENCES `manager` (`manager_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `staff`
--

LOCK TABLES `staff` WRITE;
/*!40000 ALTER TABLE `staff` DISABLE KEYS */;
INSERT INTO `staff` VALUES (1,'Caitlin Clark',20,0,10,1,'cclark','iowa22',1),(2,'Paige Bueckers',15,0,10,1,'pbueckers','uconn5',2),(3,'Karmilla Cardoso',30,0,15,1,'kcardoso','sc10',3),(4,'Kate Martin',40,1,20,0,'kmartin','iowa20',1),(5,'Nika Muhl',35,1,15,1,'nmuhl','uconn10',2),(6,'Raven Johnson',40,1,20,0,'rjohnson','sc25',3),(7,'Juju Watkins',15,0,10,0,'jwatkins','usc12',4),(8,'Sue Bird',35,1,20,1,'suebird3','MeganRapinoe3',3);
/*!40000 ALTER TABLE `staff` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `urgent_care`
--

DROP TABLE IF EXISTS `urgent_care`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `urgent_care` (
  `uc_id` int NOT NULL AUTO_INCREMENT,
  `reason` varchar(256) DEFAULT NULL,
  `visit_date` date DEFAULT NULL,
  `diagnosis` varchar(128) DEFAULT NULL,
  `prognosis` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`uc_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `urgent_care`
--

LOCK TABLES `urgent_care` WRITE;
/*!40000 ALTER TABLE `urgent_care` DISABLE KEYS */;
INSERT INTO `urgent_care` VALUES (1,'Itching behind ear','2024-04-04','Fleas','Bathe with special shampoo for 2 weeks'),(2,'Limping when walking','2024-03-27','Broken leg','Cast, rest leg for 2 months');
/*!40000 ALTER TABLE `urgent_care` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vaccinates`
--

DROP TABLE IF EXISTS `vaccinates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vaccinates` (
  `animal` int NOT NULL,
  `staff` int NOT NULL,
  PRIMARY KEY (`animal`,`staff`),
  KEY `staff` (`staff`),
  CONSTRAINT `vaccinates_ibfk_1` FOREIGN KEY (`animal`) REFERENCES `animal` (`animal_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `vaccinates_ibfk_2` FOREIGN KEY (`staff`) REFERENCES `staff` (`staff_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vaccinates`
--

LOCK TABLES `vaccinates` WRITE;
/*!40000 ALTER TABLE `vaccinates` DISABLE KEYS */;
INSERT INTO `vaccinates` VALUES (4,4);
/*!40000 ALTER TABLE `vaccinates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vaccine`
--

DROP TABLE IF EXISTS `vaccine`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vaccine` (
  `vac_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(64) DEFAULT NULL,
  `version` int DEFAULT NULL,
  PRIMARY KEY (`vac_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vaccine`
--

LOCK TABLES `vaccine` WRITE;
/*!40000 ALTER TABLE `vaccine` DISABLE KEYS */;
INSERT INTO `vaccine` VALUES (1,'Rabies vaccine',1),(2,'Lyme disease vaccine',1),(3,'Influenza vaccine',3),(4,'COVID-19',1);
/*!40000 ALTER TABLE `vaccine` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vet`
--

DROP TABLE IF EXISTS `vet`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vet` (
  `vet_id` int NOT NULL AUTO_INCREMENT,
  `accepting_new` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`vet_id`),
  CONSTRAINT `vet_ibfk_1` FOREIGN KEY (`vet_id`) REFERENCES `staff` (`staff_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vet`
--

LOCK TABLES `vet` WRITE;
/*!40000 ALTER TABLE `vet` DISABLE KEYS */;
INSERT INTO `vet` VALUES (4,1),(6,0),(7,1);
/*!40000 ALTER TABLE `vet` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `visitor`
--

DROP TABLE IF EXISTS `visitor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `visitor` (
  `visitor_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL,
  `date_of_birth` date NOT NULL,
  `email` varchar(64) NOT NULL,
  `v_password` varchar(64) NOT NULL,
  `street_num` int NOT NULL,
  `street_name` varchar(64) NOT NULL,
  `city` varchar(32) NOT NULL,
  `state` char(2) NOT NULL,
  `zipcode` char(5) NOT NULL,
  PRIMARY KEY (`visitor_id`),
  UNIQUE KEY `email` (`email`),
  KEY `street_num` (`street_num`,`street_name`,`city`,`state`,`zipcode`),
  CONSTRAINT `visitor_ibfk_1` FOREIGN KEY (`street_num`, `street_name`, `city`, `state`, `zipcode`) REFERENCES `address` (`street_num`, `street_name`, `city`, `state`, `zipcode`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `visitor`
--

LOCK TABLES `visitor` WRITE;
/*!40000 ALTER TABLE `visitor` DISABLE KEYS */;
INSERT INTO `visitor` VALUES (1,'Kathleen Durant','2000-06-05','k.durant@northesatern.edu','pswd1234',420,'America Lane','Houston','TX','77001'),(2,'Jelly Roll','1982-04-04','jroll@gmail.com','jellyroll1',10,'Chandler Street','Boston','MA','02116'),(3,'Billie Eilish','2001-12-18','beilish@yahoo.com','badguyduh',6900,'Darcy Lane','Raleigh','NC','27606'),(4,'Elizabeth Dickey','1970-07-04','bethd04@gmail.com','kyrasmomheart',7700,'Centre Avenue','Pittsburgh','PA','15232'),(5,'Keltin Grimes','2001-02-06','keltin.grimes@gmail.com','kyrasbrother',400,'North Dithridge Street','Pittsburgh','PA','15213'),(6,'Craig Grimes','1956-09-06','craig.grimes40@gmail.com','horse111!',720,'Darcy Lane','Raleigh','NC','27606'),(7,'Dave Matthews','1959-08-02','davematthewssucks@gmail.com','dmsucksssss',89,'Symphony Road','Boston','MA','02115'),(8,'Beyonce','1981-09-04','bknowles@beyonce.com','bhive',32,'Gainsborough Street','Boston','MA','2115');
/*!40000 ALTER TABLE `visitor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'animal_shelter'
--

--
-- Dumping routines for database 'animal_shelter'
--
/*!50003 DROP PROCEDURE IF EXISTS `add_staff` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_staff`(in name_p varchar(64), in hours_per_week_p int, in full_time_p bool, in salary_p int, 
in approver_status_p bool, in username_p varchar(64), in password_p varchar(64), in manager_p int)
begin
		-- check if the given manager exists
		if (manager_p not in (select manager_id from manager)) then
			signal sqlstate '45000' set message_text = "A manager with the given ID does not exist";
		end if;
		insert into staff (name, hours_per_week, full_time, salary, approver_status, username, password, manager)
			values (name_p, hours_per_week_p, full_time_p, salary_p, approver_status_p, username_p, password_p, manager_p);
	end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `animals_with_no_app` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `animals_with_no_app`()
begin 
		select * from animal where animal_id not in (select animal from application);
	end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `capacity_stats` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `capacity_stats`()
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
    end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `check_app_status` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `check_app_status`(in email_p varchar(64))
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
    end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `longest_shelter_length` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `longest_shelter_length`(in species_p varchar(64))
begin
    -- check if species does not exist
    if (species_p not in (select scientific_name from species)) then
		signal sqlstate '45000' set message_text = "There currently are no animals of this species";
	end if;
	select * from animal
		left outer join species on animal.species = species.species_id
        where species_p = species.scientific_name and animal.adoption_status != "adopted" order by intake_date asc;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `lookup_animal` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `lookup_animal`(in name_param varchar(64), in id_param int)
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
    end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `lookup_app_status` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `lookup_app_status`(in email_param varchar(64))
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
    end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `make_appt` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `make_appt`(in appt_type_p enum('checkup', 'vaccination'), in notes_p varchar(256), in appt_date_p date, in vet_p int, in animal_p int,
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
			insert into appointment (notes, appt_date, appt_type, vet, animal)
				values (notes_p, appt_date_p, appt_type_p, vet_p, animal_p);
		end if;
        
        -- if involves vaccine then insert into appointment, vaccine, and update appoint_vaccine table
        if (appt_type_p = 'vaccination') then
			-- an animal should only have 1 vaccination appointment on 1 day
            select aid into var_aid from appointment where notes = notes_p and appt_date = appt_date_p and
					appt_type = appt_type_p and vet = vet_p and animal = animal_p;
                    
			insert into appointment (notes, appt_date, appt_type, vet, animal)
				values (notes_p, appt_date_p, appt_type_p, vet_p, animal_p);
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
				((select aid from appointment where notes = notes_p and appt_date = appt_date_p and
					appt_type = appt_type_p and vet = vet_p and animal = animal_p),
					(select vac_id from vaccine where name = vac_name_p and version = vac_version_p),
					vaccine_serial_no_p);
		end if;
    end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `new_animal` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `new_animal`(in name_p varchar(64), in dob_p date, in sex_p enum("F", "M"), 
	in neutered_p tinyint(1), in intake_date_p date, in kennel_p int, in species_scientific_p varchar(128), 
    in species_breed_p varchar(64))
begin
		-- have to repeat code b/c MySQL won't let us select columns from a procedure call (select * from (call capacity_stats()))
		declare animals_in_shelter int;
        declare total_capacity int;
        if kennel_p in (select kennel from animal) then 
			signal sqlstate '45000' set message_text = "Kennel is already occupied.";
		end if;
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
        end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `new_visitor` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `new_visitor`(in name_p varchar(64), in date_p date, in email_p varchar(64), in v_password_p varchar(64),
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
    end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `remove_animal` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `remove_animal`(in animal_id_p int)
begin
		declare appt_id int;
		-- if animal has an appointment, remove that appt first
        if (animal_id_p in (select animal from appointment)) then
            delete from appointment where aid = appt_id;
		end if;
		-- check if animal exists
        if (animal_id_p not in (select animal_id from animal)) then
			signal sqlstate '45000' set message_text = "This animal does not exist";
			signal sqlstate '45000' set message_text = "This animal does not exist";
		end if;
        delete from animal where animal_id = animal_id_p;
    end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `remove_staff` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `remove_staff`(in staff_id_p int)
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
        
    end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `see_shelter_animals` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `see_shelter_animals`()
begin 
		select * from animal where adoption_status != 'adopted';
    end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `submit_app` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `submit_app`(in email_p varchar(64), in household_members_p int, in current_pets_p int,
	in occupation_p varchar(64), in animal_p int)
begin
		declare vid int;
		-- check that the visitor exists
		if (email_p not in (select email from visitor)) then
			signal sqlstate '45000' set message_text = "This visitor does not exist yet. Please register with a staff member";
		end if;
        -- check that the animal exists 
        if (animal_p not in (select animal_id from animal)) then 
			signal sqlstate '45000' set message_text = "This animal does not exist. Please check your input and try again.";
		end if;
		select visitor_id into vid from visitor where email = email_p;
		insert into application (household_members, current_pets, occupation, status, animal, visitor, approver) values
			(household_members_p, current_pets_p, occupation_p, 'pending', animal_p, vid, null);
    end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `update_address` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_address`(in email_p varchar(64), in street_num_p int, in street_name_p varchar(64), 
	in city_p varchar(32), in state_p char(2), in zip_p char(5))
begin 
    -- first add to address table (if doens't already exist)
	if ((street_num_p, street_name_p, city_p, state_p, zip_p) not in (select * from address)) then
		insert into address values (street_num_p, street_name_p, city_p, state_p, zip_p);
	end if;
    if email_p in (select email from visitor) then 
		update visitor set street_num = street_num_p, street_name = street_name_p, city = city_p, state = state_p, zipcode = zip_p
			where email_p = visitor.email;
	end if;
    if email_p not in (select email from visitor) then 
    	signal sqlstate '45000' set message_text = "This visitor does not exist yet. PLease register with a staff member";
	end if;
    end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `validate_user` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `validate_user`(in username_p varchar(64), in password_p varchar(64), in table_p varchar(64))
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
    end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-04-17 17:39:12
