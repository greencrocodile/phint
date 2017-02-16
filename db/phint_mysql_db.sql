CREATE DATABASE  IF NOT EXISTS `phint` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `phint`;
-- MySQL dump 10.13  Distrib 5.6.24, for Win64 (x86_64)
--
-- Host: localhost    Database: phint
-- ------------------------------------------------------
-- Server version	5.6.24-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `courses`
--

DROP TABLE IF EXISTS `courses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `courses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `school_id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `active` int(11) DEFAULT '0',
  `updated` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_by` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_courses_schools_idx` (`school_id`),
  KEY `fk_cources_users_idx` (`updated_by`),
  CONSTRAINT `fk_cources_users` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_courses_schools` FOREIGN KEY (`school_id`) REFERENCES `schools` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `courses`
--

LOCK TABLES `courses` WRITE;
/*!40000 ALTER TABLE `courses` DISABLE KEYS */;
INSERT INTO `courses` VALUES (1,1,'Основы фотографии',1,'2017-02-16 16:32:01',NULL),(2,1,'Основы фотошопа',1,'2017-02-16 16:32:01',NULL),(3,1,'Рисунок для фотографов',1,'2017-02-16 16:32:01',NULL);
/*!40000 ALTER TABLE `courses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `genres`
--

DROP TABLE IF EXISTS `genres`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `genres` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `updated` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_by` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_genres_users_idx` (`updated_by`),
  CONSTRAINT `fk_genres_users` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `genres`
--

LOCK TABLES `genres` WRITE;
/*!40000 ALTER TABLE `genres` DISABLE KEYS */;
INSERT INTO `genres` VALUES (1,'портрет','2017-02-16 18:13:51',NULL),(2,'пейзаж','2017-02-16 18:13:51',NULL),(3,'репортаж','2017-02-16 18:13:51',NULL),(4,'стрит','2017-02-16 18:13:52',NULL);
/*!40000 ALTER TABLE `genres` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `interns`
--

DROP TABLE IF EXISTS `interns`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `interns` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `firstname` varchar(50) DEFAULT NULL,
  `middlename` varchar(50) DEFAULT NULL,
  `lastname` varchar(50) DEFAULT NULL,
  `birthdate` datetime DEFAULT NULL,
  `active` int(11) DEFAULT '0',
  `updated` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_by` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='перечень стажёров';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `interns`
--

LOCK TABLES `interns` WRITE;
/*!40000 ALTER TABLE `interns` DISABLE KEYS */;
INSERT INTO `interns` VALUES (1,'Иван','Иванович','Иванов','1981-01-01 00:00:00',1,'2017-02-14 18:05:38',NULL),(2,'Пётр','Петрович','Петров','1990-01-01 00:00:00',1,'2017-02-14 18:05:38',NULL);
/*!40000 ALTER TABLE `interns` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `interns_courses`
--

DROP TABLE IF EXISTS `interns_courses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `interns_courses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `intern_id` int(11) NOT NULL,
  `course_id` int(11) NOT NULL,
  `end_date` datetime NOT NULL,
  `updated` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_by` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_intern_courses_interns_idx` (`intern_id`),
  KEY `fk_intern_courses_courses_idx` (`course_id`),
  KEY `fk_intern_courses_users_idx` (`updated_by`),
  CONSTRAINT `fk_intern_courses_courses` FOREIGN KEY (`course_id`) REFERENCES `courses` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_intern_courses_interns` FOREIGN KEY (`intern_id`) REFERENCES `interns` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_intern_courses_users` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `interns_courses`
--

LOCK TABLES `interns_courses` WRITE;
/*!40000 ALTER TABLE `interns_courses` DISABLE KEYS */;
INSERT INTO `interns_courses` VALUES (1,1,1,'2016-01-01 00:00:00','2017-02-16 16:32:52',NULL),(2,2,1,'2016-01-01 00:00:00','2017-02-16 16:32:52',NULL),(3,1,2,'2016-01-01 00:00:00','2017-02-16 16:32:52',NULL),(4,2,3,'2016-01-01 00:00:00','2017-02-16 16:32:52',NULL);
/*!40000 ALTER TABLE `interns_courses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `interns_genres`
--

DROP TABLE IF EXISTS `interns_genres`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `interns_genres` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `intern_id` int(11) NOT NULL,
  `genre_id` int(11) NOT NULL,
  `updated` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_by` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_interns_genres_interns_idx` (`intern_id`),
  KEY `fk_interns_genres_genres_idx` (`genre_id`),
  KEY `fk_interns_genres_users_idx` (`updated_by`),
  CONSTRAINT `fk_interns_genres_genres` FOREIGN KEY (`genre_id`) REFERENCES `genres` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_interns_genres_interns` FOREIGN KEY (`intern_id`) REFERENCES `interns` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_interns_genres_users` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `interns_genres`
--

LOCK TABLES `interns_genres` WRITE;
/*!40000 ALTER TABLE `interns_genres` DISABLE KEYS */;
INSERT INTO `interns_genres` VALUES (1,1,1,'2017-02-16 18:14:17',NULL),(2,1,2,'2017-02-16 18:14:17',NULL),(3,2,3,'2017-02-16 18:14:17',NULL),(4,2,4,'2017-02-16 18:14:17',NULL);
/*!40000 ALTER TABLE `interns_genres` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `privileges`
--

DROP TABLE IF EXISTS `privileges`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `privileges` (
  `code` varchar(100) NOT NULL,
  `name` varchar(100) NOT NULL,
  `updated` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_by` int(11) DEFAULT NULL,
  PRIMARY KEY (`code`),
  UNIQUE KEY `code_UNIQUE` (`code`),
  KEY `fk_privileges_users_idx` (`updated_by`),
  CONSTRAINT `fk_privileges_users` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `privileges`
--

LOCK TABLES `privileges` WRITE;
/*!40000 ALTER TABLE `privileges` DISABLE KEYS */;
INSERT INTO `privileges` VALUES ('DICTIONARIES_R','Справочники (чтение)','2017-02-12 17:09:45',NULL),('INTERNS_R','Интерны (чтение)','2017-02-12 17:09:45',NULL),('USERS_R','Пользователи (чтение)','2017-02-12 17:09:45',NULL);
/*!40000 ALTER TABLE `privileges` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `schools`
--

DROP TABLE IF EXISTS `schools`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `schools` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `short_name` varchar(50) DEFAULT NULL,
  `address` varchar(200) DEFAULT NULL,
  `phone` varchar(15) DEFAULT NULL,
  `contact_person` varchar(100) DEFAULT NULL,
  `active` int(11) DEFAULT '0',
  `updated` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_by` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_schools_users_idx` (`updated_by`),
  CONSTRAINT `fk_schools_users` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='перечень фотошкол';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `schools`
--

LOCK TABLES `schools` WRITE;
/*!40000 ALTER TABLE `schools` DISABLE KEYS */;
INSERT INTO `schools` VALUES (1,'Школа Академической Фотографии Санкт-Петербург','ШкАФ','СПБ, Апраксин пер., д. 4, оф. 506','1234567','Наталья',1,'2017-02-16 16:30:33',NULL);
/*!40000 ALTER TABLE `schools` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `firstname` varchar(100) DEFAULT NULL,
  `middlename` varchar(100) DEFAULT NULL,
  `lastname` varchar(100) DEFAULT NULL,
  `login` varchar(100) DEFAULT NULL,
  `pwd` varchar(100) DEFAULT NULL,
  `active` int(11) NOT NULL,
  `updated` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_by` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_users_users_idx` (`updated_by`),
  CONSTRAINT `fk_users_users` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'','','админ','admin','21232f297a57a5a743894a0e4a801fc3',1,'2017-02-14 18:15:04',NULL);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_privileges`
--

DROP TABLE IF EXISTS `users_privileges`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users_privileges` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `privilege_id` varchar(100) NOT NULL,
  `updated` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_by` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_up_users_idx` (`user_id`),
  KEY `fk_up_privileges_idx` (`privilege_id`),
  KEY `fk_up_users1_idx` (`updated_by`),
  CONSTRAINT `fk_up_privileges` FOREIGN KEY (`privilege_id`) REFERENCES `privileges` (`code`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_up_users` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_up_users1` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_privileges`
--

LOCK TABLES `users_privileges` WRITE;
/*!40000 ALTER TABLE `users_privileges` DISABLE KEYS */;
INSERT INTO `users_privileges` VALUES (1,1,'DICTIONARIES_R','2017-02-14 18:16:03',NULL),(2,1,'INTERNS_R','2017-02-14 18:16:03',NULL),(3,1,'USERS_R','2017-02-14 18:16:03',NULL);
/*!40000 ALTER TABLE `users_privileges` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `v_courses`
--

DROP TABLE IF EXISTS `v_courses`;
/*!50001 DROP VIEW IF EXISTS `v_courses`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `v_courses` AS SELECT 
 1 AS `id`,
 1 AS `school_id`,
 1 AS `school_short_name`,
 1 AS `name`,
 1 AS `active`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `v_interns`
--

DROP TABLE IF EXISTS `v_interns`;
/*!50001 DROP VIEW IF EXISTS `v_interns`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `v_interns` AS SELECT 
 1 AS `id`,
 1 AS `firstname`,
 1 AS `middlename`,
 1 AS `lastname`,
 1 AS `birthdate`,
 1 AS `birthdate_text`,
 1 AS `active`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `v_interns_courses`
--

DROP TABLE IF EXISTS `v_interns_courses`;
/*!50001 DROP VIEW IF EXISTS `v_interns_courses`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `v_interns_courses` AS SELECT 
 1 AS `id`,
 1 AS `intern_id`,
 1 AS `course_id`,
 1 AS `school_id`,
 1 AS `course_name`,
 1 AS `school_short_name`,
 1 AS `end_date`,
 1 AS `end_date_text`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `v_schools`
--

DROP TABLE IF EXISTS `v_schools`;
/*!50001 DROP VIEW IF EXISTS `v_schools`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `v_schools` AS SELECT 
 1 AS `id`,
 1 AS `short_name`,
 1 AS `name`,
 1 AS `address`,
 1 AS `phone`,
 1 AS `contact_person`,
 1 AS `active`*/;
