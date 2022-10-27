-- MariaDB dump 10.19  Distrib 10.6.9-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: foodie_db
-- ------------------------------------------------------
-- Server version	10.6.9-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `client`
--

DROP TABLE IF EXISTS `client`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `client` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `email` varchar(100) COLLATE utf8mb4_bin NOT NULL,
  `first_name` varchar(30) COLLATE utf8mb4_bin NOT NULL,
  `last_name` varchar(100) COLLATE utf8mb4_bin NOT NULL,
  `image_url` varchar(1000) COLLATE utf8mb4_bin NOT NULL,
  `username` varchar(30) COLLATE utf8mb4_bin NOT NULL,
  `password` varchar(100) COLLATE utf8mb4_bin NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `salt` varchar(100) COLLATE utf8mb4_bin NOT NULL DEFAULT 'bad_salt',
  PRIMARY KEY (`id`),
  UNIQUE KEY `client_un` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `client`
--

LOCK TABLES `client` WRITE;
/*!40000 ALTER TABLE `client` DISABLE KEYS */;
INSERT INTO `client` VALUES (13,'again@bla.com','bla_again','again','fake','bla_again','again123','2022-10-20 10:17:27','bad_salt'),(17,'test3@gmail.com','bla_again','again','fake','test','123','2022-10-20 19:22:18','bad_salt'),(19,'test5@gmail.com','bla_again','again','fake','test','123','2022-10-20 19:23:00','bad_salt'),(21,'test6@gmail.com','bla_again','again','fake','test','123','2022-10-20 19:25:52','bad_salt'),(22,'testing456@patch.com','patch','patch last','fake url teeeeestingggggg','patch','patch','2022-10-20 19:26:20','bad_salt'),(23,'test70@gmail.com','bla_again','again','fake','test','123','2022-10-22 08:21:18','bad_salt'),(24,'test80@gmail.com','first salt','salt','salt','salt','*21E99A0F9F24FD0394DA71CCC603F7F62658D380','2022-10-22 15:34:36','c103a6a98c6842369e730199c96ed1cc'),(25,'test90@gmail.com','first salt','salt','salt','salt','*BD7EB5E3F521E469398FB6A1FF8C8756291D5A28','2022-10-22 15:53:25','88c34d7e73854b42953fb7fa3262ca94');
/*!40000 ALTER TABLE `client` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `client_session`
--

DROP TABLE IF EXISTS `client_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `client_session` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `client_id` int(10) unsigned NOT NULL,
  `token` varchar(1000) COLLATE utf8mb4_bin DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `client_session_un` (`token`) USING HASH,
  KEY `client_session_FK` (`client_id`),
  CONSTRAINT `client_session_FK` FOREIGN KEY (`client_id`) REFERENCES `client` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `client_session`
--

LOCK TABLES `client_session` WRITE;
/*!40000 ALTER TABLE `client_session` DISABLE KEYS */;
INSERT INTO `client_session` VALUES (11,13,'1234','2022-10-20 14:30:40'),(19,13,'123456','2022-10-20 15:47:35'),(20,13,'1','2022-10-20 15:51:08'),(25,17,'a94060ffb9edcf1d98877726d8418e64144acb7bce69dee1b3defe2c49d986ea','2022-10-20 19:22:18'),(26,19,'d58536374c838197b32837707dd7db80342c5eb476fe30d774c57a77502d786a','2022-10-20 19:23:00'),(27,21,'cfc41d590cfe6a219cdf5c002ab2081026f29f6d213b67af2ba1c5ae25e92792','2022-10-20 19:25:52'),(28,22,'beca34820e108b73e8d5ddb33230ee7c5170409d3a5b083db4785622fab3689c','2022-10-20 19:26:20'),(29,22,'e89064883cd9c543a9db5a874a898dd25810a9d247da4d64654ae7ccc553636a','2022-10-21 11:53:10'),(30,23,'e6ab8230999e9a3ea35676a721e615b9e61e2ba9f027cd4eaf098d1b6fc8b9a0','2022-10-22 08:21:18'),(31,22,'b6d57baf5c996e2f6fc976de3193f43589a8ea21cef0ed052c78dd7914358b1b','2022-10-22 08:59:05'),(32,24,'11cacd03675ff48551265a53f91096a5cfd47514d96a322da6930dea59eb85aa','2022-10-22 15:34:36'),(33,24,'6fed075ca8f7f923a949e80e78660fe388b940315694572eaba575c30686d0bd','2022-10-22 15:41:46'),(34,25,'1c2b659c40da973a5c4822976198f8b7b251ee23398567dc46cc82b01be3e452','2022-10-22 15:53:25'),(35,25,'706a1bc555743b5afdd8aaf708a63a5689cbcf3e70984927479f4c1665f92b5b','2022-10-22 15:54:34');
/*!40000 ALTER TABLE `client_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `menu_item`
--

DROP TABLE IF EXISTS `menu_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `menu_item` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `restaurant_id` int(10) unsigned NOT NULL,
  `description` varchar(100) COLLATE utf8mb4_bin NOT NULL,
  `image_url` varchar(1000) COLLATE utf8mb4_bin NOT NULL,
  `name` varchar(30) COLLATE utf8mb4_bin NOT NULL,
  `price` decimal(10,0) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `menu_item_un` (`restaurant_id`,`name`),
  CONSTRAINT `menu_item_FK` FOREIGN KEY (`restaurant_id`) REFERENCES `restaurant` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menu_item`
--

LOCK TABLES `menu_item` WRITE;
/*!40000 ALTER TABLE `menu_item` DISABLE KEYS */;
INSERT INTO `menu_item` VALUES (1,5,'testing','first patch request testing','testing',2,'2022-10-24 10:21:56'),(3,7,'first menu item 7','first image url menu item','first menu item',7,'2022-10-24 16:15:27'),(5,7,'first menu item 8','first image url menu item','first menu item 8',8,'2022-10-24 16:17:00');
/*!40000 ALTER TABLE `menu_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_menu_item`
--

DROP TABLE IF EXISTS `order_menu_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `order_menu_item` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `order_id` int(10) unsigned NOT NULL,
  `menu_item_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `order_menu_item_FK` (`order_id`),
  KEY `order_menu_item_FK_1` (`menu_item_id`),
  CONSTRAINT `order_menu_item_FK` FOREIGN KEY (`order_id`) REFERENCES `order_table` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `order_menu_item_FK_1` FOREIGN KEY (`menu_item_id`) REFERENCES `menu_item` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_menu_item`
--

LOCK TABLES `order_menu_item` WRITE;
/*!40000 ALTER TABLE `order_menu_item` DISABLE KEYS */;
INSERT INTO `order_menu_item` VALUES (1,5,3),(2,5,5);
/*!40000 ALTER TABLE `order_menu_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_rating`
--

DROP TABLE IF EXISTS `order_rating`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `order_rating` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `client_id` int(10) unsigned NOT NULL,
  `order_table_id` int(10) unsigned NOT NULL,
  `rate` tinyint(3) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `order_rating_un` (`order_table_id`),
  KEY `order_rating_FK` (`client_id`),
  CONSTRAINT `order_rating_FK` FOREIGN KEY (`client_id`) REFERENCES `client` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `order_rating_FK_2` FOREIGN KEY (`order_table_id`) REFERENCES `order_table` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_rating`
--

LOCK TABLES `order_rating` WRITE;
/*!40000 ALTER TABLE `order_rating` DISABLE KEYS */;
INSERT INTO `order_rating` VALUES (3,25,5,3);
/*!40000 ALTER TABLE `order_rating` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_table`
--

DROP TABLE IF EXISTS `order_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `order_table` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `client_id` int(10) unsigned NOT NULL,
  `restaurant_id` int(10) unsigned NOT NULL,
  `is_complete` tinyint(1) NOT NULL DEFAULT 0,
  `is_confirmed` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `order_FK` (`client_id`),
  KEY `order_FK_1` (`restaurant_id`),
  CONSTRAINT `order_FK` FOREIGN KEY (`client_id`) REFERENCES `client` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `order_FK_1` FOREIGN KEY (`restaurant_id`) REFERENCES `restaurant` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_table`
--

LOCK TABLES `order_table` WRITE;
/*!40000 ALTER TABLE `order_table` DISABLE KEYS */;
INSERT INTO `order_table` VALUES (2,25,7,0,0,'2022-10-24 16:19:07'),(3,25,7,0,0,'2022-10-24 16:29:00'),(4,25,7,0,0,'2022-10-24 16:37:35'),(5,25,7,1,1,'2022-10-24 16:39:37');
/*!40000 ALTER TABLE `order_table` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `restaurant`
--

DROP TABLE IF EXISTS `restaurant`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `restaurant` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) COLLATE utf8mb4_bin NOT NULL,
  `address` varchar(100) COLLATE utf8mb4_bin NOT NULL,
  `phone_number` varchar(11) COLLATE utf8mb4_bin NOT NULL,
  `bio` varchar(200) COLLATE utf8mb4_bin NOT NULL,
  `city` varchar(50) COLLATE utf8mb4_bin NOT NULL,
  `profile_url` varchar(1000) COLLATE utf8mb4_bin NOT NULL,
  `banner_url` varchar(1000) COLLATE utf8mb4_bin NOT NULL,
  `password` varchar(100) COLLATE utf8mb4_bin NOT NULL,
  `email` varchar(80) COLLATE utf8mb4_bin NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `salt` varchar(100) COLLATE utf8mb4_bin NOT NULL DEFAULT 'bad_salt',
  PRIMARY KEY (`id`),
  UNIQUE KEY `restaurant_un` (`email`),
  UNIQUE KEY `restaurant_un_phone` (`phone_number`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `restaurant`
--

LOCK TABLES `restaurant` WRITE;
/*!40000 ALTER TABLE `restaurant` DISABLE KEYS */;
INSERT INTO `restaurant` VALUES (3,'restaurant two','1234, 12043rd street','1234567891','second restaurant bio','Vancouver','https://images.pexels.com/photos/93828/pexels-photo-93828.jpeg?auto=compress&cs=tinysrgb&w=1600','https://images.pexels.com/photos/2467236/pexels-photo-2467236.jpeg?auto=compress&cs=tinysrgb&w=1600','123','restaurant2@email.com','2022-10-22 14:09:11','bad_salt'),(5,'restaurant 5','1234, 12043rd street','1234567894','fourth restaurant bio','Toronto','https://images.pexels.com/photos/93828/pexels-photo-93828.jpeg?auto=compress&cs=tinysrgb&w=1600','https://images.pexels.com/photos/2467236/pexels-photo-2467236.jpeg?auto=compress&cs=tinysrgb&w=1600','*63F87E8262B1A7A2C7EA5051337906210A0D86B7','restaurant5@email.com','2022-10-22 16:03:06','82db71ecc46947979955d11cae4a5d74'),(7,'restaurant 10','1234, 12043rd street','7234567894','fourth restaurant bio','Vancouver','https://images.pexels.com/photos/93828/pexels-photo-93828.jpeg?auto=compress&cs=tinysrgb&w=1600','https://images.pexels.com/photos/2467236/pexels-photo-2467236.jpeg?auto=compress&cs=tinysrgb&w=1600','*DBC7EC39584C2943F4D0A5832057A4748DF6A747','restaurant10@email.com','2022-10-24 12:47:41','e382de1641e84b42acb781ea1175d120');
/*!40000 ALTER TABLE `restaurant` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `restaurant_session`
--

DROP TABLE IF EXISTS `restaurant_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `restaurant_session` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `restaurant_id` int(10) unsigned NOT NULL,
  `token` varchar(1000) COLLATE utf8mb4_bin DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `restaurant_session_un` (`token`) USING HASH,
  KEY `restaurant_session_FK` (`restaurant_id`),
  CONSTRAINT `restaurant_session_FK` FOREIGN KEY (`restaurant_id`) REFERENCES `restaurant` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `restaurant_session`
--

LOCK TABLES `restaurant_session` WRITE;
/*!40000 ALTER TABLE `restaurant_session` DISABLE KEYS */;
INSERT INTO `restaurant_session` VALUES (7,5,'e7314b052aa572ba663a8ec453dca772b5323d0f0e9edd08e0b017f38a6cc831','2022-10-22 16:03:06'),(8,5,'5ec570a6170a2fe0e79aacff7e4251b369d2c49faf203cd1a972e5bf4e1c7bc2','2022-10-22 16:09:58'),(9,7,'f162f17d4416a275e8d6a36f02d2767f8c175106f61028a9025139be77748550','2022-10-24 12:47:41'),(10,7,'4f129b697f65ed78ccdd45c4c917a8f80ff8080cd012e0a146bc72a738998ed9','2022-10-24 12:48:16');
/*!40000 ALTER TABLE `restaurant_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'foodie_db'
--
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `add_client` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_client`(
email_input varchar(100),
first_name_input varchar(30),
last_name_input varchar(100),
image_url_input varchar(1000),
username_input varchar(30),
password_input varchar(30),
token_input varchar(1000),
salt_input varchar(100))
    MODIFIES SQL DATA
begin
	insert into client(email, first_name, last_name, image_url, username, password, created_at, salt)
	values (email_input, first_name_input, last_name_input, image_url_input, username_input,
	PASSWORD(CONCAT(password_input, salt_input)), now(), salt_input);
	insert into client_session(client_id, token, created_at)
	values (last_insert_id(), token_input, now());

	select cs.client_id , convert(cs.token using utf8) 
	from client_session cs
	where cs.id  = last_insert_id(); 
	commit;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `add_item_to_order` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_item_to_order`(
order_id_input int unsigned,
menu_item_id_input int unsigned)
    MODIFIES SQL DATA
begin
	insert into order_menu_item(order_id, menu_item_id)
	values (order_id_input, menu_item_id_input);
	select row_count();
	commit;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `add_menu_item` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_menu_item`(
description_input varchar(100),
image_url_input varchar(1000),
name_input varchar(30),
price_input decimal(10,0),
token_input varchar (100))
    MODIFIES SQL DATA
begin
	insert into menu_item (restaurant_id, description, image_url, name, price, created_at)
	select rs.restaurant_id, description_input, image_url_input, name_input, price_input, now()
	from restaurant_session rs
	where rs.token = token_input;
	select row_count();
	commit;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `add_restaurant` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_restaurant`(
email_input varchar(80),
name_input varchar(100),
address_input varchar(100),
phone_number_input varchar(11),
bio_input varchar(200),
city_input varchar(50),
profile_url_input varchar(1000),
banner_url_input varchar(1000),
password_input varchar(30),
token_input varchar(1000),
salt_input varchar(100))
    MODIFIES SQL DATA
begin
	insert into restaurant (email, name, address, phone_number, bio, city, profile_url, banner_url, password, created_at, salt)
	values (email_input, name_input, address_input, phone_number_input, bio_input, city_input, profile_url_input,
	banner_url_input,PASSWORD(CONCAT(password_input, salt_input)), now(), salt_input);

	insert into restaurant_session (restaurant_id, token, created_at)
	values (last_insert_id(), token_input, now());

	select rs.restaurant_id, convert(rs.token using utf8)
	from restaurant_session rs
	where rs.id = last_insert_id();  

	commit;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `client_order` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `client_order`(
token_input varchar(100),
restaurant_id_input int unsigned
)
    MODIFIES SQL DATA
begin
	insert into order_table(client_id, restaurant_id, created_at)
	select cs.client_id, restaurant_id_input, now()
	from client_session cs
	where cs.token = token_input;
	select last_insert_id(); 
	commit;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `complete_order` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `complete_order`(
token_input varchar(100),
order_id_input int unsigned,
is_complete_input tinyint(1))
    MODIFIES SQL DATA
begin
	update order_table ot
	inner join restaurant_session rs on rs.restaurant_id = ot.restaurant_id 
	set ot.is_complete = is_complete_input
	where rs.token = token_input and ot.id = order_id_input;
	select row_count();
	commit;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `confirm_order` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `confirm_order`(
token_input varchar(100),
order_id_input int unsigned,
is_confirmed_input tinyint(1))
    MODIFIES SQL DATA
begin
	update order_table ot
	inner join restaurant_session rs on rs.restaurant_id = ot.restaurant_id 
	set ot.is_confirmed = is_confirmed_input
	where rs.token = token_input and ot.id = order_id_input;
	select row_count();
	commit;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delete_client` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_client`(
password_input varchar(30),
token_input varchar(1000)
)
    MODIFIES SQL DATA
begin
	delete c from client c
	inner join client_session cs on c.id = cs.client_id 
	where cs.token = token_input and c.password = password_input;
	select row_count();
	commit;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delete_client_token` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_client_token`(token_input varchar(1000))
    MODIFIES SQL DATA
begin
	delete cs 
	from client_session cs
	where cs.token = token_input;
	select row_count();
	commit;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delete_menu_item` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_menu_item`(
menu_id_input int unsigned,
token_input varchar(100))
    MODIFIES SQL DATA
begin
	delete mi
	from menu_item mi
	inner join restaurant_session rs on rs.restaurant_id = mi.restaurant_id
	where rs.token = token_input and mi.id = menu_id_input;
	select row_count();
	commit;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delete_restaurant` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_restaurant`(
password_input varchar(30),
token_input varchar(1000))
    MODIFIES SQL DATA
begin
	delete r
	from restaurant r
	inner join restaurant_session rs on rs.restaurant_id = r.id 
	where rs.token = token_input and r.password = password_input;
	select row_count();
	commit;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delete_restaurant_token` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_restaurant_token`(token_input varchar(1000))
    MODIFIES SQL DATA
begin
	delete rs
	from restaurant_session rs
	where rs.token = token_input;
	select row_count();
	commit;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `edit_client` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `edit_client`(
email_input varchar(100),
first_name_input varchar(30),
last_name_input varchar(100),
image_url_input varchar(1000),
username_input varchar(30),
password_input varchar(30),
token_input varchar(1000))
    MODIFIES SQL DATA
begin
	update client c
	inner join client_session cs on c.id = cs.client_id 
	set c.email = email_input, c.first_name = first_name_input , c.last_name = last_name_input,
	c.image_url = image_url_input, c.username = username_input, c.password = password_input
	where cs.token = token_input;
	select row_count();
	commit;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `edit_menu_item` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `edit_menu_item`(
description_input varchar(100),
image_url_input varchar(1000),
name_input varchar(30),
price_input decimal(10,0),
token_input varchar(100),
menu_id_input int unsigned
)
    MODIFIES SQL DATA
begin
	update menu_item mi
	inner join restaurant_session rs on rs.restaurant_id = mi.restaurant_id
	set mi.description = description_input, mi.image_url = image_url_input, mi.name = name_input, mi.price = price_input
	where rs.token = token_input and mi.id = menu_id_input;
	select row_count();
	commit;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `edit_rated_order` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `edit_rated_order`(
order_id_input int unsigned,
rate_input int unsigned,
token_input varchar(100))
    MODIFIES SQL DATA
begin
	update order_rating ora 
	inner join client_session cs on cs.client_id = ora.client_id 
	set ora.rate = rate_input
	where ora.order_table_id = order_id_input and cs.token = token_input;
	select row_count();
	commit;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `edit_restaurant` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `edit_restaurant`(
email_input varchar(80),
name_input varchar(100),
address_input varchar(100),
phone_number_input varchar(11),
bio_input varchar(200),
city_input varchar(50),
profile_url_input varchar(1000),
banner_url_inout varchar(1000),
password_input varchar(30),
token_input varchar(1000))
    MODIFIES SQL DATA
begin
	update restaurant r 
	inner join restaurant_session rs on r.id = rs.restaurant_id 
	set r.email = email_input, r.name = name_input, r.address = address_input, r.phone_number = phone_number_input,
	r.bio = bio_input, r.city = city_input, r.profile_url = profile_url, r.banner_url = banner_url, r.password = password_input
	where rs.token = token_input;
	select row_count();
	commit;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_all_client_order` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_all_client_order`(token_input varchar(100))
begin
	select ot.id, mi.restaurant_id, ot.is_confirmed, ot.is_complete, convert(mi.name using utf8), mi.price, omi.menu_item_id,
	convert(mi.description using utf8), convert(mi.image_url using utf8)
	from client_session cs
	inner join order_table ot on ot.client_id = cs.client_id
	inner join order_menu_item omi on omi.order_id = ot.id 
	inner join menu_item mi on mi.id = omi.menu_item_id
	where cs.token = token_input;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_all_completed_order` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_all_completed_order`(token_input varchar(100))
begin
	select ot.is_complete, ot.is_confirmed, convert(mi.name using utf8), mi.price, omi.menu_item_id, ot.id
	from client_session cs
	inner join order_table ot on ot.client_id = cs.client_id
	inner join order_menu_item omi on omi.order_id = ot.id 
	inner join menu_item mi on mi.id = omi.menu_item_id
	where cs.token = token_input and ot.is_complete  = 1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_all_confirmed_orders` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_all_confirmed_orders`(token_input varchar(100))
begin
	select ot.is_complete, ot.is_confirmed, convert(mi.name using utf8), mi.price, omi.menu_item_id, ot.id
	from client_session cs
	inner join order_table ot on ot.client_id = cs.client_id
	inner join order_menu_item omi on omi.order_id = ot.id 
	inner join menu_item mi on mi.id = omi.menu_item_id
	where cs.token = token_input and ot.is_confirmed = 1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_all_rated_orders` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_all_rated_orders`(token_input varchar(100))
begin
	select ora.order_table_id, ot.restaurant_id, ora.rate, convert(mi.name using utf8), convert(mi.image_url using utf8),
	mi.price, convert(mi.description using utf8), mi.id 
	from order_rating ora
	inner join order_table ot on ot.id = ora.order_table_id
	inner join order_menu_item omi on omi.order_id = ot.id
	inner join menu_item mi on mi.id = omi.menu_item_id 
	inner join client_session cs on ora.client_id = cs.client_id 
	where cs.token = token_input;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_all_restaurant_order` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_all_restaurant_order`(token_input varchar(100))
begin
	select ot.is_complete, ot.is_confirmed, convert(mi.name using utf8), mi.price, omi.menu_item_id, ot.id
	from restaurant_session rs
	inner join order_table ot on ot.restaurant_id = rs.restaurant_id 
	inner join order_menu_item omi on omi.order_id = ot.id 
	inner join menu_item mi on mi.id = omi.menu_item_id
	where rs.token = token_input;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_client` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_client`(id_input int unsigned)
begin
	select convert(created_at using utf8), convert(email using utf8), convert(first_name  using utf8), convert(last_name using utf8),
	id, convert(image_url  using utf8), convert(username  using utf8)
	from client c
	where c.id = id_input;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_client_by_token` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_client_by_token`(token_input varchar(1000))
begin
	select convert(c.email using utf8), convert(c.first_name using utf8), convert(c.last_name using utf8),
	convert(c.image_url using utf8), convert(c.username using utf8), convert(c.password using utf8)
	from client c
	inner join client_session cs on c.id = cs.client_id 
	where cs.token = token_input;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_menu_item` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_menu_item`(restaurant_id_input int unsigned)
begin
	select mi.id, convert(mi.description using utf8), convert(mi.image_url using utf8), convert(mi.name using utf8), mi.price 
	from menu_item mi
	where mi.restaurant_id = restaurant_id_input;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_menu_item_by_token` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_menu_item_by_token`(token_input varchar(100))
begin
	select mi.id, convert(mi.description using utf8), convert(mi.image_url using utf8), convert(mi.name using utf8), 
	convert(mi.price using utf8)
	from menu_item mi
	inner join restaurant_session rs on rs.restaurant_id  = mi.restaurant_id
	where rs.token = token_input;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_restaurant` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_restaurant`(restaurant_id_input int unsigned)
begin
	select convert(r.name using utf8), convert(r.name using utf8), convert(r.address using utf8), convert(r.phone_number using utf8), 
	convert(r.bio using utf8), convert(r.city using utf8), convert(r.profile_url using utf8), convert(r.banner_url using utf8), r.id 
	from restaurant r
	where r.id = restaurant_id_input;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_restaurant_by_token` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_restaurant_by_token`(token_input varchar(1000))
begin
	select convert(r.email using utf8), convert(r.name using utf8), convert(r.address using utf8), 
	convert(r.phone_number using utf8), convert(r.bio using utf8), convert(r.city using utf8), 
	convert(r.profile_url using utf8), convert(r.banner_url using utf8), convert(r.password using utf8) 
	from restaurant r
	inner join restaurant_session rs on r.id = rs.restaurant_id 
	where rs.token = token_input;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `log_in_client` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `log_in_client`(
email_input varchar(100),
password_input varchar(30),
token_input varchar(1000))
    MODIFIES SQL DATA
begin	
	
	insert into client_session(client_id, token, created_at)
	select c.id, token_input, now()
	from client c
	where c.email = email_input and
	c.password = PASSWORD(concat(password_input, (select salt from client c where c.email = email_input)));

	select cs.client_id , convert(cs.token using utf8) 
	from client_session cs
	where cs.token = token_input;

	commit;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `log_in_restaurant` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `log_in_restaurant`(
email_input varchar(80),
password_input varchar(100),
token_input varchar(1000))
    MODIFIES SQL DATA
begin
	insert into restaurant_session(restaurant_id, token, created_at)
	select r.id, token_input, now()
	from restaurant r
	where r.email = email_input and
	r.password = PASSWORD(CONCAT(password_input, (select r.salt from restaurant r where r.email = email_input)));

	select rs.restaurant_id, convert(token using utf8)
	from restaurant_session rs
	where rs.token = token_input;
	commit;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `rate_order` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `rate_order`(
order_id_input int unsigned,
rate_input int unsigned,
token_input varchar(100))
    MODIFIES SQL DATA
begin
	insert into order_rating(client_id, order_table_id, rate)
	select cs.client_id, order_id_input, rate_input
	from client_session cs
	inner join order_table ot on ot.client_id = cs.client_id 
	where cs.token = token_input and ot.id = order_id_input and ot.is_complete = 1;
	select row_count();
	commit;
END ;;
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

-- Dump completed on 2022-10-27 10:32:45