SET character_set_client = @saved_cs_client;

--
-- Dumping events for database 'phint'
--

--
-- Dumping routines for database 'phint'
--
/*!50003 DROP FUNCTION IF EXISTS `FN_GETFULLNAME` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `FN_GETFULLNAME`(p_firstname varchar(100),p_middlename varchar(100),p_lastname varchar(100)) RETURNS varchar(302) CHARSET utf8
BEGIN
       RETURN trim(CONCAT(IFNULL(p_lastname, ''),' ',IFNULL(p_firstname, ''),' ',IFNULL(p_middlename, '')));

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `FN_GETINITIALSNAME` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `FN_GETINITIALSNAME`(p_firstname varchar(50),p_middlename varchar(50),p_lastname varchar(50)) RETURNS varchar(55) CHARSET utf8
BEGIN
    if trim(CONCAT(TRIM(p_lastname),' ',LEFT(TRIM(p_firstname), 1),'.',LEFT(TRIM(p_middlename), 1),'.')) = '..' 
    then 
		RETURN ''; 
	else
		RETURN CONCAT(TRIM(p_lastname),' ',LEFT(TRIM(p_firstname), 1),'.',LEFT(TRIM(p_middlename), 1),'.');	
	end if;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `FN_GETUSERPRIVILEGES` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `FN_GETUSERPRIVILEGES`(p_id int) RETURNS varchar(4000) CHARSET utf8
BEGIN
RETURN ifnull((SELECT 
                CONCAT('#',
                            GROUP_CONCAT(`up`.`privilege_id`
                                SEPARATOR '#'),
                            '#')
            FROM
                `users_privileges` `up`
            WHERE
                (`up`.`user_id` = p_id)),'#');

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_CourseEdit` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_CourseEdit`(INOUT p_id int, IN p_name varchar(100), IN p_school_id int,IN p_user_id int)
BEGIN
		if exists (select id from courses where id != p_id and name = p_name and school_id = p_school_id) then
			SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Курс с таким названием в этой школе уже существует';
		end if;
        
        if p_id = -1 then
                
			INSERT INTO courses
				(school_id,
                name,
				active,
				updated,
				updated_by)
			VALUES(
				p_school_id,
                p_name,
				2,
				now(),
				p_user_id);

			select last_insert_id() into p_id;
        else
			UPDATE schools
			SET
				name = p_name,
				school_id = p_school_id,
				active = 1,
				updated = now(),
				updated_by = p_user_id
			WHERE id = p_id;
        end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_InternCourseEdit` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_InternCourseEdit`(INOUT p_id int, IN p_intern_id int, IN p_course_id int, IN p_end_date int,IN p_user_id int)
BEGIN
		if exists (select id from interns_courses where id != p_id and intern_id = p_intern_id and course_id = p_course_id and end_date = p_end_date) then
			SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Такая запись о прохождении курса уже существует';
		end if;
        
        if p_id = -1 then
                
			INSERT INTO interns_courses
				(intern_id,
				course_id,
				end_date,
				updated,
				updated_by)
			VALUES
				(p_intern_id,
				p_course_id,
				p_end_date,
				now(),
				p_user_id);

                
			select last_insert_id() into p_id;
        else
			UPDATE interns_courses
			SET
				intern_id = p_intern_id,
				course_id = p_course_id,
				end_date = p_end_date,
				updated = now(),
				updated_by = p_user_id
			WHERE id = p_id;
        end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_InternEdit` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_InternEdit`(INOUT p_id int, IN p_firstname varchar(50),IN p_middlename varchar(50),IN p_lastname varchar(50),IN p_birthdate datetime,IN p_user_id int)
BEGIN
	if (p_id = -1) then
		INSERT INTO interns
			(firstname,
			middlename,
			lastname,
			birthdate,
			active,
			updated,
			updated_by)
		VALUES
			(p_firstname,
			p_middlename,
			p_lastname,
			p_birthdate,
			2,
			now(),
			p_user_id);
		select last_insert_id() into p_id;
    else
		UPDATE students	SET
			firstname = p_firstname,
            middlename = p_middlename,
            lastname = p_lastname,
            birthdate = p_birthdate,
            active = 1,
			updated = now(),
			updated_by = p_user_id
		WHERE id = p_id;
    end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_Login` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_Login`(in p_login varchar(100), in p_pwd varchar(100), out p_id int, out p_name varchar(100), out p_privileges varchar(4000))
BEGIN
	select id, FN_GETINITIALSNAME(firstname, middlename, lastname) into p_id, p_name from users where login = p_login and pwd = p_pwd;
    if p_id is not null then
		SELECT ifnull(concat('#',GROUP_CONCAT(privilege_id SEPARATOR '#'),'#'),'#') into p_privileges 
        FROM users_privileges
        where user_id = p_id;
	else
		set p_privileges = '#';
    end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_SchoolEdit` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_SchoolEdit`(INOUT p_id int, IN p_name varchar(100), IN p_short_name varchar(50), p_address varchar(200), p_phone varchar(15), 
p_contact_person varchar(100),IN p_user_id int)
BEGIN
		if exists (select id from schools where id != p_id and name = p_name and short_name = p_short_name) then
			SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Школа с таким названием уже существует';
		end if;
        
        if p_id = -1 then
                
			INSERT INTO schools
				(name,
				short_name,
				address,
				phone,
				contact_person,
				active,
				updated,
				updated_by)
			VALUES(
				p_name,
				p_short_name,
				p_address,
				p_phone,
				p_contact_person,
				2,
				now(),
				p_user_id);

			select last_insert_id() into p_id;
        else
			UPDATE schools
			SET
				name = p_name,
				short_name = p_short_name,
				address = p_address,
				phone = p_phone,
				contact_person = p_contact_person,
				active = 1,
				updated = now(),
				updated_by = p_user_id
			WHERE id = p_id;
        end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_SetUserPassword` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_SetUserPassword`(in p_id int, in p_pwd varchar(100), in p_user_id int)
BEGIN
	update users 
    set 
		pwd = p_pwd,
        updated = now(),
        updated_by = p_user_id
	where id = p_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_UserDelete` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_UserDelete`(in p_id int, in p_hard_delete int, in p_user_id int)
BEGIN
	if p_hard_delete = 1 then
		delete from users_privileges where user_id = p_id;
        delete from users where id = p_id;
    else
		update users set active = 0, updated = now(), updated_by = p_user_id where id = p_id;
    end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_UserEdit` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_UserEdit`(inout p_id int, in p_firstname varchar(100), in p_middlename varchar(100), in p_lastname varchar(100), in p_login varchar(100), in p_pwd varchar(100), in p_school_unit_id int, in p_user_id int)
BEGIN
	if p_id = -1 then
		INSERT INTO `users`
			(`firstname`,
            middlename,
            lastname,
			`login`,
			`active`,
			`updated`,
			`updated_by`)
		VALUES
			(p_firstname,
            p_middlename,
            p_lastname,
			p_login,
			2,
			now(),
			p_user_id);
		select last_insert_id() into p_id;
    else
		if exists(select id from users where active = 1 and id != p_id and login = p_login) then
			SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'пользователь с таким логином уже существует';
		end if;
		UPDATE `users`
		SET
			`firstname` = p_firstname,
            `middlename` = p_middlename,
            `lastname` = p_lastname,
			`login` = p_login,
			`active` = 1,
			`updated` = now(),
			`updated_by` = p_user_id
		WHERE `id` = p_id;
        if p_pwd is not null then
			call sp_SetUserPassword(p_id, p_pwd, p_user_id);
        end if;
    end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `v_courses`
--

/*!50001 DROP VIEW IF EXISTS `v_courses`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_courses` AS select `c`.`id` AS `id`,`c`.`school_id` AS `school_id`,`s`.`short_name` AS `school_short_name`,`c`.`name` AS `name`,`c`.`active` AS `active` from (`courses` `c` join `schools` `s` on((`s`.`id` = `c`.`school_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_interns`
--

/*!50001 DROP VIEW IF EXISTS `v_interns`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_interns` AS select `interns`.`id` AS `id`,`interns`.`firstname` AS `firstname`,`interns`.`middlename` AS `middlename`,`interns`.`lastname` AS `lastname`,`interns`.`birthdate` AS `birthdate`,date_format(`interns`.`birthdate`,'%b, %d %Y %H:%i:%s') AS `birthdate_text`,`interns`.`active` AS `active` from `interns` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_interns_courses`
--

/*!50001 DROP VIEW IF EXISTS `v_interns_courses`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_interns_courses` AS select `ic`.`id` AS `id`,`i`.`id` AS `intern_id`,`c`.`id` AS `course_id`,`s`.`id` AS `school_id`,`c`.`name` AS `course_name`,`s`.`short_name` AS `school_short_name`,`ic`.`end_date` AS `end_date`,date_format(`ic`.`end_date`,'%b, %d %Y %H:%i:%s') AS `end_date_text` from (((`interns` `i` join `interns_courses` `ic` on((`ic`.`intern_id` = `i`.`id`))) join `courses` `c` on((`c`.`id` = `ic`.`course_id`))) join `schools` `s` on((`s`.`id` = `c`.`school_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_schools`
--

/*!50001 DROP VIEW IF EXISTS `v_schools`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_schools` AS select `s`.`id` AS `id`,`s`.`short_name` AS `short_name`,`s`.`name` AS `name`,`s`.`address` AS `address`,`s`.`phone` AS `phone`,`s`.`contact_person` AS `contact_person`,`s`.`active` AS `active` from `schools` `s` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-02-16 18:16:06
